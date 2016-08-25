//
//  RSMatchedViewController.m
//  Srms
//
//  Created by ohm on 16/8/10.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSMatchedViewController.h"
#import "MatchedCollectionViewCell.h"
#import "MatchedShopViewController.h"
@interface RSMatchedViewController (){

    UIView * matchedView;
    UIButton * recommendMatchedBtn;
    UIButton * myMatchedBtn;
    UICollectionView * matchedCellTabView;
    UIView * enitView ;
    UIView * delegetView;
    UIView * bigView;
    UIButton * delegetBtn;
    NSMutableArray * selectArray;//选中的方案集合
    BOOL isDisSelected;
    NSIndexPath * selectIndexPath;
    UIButton *editButton;// 顶部编辑按钮
    NSMutableArray *indexPathArray;// 选中的按钮数组

}
@property (nonatomic , copy)NSString * typeString;
@property (nonatomic , copy)NSString * flagString;
@end

@implementation RSMatchedViewController

-(void)viewWillAppear:(BOOL)animated{
    isDisSelected = YES;
    [self setNavigationModel];
}
// 设置导航栏的样式
- (void) setNavigationModel{
    self.tabBarController.tabBar.hidden = YES;
    self.currentNavigationController.titleText = @"搭配";
    [self.currentNavigationController setDIYNavigationBarHidden:NO];
    self.currentNavigationController.isHideReturnBtn = YES;
    [self.currentNavigationController setNavigationScreenButtonHidden:YES];
}

- (void) initData{
    
    _typeString = @"1";
    _flagString = @"1";
    selectIndexPath= nil;
    selectArray = [[NSMutableArray alloc] init];
    indexPathArray = [NSMutableArray array];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self loadTopViewButton];
    [self layOutMatchedTab];
    [self httpGetAssortPlan];
}
// 设置顶部按钮
- (void) loadTopViewButton{
    
    UIView * lineView =[[UIView alloc] initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.7;
    [self.view addSubview:lineView];
    // 推荐搭配按钮
    recommendMatchedBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-120, 54, 100, 40)];
    [recommendMatchedBtn.titleLabel setFont:[UIFont systemFontOfSize:20 weight:2]];
    recommendMatchedBtn.tag = 1000;
    recommendMatchedBtn.selected = NO;
    [recommendMatchedBtn setTitle:@"推荐搭配" forState:UIControlStateNormal];
    [recommendMatchedBtn setTitleColor:RGBA(57,127,60,1) forState:UIControlStateNormal];
    [recommendMatchedBtn addTarget:self action:@selector(recommendClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recommendMatchedBtn];
    // 我的搭配按钮
    myMatchedBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+20, 54, 100, 40)];
    myMatchedBtn.tag = 1001;
    myMatchedBtn.selected = NO;
    [myMatchedBtn.titleLabel setFont:[UIFont systemFontOfSize:20 weight:2]];
    [myMatchedBtn setTitle:@"我的搭配" forState:UIControlStateNormal];
    [myMatchedBtn setTitleColor:[UIColor grayColor] forState:0];
    [myMatchedBtn addTarget:self action:@selector(recommendClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myMatchedBtn];
    
    // 按钮底部滚动线
    matchedView = [[UIView alloc] init];
    matchedView.frame = CGRectMake(recommendMatchedBtn.frame.origin.x, 100, 100, 4);
    matchedView.backgroundColor = RGBA(57,127,60,1);
    [self.view addSubview:matchedView];
    
    // 编辑按钮
    editButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width- 140, 60, 30, 30)];
    editButton.hidden = YES;
    editButton.selected = NO;
    [editButton setBackgroundImage:[UIImage imageNamed:@"enitImage"] forState:UIControlStateNormal];
    [editButton setBackgroundImage:[UIImage imageNamed:@"enitImage2"] forState:UIControlStateSelected];
    [editButton addTarget:self action:@selector(enitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editButton];
}

