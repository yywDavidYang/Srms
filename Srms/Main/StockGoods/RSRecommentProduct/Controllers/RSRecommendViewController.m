//
//  RSRecommendViewController.m
//  Srms
//
//  Created by YYW on 16/7/17.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSRecommendViewController.h"
#import "ProductViewController.h"
#import "ShopCollectionViewCell.h"
@interface RSRecommendViewController (){

    UITextField * searchText;// 搜索框
    NSString  * condictionStrText;//搜索参数
    NSIndexPath *selectIndexPath;// 选中的cell
    NSString *selectedGoodsNo;
    UIView *categoryBackView;// 分类下拉背景view
    UIScrollView * catoScrollView;// 分类滚动栏
    UIView * topView ;//顶部栏
}

@end

@implementation RSRecommendViewController

-(void)viewWillAppear:(BOOL)animated{
    [self httpRequestGoodscategory];
    [self addNotificationObserver];
    [self setNavigationModel];
}
// 设置导航栏的样式
- (void) setNavigationModel{
    self.tabBarController.tabBar.hidden = YES;
    self.currentNavigationController.titleText = @"同行推荐";
    [self.currentNavigationController setDIYNavigationBarHidden:NO];
    self.currentNavigationController.isHideReturnBtn = YES;
    [self.currentNavigationController setNavigationScreenButtonHidden:NO];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    selectIndexPath = nil;
    selectedGoodsNo = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    [self layOutTopView];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((self.view.frame.size.width-100)/5, (self.view.frame.size.width-100)/5+35);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0.f, 0, 9.f, 0);
    shopCellView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    shopCellView.delegate= self;
    shopCellView.dataSource=self;
    shopCellView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shopCellView];
    [shopCellView registerNib:[UINib nibWithNibName:@"ShopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [shopCellView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.equalTo(self.view.mas_top).offset(125);
        make.left.equalTo(self.view).offset(5);
        make.right.equalTo(self.view).offset(-5);
        make.bottom.equalTo(self.view);
    }];
    
    // 分类下拉
    
    categoryBackView = [[UIView alloc]init];
    categoryBackView.frame = self.view.frame;
    categoryBackView.hidden = YES;
    categoryBackView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCategoryViewTap)];
    [categoryBackView addGestureRecognizer:tap];
    [self.view addSubview:categoryBackView];
    catoaryTableView =[[UITableView alloc] initWithFrame:CGRectMake(5, 85, 120, 240) style:UITableViewStylePlain];
    catoaryTableView.delegate = self;
    catoaryTableView.dataSource = self;
    catoaryTableView.hidden = YES;
    catoaryTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:catoaryTableView];
}

-(void)layOutTopView{
    topView =[[UIView alloc] initWithFrame:CGRectMake(5,45, self.view.frame.size.width-10, 50)];
    classButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 10, 120, 30)];
    [classButton setTitle:@"品牌" forState:UIControlStateNormal];
    [classButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [classButton setBackgroundImage:[UIImage imageNamed:@"btn8_01"] forState:UIControlStateNormal];
    [classButton addTarget:self action:@selector(classliyClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:classButton];
    
    //
    searchText =[[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-270, 10, 160, 30)];
    searchText.textAlignment = NSTextAlignmentLeft;
    searchText.background =[UIImage imageNamed:@"btn8_02"];
    searchText.font =[UIFont systemFontOfSize:13.0f];
    searchText.placeholder = @"按商品号，商品名称查询";
    searchText.textColor = [UIColor blackColor];
    
    [topView addSubview:searchText];
    
    UIButton * searchButton =[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-110, 10, 34, 30)];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"btn8_03"] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButton:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:searchButton];
    [self.view addSubview:topView];
    
    UIImageView * imageView1 =[[UIImageView alloc] init];
    imageView1.image = [UIImage imageNamed:@"lift56"];
    [topView addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.right.equalTo(topView);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(topView).offset(0);
    }];
    [self.view addSubview:topView];
    
}

-(void)categoryLayout{
    condictionStrText = @"";
    categoryNameString = @"";
    if (_dataDictionary.count > 0) {
        NSDictionary * dic =[_dataDictionary objectAtIndex:0];
        NSArray * arr =[dic objectForKey:@"categorys"];
        categoryNameString = [dic objectForKey:@"categoryName"];
        categoryString =[arr objectAtIndex:0];
        sortKeyString = @"3";
        if (_catoryString.length <= 0 || _catoryString == nil ) {
            _catoryString = @"TH";
        }else{
            
            if ([_catoryString isEqualToString:@"TH"]) {
                _catoryString = @"TH";
            }else{
                _catoryString = _catoryOtherString;
                
            }
            
        }
        [self scrollViewLayoutWithArray:@[categoryString]];
        [self httpRequestgetGoodsbyfliter];
    }
}

-(void)scrollViewLayoutWithArray:(NSArray *)cateArray{
    
    if (catoScrollView) {
        
        [catoScrollView removeFromSuperview];
        catoScrollView = nil;
    }
    
    catoScrollView =[[UIScrollView alloc] init];
    catoScrollView.contentSize = CGSizeMake(80*cateArray.count, 30);
    catoScrollView.showsHorizontalScrollIndicator = YES;
    catoScrollView.showsVerticalScrollIndicator = YES;
    catoScrollView.delegate = self;
    [self.view addSubview:catoScrollView];
    [catoScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(self.view.mas_left).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.top.equalTo(topView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    [self.view bringSubviewToFront:catoaryTableView];
    [self.view insertSubview:categoryBackView belowSubview:catoaryTableView];
    UIButton *lastCatebtn;
    UIButton *firstBtn ;
    for (int i = 0; i < cateArray.count; i++) {
        
        UIButton * categoryButton =[[UIButton alloc] init];
        NSString * titleString =[NSString stringWithFormat:@"%@",[cateArray objectAtIndex:i]];
        categoryButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [categoryButton setTitle:titleString forState:UIControlStateNormal];
        [categoryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [categoryButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
        [categoryButton addTarget:self action:@selector(categoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        categoryButton.tag =i;
        [catoScrollView addSubview:categoryButton];
        if (cateArray.count == 1) {
            
            [categoryButton setUserInteractionEnabled:NO];
        }
        [categoryButton mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.centerY.equalTo(catoScrollView.mas_centerY).offset(0);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(80);
            make.left.equalTo(lastCatebtn?lastCatebtn.mas_right:catoScrollView.mas_right).offset(5);
        }];
        lastCatebtn = categoryButton;
        if (i == 0) {
            
            firstBtn = categoryButton;
        }
    }
    
    categoryBackImage =[[UIImageView alloc] init];
    categoryBackImage.backgroundColor = RGBA(140, 188, 72, 1.0f);
    [firstBtn addSubview:categoryBackImage];
    [categoryBackImage mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.bottom.equalTo(firstBtn.mas_bottom).offset(0);
        make.left.equalTo(firstBtn.mas_left).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(2);
    }];
    
    UIImageView * imageView2 =[[UIImageView alloc]init];
    imageView2.image = [UIImage imageNamed:@"lift56"];
    [self.view addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.right.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(5);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(catoScrollView).offset(0);
    }];
    
}

//接收通知
- (void) addNotificationObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"RSClassifyPopView" object:nil];
}

- (void)notificationAction:(NSNotification *)noti{
    
    if ([noti.name isEqualToString:@"RSClassifyPopView"]) {
        selectIndexPath = nil;
        NSArray *dicArray = noti.userInfo[@"dic"];
        NSLog(@"获取到的数据 ＝ %@",dicArray);
        [self getGoodsDataWithParamsArray:dicArray];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    return view;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return _dataDictionary.count;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 49;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSDictionary * dic =[_dataDictionary objectAtIndex:indexPath.row];
    
    UILabel * textLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    textLabel.text =[ dic objectForKey:@"categoryName"];
    textLabel.font=[UIFont boldSystemFontOfSize:15.0f];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:textLabel];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    categoryDic =[_dataDictionary objectAtIndex: indexPath.row];
    categoryArray =[categoryDic objectForKey:@"categorys"];
    categoryNameString = [categoryDic objectForKey:@"categoryName"];
    [classButton setTitle:categoryNameString forState:UIControlStateNormal];
    [self scrollViewLayoutWithArray:categoryArray];
    categoryBackView.hidden = YES;
    catoaryTableView.hidden = YES;
    [catoaryTableView reloadData];
    
    categoryString =[NSString stringWithFormat:@"%@",[categoryArray objectAtIndex:0]];
    [self httpRequestgetGoodsbyfliter];
    
}
-(void)categoryBtnClick:(UIButton * )sender{
    selectIndexPath = nil;
    NSLog(@"categoryNameString = %@, categoryString = %@",categoryNameString,categoryString);
    [sender addSubview:categoryBackImage];
    [categoryBackImage mas_updateConstraints:^(MASConstraintMaker *make){
        
        make.bottom.equalTo(sender.mas_bottom).offset(0);
        make.left.equalTo(sender.mas_left).offset(10);
    }];
    categoryNameString = [categoryDic objectForKey:@"categoryName"];
    categoryString =[NSString stringWithFormat:@"%@",[categoryArray objectAtIndex:sender.tag]];
    [self httpRequestgetGoodsbyfliter];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.view.frame.size.width-100)/5, (self.view.frame.size.width-100)/5*1.2);
    
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15,15,15);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary * dic = [_dataArray objectAtIndex:indexPath.item];
    cell.titleLabel.text = [dic objectForKey:@"goodsName"];