// 创建搭配列表
-(void)layOutMatchedTab{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((self.view.frame.size.width - 90)/4, (self.view.frame.size.width-90)/4);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0.f, 0, 0.f, 0);
    matchedCellTabView=[[UICollectionView alloc] initWithFrame:CGRectMake(5, 105, self.view.frame.size.width - 65, self.view.frame.size.height-100)collectionViewLayout:layout];
    matchedCellTabView.delegate= self;
    matchedCellTabView.dataSource=self;
    matchedCellTabView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:matchedCellTabView];
    [matchedCellTabView registerNib:[UINib nibWithNibName:@"MatchedCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    // 删除按钮
    delegetBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-140, self.view.frame.size.height-100, 50, 50)];
    delegetBtn.hidden = YES;
    [delegetBtn setBackgroundImage:[UIImage imageNamed:@"delegetimage2"] forState:UIControlStateNormal];
    delegetBtn.tag =1000;
    [delegetBtn addTarget:self action:@selector(delegetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delegetBtn];
}
// 推荐搭配与我的搭配切换
-(void)recommendClick:(UIButton *)sender{
    
    if (sender.tag == 1000) {
        isDisSelected = YES;
        editButton.hidden = YES;
        editButton.selected = NO;
        delegetBtn.hidden = YES;
        [sender setTitleColor:RGBA(57,127,60,1) forState:UIControlStateNormal];
        [myMatchedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        matchedView.frame = CGRectMake(sender.frame.origin.x, 100, 100, 4);
        _typeString = @"1";
        _flagString = @"1";
        [matchedCellTabView reloadData];
        [self httpGetAssortPlan];
        
    }else if(sender.tag == 1001){
        editButton.hidden = NO;
        delegetBtn.hidden = YES;
        editButton.selected = NO;
        [recommendMatchedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [sender setTitleColor:RGBA(57,127,60,1) forState:UIControlStateNormal];
         matchedView.frame = CGRectMake(sender.frame.origin.x, 100, 100, 4);
    
        _typeString = @"0";
        _flagString = @"0";
         [matchedCellTabView reloadData];
        [self httpGetAssortPlan];
    }
}
//编辑按钮的方法
-(void)enitBtnClick:(UIButton * )sender{
    
    if (!sender.selected) {
        isDisSelected = NO;
        delegetBtn.hidden = NO;
        [matchedCellTabView reloadData];
        
    }else{
        isDisSelected = YES;
        delegetBtn.hidden = YES;
        for (NSInteger i = 0; i < indexPathArray.count; i ++) {
            
            if ([indexPathArray[i] isEqualToString:@"1"]) {
                
                [indexPathArray replaceObjectAtIndex:i withObject:@"1"];
            }
        }
        [matchedCellTabView reloadData];
    }
        
    sender.selected = !sender.selected;
}

-(void)delegetBtnClick:(UIButton *)sender{
    
    if (selectArray.count>0) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"是否确定删除该搭配方案" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    switch (buttonIndex) {
        case 1:{
            [self httpGetDelegetAssortPlan];
            
        }
            break;
        case 0:{
        }
        default:
            break;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width-90)/4, (self.view.frame.size.width-90)/4);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10,10,10);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MatchedCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary * dic = [_dataArray objectAtIndex:indexPath.item];
    cell.titleNameLabel.text = [dic objectForKey:@"pname"];
    
    NSString * imageStrng =[NSString stringWithFormat:@"%@",[dic objectForKey:@"pimage"]];
    NSData *decodedImageData   = [[NSData alloc] initWithBase64EncodedString:imageStrng options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage      = [UIImage imageWithData:decodedImageData];
    cell.imageShop.image = decodedImage;
    cell.imageShop.backgroundColor = [UIColor whiteColor];
    cell.selectBtn.hidden = isDisSelected;
    cell.selectBtn.tag = indexPath.item;
    if (indexPathArray.count > 0) {
        if ([indexPathArray[indexPath.item] isEqualToString:@"1"]) {
        
            [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"selectImage2"] forState:UIControlStateSelected];
            cell.selectBtn.selected = YES;
            
        }else {
        
            [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"selectImage1"] forState:UIControlStateNormal];
            cell.selectBtn.selected = NO;
        }
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!editButton.selected) {
        NSDictionary * dic = [_dataArray objectAtIndex:indexPath.item];
        NSString * pidString = [dic objectForKey: @"pid"];
    
        MatchedShopViewController * matchView = [[MatchedShopViewController alloc] init];
        matchView.pidString = [NSString stringWithFormat:@"%@",pidString] ;
        matchView.hidesBottomBarWhenPushed = YES;
        matchView.currentNavigationController = self.currentNavigationController;
        [self.currentNavigationController pushViewController:matchView animated:YES];
    }else{
        MatchedCollectionViewCell *cell = (MatchedCollectionViewCell *)[matchedCellTabView cellForItemAtIndexPath:indexPath];
         NSString * pidString = nil;
        
        if (!cell.selectBtn.selected) {
            
            [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"selectImage2"] forState:UIControlStateSelected];
            NSDictionary * dic = [_dataArray objectAtIndex:cell.selectBtn.tag];
            pidString  = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pid"]];
            NSMutableDictionary * selcectDic =[[NSMutableDictionary alloc] init];
            [selcectDic setObject:pidString forKey:@"pid"];
            [selectArray addObject:selcectDic];
            [indexPathArray replaceObjectAtIndex:indexPath.item withObject:@"1"];
            
        }else{
            
            [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"selectImage1"] forState:0];
            NSDictionary * dic = [_dataArray objectAtIndex:cell.selectBtn.tag];
            pidString  = [NSString stringWithFormat:@"%@",[dic objectForKey:@"pid"]];
            
            for (NSMutableDictionary * dictionary  in selectArray) {
                
                NSString * string = [dictionary objectForKey:@"pid"];
                if ([pidString isEqual:string]) {
                    [selectArray removeObject:dictionary];
                    [indexPathArray replaceObjectAtIndex:indexPath.item withObject:@"0"];
                    break;
                }
            }
        }
        cell.selectBtn.selected = !cell.selectBtn.selected;
    }
}