//    [cell.shopImage sd_setImageWithURL:[dic objectForKey:@"mainPictureUrl"]];
    __block SDPieLoopProgressView *progressView;
    [cell.shopImage sd_setImageWithURL:[dic objectForKey:@"mainPictureUrl"] placeholderImage:[UIImage imageNamed:@"err"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (progressView == nil) {
                
                progressView = [[SDPieLoopProgressView alloc]init];
                progressView.frame = CGRectMake(0, 0, 50, 50);
                progressView.center = cell.shopImage.center;
                [cell.shopImage addSubview:progressView];
            }
            progressView.progress = (float) receivedSize/ (float)expectedSize;
        });
    }completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){

        for (UIView * view in cell.shopImage.subviews) {
            
            if ([view isKindOfClass:[SDPieLoopProgressView class]]) {
                
                [view removeFromSuperview];
            }
        }
    }];
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@.00",[dic objectForKey:@"dpPrice"]];
    cell.numberLabel.text = [NSString stringWithFormat:@"%@件起批",[dic objectForKey:@"qpQty"]];
    cell.shopImage.contentMode = UIViewContentModeScaleAspectFit;
    
    cell.contentView.backgroundColor =[UIColor whiteColor];
    // 获取选中数据,防止数据改变后，对应的item发生改变
    if(selectedGoodsNo){
      
        if ([selectedGoodsNo isEqualToString:[dic objectForKey:@"goodsNo"]]) {
            
            cell.contentView.backgroundColor =[UIColor orangeColor];
            selectIndexPath = indexPath;
        }
        else{
            
            cell.contentView.backgroundColor =[UIColor whiteColor];
        }
    }else{
        
        cell.contentView.backgroundColor =[UIColor whiteColor];
    }
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = [_dataArray objectAtIndex:indexPath.item];
    NSString * string =[dic objectForKey:@"goodsNo"];
    selectedGoodsNo = string;
    NSString * mainPicString =[dic objectForKey:@"mainPictureUrl"];
    ShopCollectionViewCell * cellCancel = (ShopCollectionViewCell *)[shopCellView cellForItemAtIndexPath:selectIndexPath];
    cellCancel.contentView.backgroundColor = [UIColor whiteColor];
    
    ShopCollectionViewCell * cell = (ShopCollectionViewCell *)[shopCellView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    selectIndexPath = indexPath;
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        ProductViewController * serverView = [[ProductViewController alloc] init];
        serverView.hidesBottomBarWhenPushed = YES;
        serverView.goodNoString = string;
        serverView.disPriceString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dpPrice"]];
        serverView.mainPictureUrlString = mainPicString;
        serverView.currentNavigationController = self.currentNavigationController;
        [self.currentNavigationController pushViewController:serverView animated:YES];
    });
}

//隐藏下拉分类
- (void) hideCategoryViewTap{
    
    categoryBackView.hidden = YES;
    catoaryTableView.hidden = YES;
}

//品牌的跳转
-(void)classliyClick{
     selectIndexPath = nil;
    categoryBackView.hidden = NO;
    catoaryTableView.hidden = NO;
    [self.view bringSubviewToFront:catoaryTableView];
    [self.view insertSubview:categoryBackView belowSubview:catoaryTableView];
}
//搜索
-(void)searchButton:(NSString *) string{
    condictionStrText = searchText.text;
    [self httpRequestgetGoodsbyfliter];
}
//获取商品分类的请求
-(void)httpRequestGoodscategory{
    NSString * serve =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/common/goodscategory",serve];
    [[RSNetworkManager sharedManager] POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        _dataDictionary =[dic objectForKey:@"data"];
        if (_dataDictionary.count>0) {
            
            [self categoryLayout];
            
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//获取商品信息的请求
-(void)httpRequestgetGoodsbyfliter{
    
    NSArray * array = @[@{@"categoryName":categoryNameString,@"categorys":@[categoryString]}];
    [self getGoodsDataWithParamsArray:array];
}

- (void)getGoodsDataWithParamsArray:(NSArray *)array{
    
    NSString * serve =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * channelCode =[PublicKit getPlistParameter:channelCodeString];
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/goods/getGoodsbyfliter",serve];

    NSDictionary *parameters = @{@"categoryList":array,@"channelCode":channelCode,@"condictionStr":condictionStrText,@"replenishType":_catoryString,@"pageIndex":@"1",@"sortDirect":@"1",@"sortKey":sortKeyString};
    [self loadProgressViewIsShow:YES];// 隐藏提示框
    [[RSNetworkManager sharedManager] POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        if ([[dic objectForKey:@"data"] isEqual:[NSNull null]]) {
            _dataArray = nil;
            [catoaryTableView reloadData];
            [self loadProgressViewIsShow:NO];// 隐藏提示框
            
        }else{
            _dataArray =[dic objectForKey:@"data"];
            //            if (_dataArray.count>0) {
            [catoaryTableView reloadData];
            [shopCellView reloadData];
            
            //            }
        }
        [self loadProgressViewIsShow:NO];// 隐藏提示框
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [self loadProgressViewIsShow:NO];// 隐藏提示框
    }];
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

@end