//获取搭配的请求（我的搭配，请求搭配）
-(void)httpGetAssortPlan{

    NSString * serveSreing =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * userNoString =[PublicKit getPlistParameter:NameTextString];
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/assort/getAssortPlan",serveSreing];
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:userNoString forKey:@"userNo"];
    [parameters setObject:@"-1" forKey:@"status"];
    [parameters setObject:_typeString forKey:@"type"];
    [parameters setObject:_flagString forKey:@"flag"];

    [self loadProgressViewIsShow:YES];
    [[RSNetworkManager sharedManager] POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        
        _dataArray = [dic objectForKey:@"msg"];
        [indexPathArray removeAllObjects];
        for (NSInteger i = 0; i < _dataArray.count; i ++) {
            
            [indexPathArray addObject:@"0"];
        }
        [matchedCellTabView reloadData];
        [self loadProgressViewIsShow:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self loadProgressViewIsShow:NO];
    }];
}
    
//获取删除搭配的请求
-(void)httpGetDelegetAssortPlan{
    
    NSString * serveSreing =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * userNoString =[PublicKit getPlistParameter:NameTextString];
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/assort/deleteAssortPlan",serveSreing];
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:userNoString forKey:@"userNo"];
    [parameters setObject:selectArray forKey:@"assortPlan"];
    [[RSNetworkManager sharedManager] POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        [self showLoadProgressViewWithMessage:dic[@"msg"] delay:3];
        [selectArray removeAllObjects];
        [self httpGetAssortPlan];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [self showLoadProgressViewWithMessage:@"删除失败" delay:3];
    }];
    
}



@end
