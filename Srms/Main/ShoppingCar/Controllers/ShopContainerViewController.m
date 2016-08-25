//
//  ShopContainerViewController.m
//  Srms
//
//  Created by ohm on 16/7/20.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "ShopContainerViewController.h"
#import "ProductViewController.h"
#import "ShopContainerTableViewCell.h"
#import "ProductData.h"
#import "SizeData.h"
//base64加密
#define MYBase(str) [[str dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]
@interface ShopContainerViewController (){

    UITableView * cartTableView ;
    NSString * allNumberstring ;
    NSString * allMoneystring ;
    NSString * Numberstring ;
    NSString * Moneystring;
    UIButton* allSelectButton;
    
    int  sumNum;//记录是否全选商品；
    
    int  shopSelectNum;
    
    int shopDeleget ; //  记录是否删除商品
    
    NSMutableArray *  allPassShopArray;
}
@property (nonatomic, weak) UIView *coverView;//一个遮罩的view
@property (nonatomic, retain) NSString *trueString;//是否评论

@end
NSMutableArray * seartchDataArray;
ProductData * shopLocalcont;

@implementation ShopContainerViewController

- (void) viewWillAppear:(BOOL)animated{
    
    [self setNavigationModel];
    [self httpGetOrders];
    [self.currentNavigationController setShoppingCarButtonInteraction:NO];
}

- (void) setNavigationModel{
    
    [self.currentNavigationController setDIYNavigationBarHidden:NO];
    self.currentNavigationController.isHideReturnBtn = NO;
    self.currentNavigationController.titleText = @"补货池";
    [self.currentNavigationController setNavigationScreenButtonHidden:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [self.currentNavigationController setShoppingCarButtonInteraction:YES];
    [self deleteShoppingCar];
}

- (void) deleteShoppingCar{
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.currentNavigationController.viewControllers];
    for (UIViewController *VC in array) {
        
        if ([VC isKindOfClass:[ShopContainerViewController class]]) {
            
            [array removeObject:VC];
            break;
        }
    }
    self.currentNavigationController.viewControllers  = array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self headerViewAutoLayout];
}

- (void) headerViewAutoLayout{
    
    // Do any additional setup after loading the view from its nib.
    sumNum = 0;
    _dataArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(5, 50, SIZEwidth-5, 60)];
    view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:view];
    
    UIImageView* image =[[UIImageView alloc] initWithFrame:CGRectMake(60, 50, SIZEwidth-60, 60)];
    image.image = [UIImage imageNamed:@"brgoud3"];
    [view addSubview:image];
    
    allSelectButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    allSelectButton.selected = YES;
    [allSelectButton setBackgroundImage:[UIImage imageNamed:@"circular2"] forState:UIControlStateSelected];
    [allSelectButton setBackgroundImage:[UIImage imageNamed:@"circular1"] forState:0];
    [allSelectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:allSelectButton];
    
    UILabel * allLabel =[[UILabel alloc] initWithFrame:CGRectMake(60, 20, 40, 20)];
    allLabel.text = @"全部";
    allLabel.textColor = [UIColor blackColor];
    allLabel.font = [UIFont systemFontOfSize:17.0];
    allLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:allLabel];
    
    UILabel * shopLabel =[[UILabel alloc] initWithFrame:CGRectMake(180, 20,80, 20)];
    shopLabel.text = @"商品信息";
    shopLabel.textColor = [UIColor blackColor];
    shopLabel.font = [UIFont systemFontOfSize:17.0];
    shopLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:shopLabel];
    
    
    UILabel * priceLabel =[[UILabel alloc] initWithFrame:CGRectMake(SIZEwidth-630, 20, 80, 20)];
    priceLabel.text = @"价格";
    priceLabel.textColor = [UIColor blackColor];
    priceLabel.font = [UIFont systemFontOfSize:17.0];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:priceLabel];
    
    UILabel * numberLabel =[[UILabel alloc] initWithFrame:CGRectMake(SIZEwidth-550, 20, 100, 20)];
    numberLabel.text = @"数量";
    numberLabel.textColor = [UIColor blackColor];
    numberLabel.font = [UIFont systemFontOfSize:17.0];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:numberLabel];
    
    
    UILabel * dpPriceLabel =[[UILabel alloc] initWithFrame:CGRectMake(SIZEwidth-450, 20, 150, 20)];
    dpPriceLabel.text = @"折扣";
    dpPriceLabel.textColor = [UIColor blackColor];
    dpPriceLabel.font = [UIFont systemFontOfSize:17.0];
    dpPriceLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:dpPriceLabel];
    
    
    UILabel * allPriceLabel =[[UILabel alloc] initWithFrame:CGRectMake(SIZEwidth-320, 20, 150, 20)];
    allPriceLabel.text = @"金额";
    allPriceLabel.textColor = [UIColor blackColor];
    allPriceLabel.font = [UIFont systemFontOfSize:17.0];
    allPriceLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:allPriceLabel];
    
    UILabel * delegetLabel =[[UILabel alloc] initWithFrame:CGRectMake(SIZEwidth-180, 20, 100, 20)];
    delegetLabel.text = @"删除";
    delegetLabel.textColor = [UIColor blackColor];
    delegetLabel.font = [UIFont systemFontOfSize:17.0];
    delegetLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:delegetLabel];
    
    
    cartTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 110, self.view.frame.size.width-5, self.view.frame.size.height-210) style:UITableViewStylePlain];
    cartTableView.delegate =self;
    cartTableView.dataSource = self;
    [self.view addSubview:cartTableView];
}

-(void)footViewLayOut{
    UIView * lineView =[[UIView alloc] initWithFrame:CGRectMake(5, SIZEheight-72, SIZEwidth -5, 2)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView];
    //底部view
    UIView * footView =[[UIView alloc] initWithFrame:CGRectMake(5, SIZEheight-70, SIZEwidth - 5, 70)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    //提交订单
    UIButton* submitButton =[[UIButton alloc] initWithFrame:CGRectMake(SIZEwidth-180, 20 , 120, 40)];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"orderbtn1_2"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:submitButton];
    allNumberstring = nil;
    allMoneystring = nil;
    for (NSDictionary  * dic in _dataArray) {
        
        NSString * stringMon = [dic objectForKey:@"totalAmount"];
        NSString * stringNum = [dic objectForKey:@"totalQty"];
        
        allNumberstring = [NSString stringWithFormat:@"%.2f",allNumberstring.floatValue+stringNum.floatValue];
        allMoneystring =[NSString stringWithFormat:@"%.2f",allMoneystring.floatValue + stringMon.floatValue];
    }
    //总金额
    allMoney = [[UILabel alloc] initWithFrame:CGRectMake(SIZEwidth-362, 20, 160, 40)];
    allMoney.text = [NSString stringWithFormat:@"总金额:￥%@",allMoneystring];
    allMoney .font = [UIFont systemFontOfSize:16.0];
    allMoney.textColor = [UIColor blackColor];
    [footView addSubview:allMoney];
    
    //数量
    quantityLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZEwidth-580, 20, 160, 40)];
    quantityLabel.text = [NSString stringWithFormat:@"总数量:￥%.2f件",allNumberstring.floatValue];
    quantityLabel .font = [UIFont systemFontOfSize:16.0];
    quantityLabel.textColor = [UIColor blackColor];
    [footView addSubview:quantityLabel];
    
    seartchDataArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"ProductData" fieldName:nil fieldValue:nil];
    allPassShopArray = [seartchDataArray mutableCopy];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdenifer =@"cellIdenifer";
    ShopContainerTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellIdenifer];
    if (!cell) {
        cell =[[ShopContainerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSDictionary * dic = [_dataArray objectAtIndex:indexPath.row];
    
    cell.priceLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"disPrice"]];
    
    cell.numberLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"totalQty"]];
    cell.allPriceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalAmount"]] ;
    cell.dpPriceLabel.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"disRate"] floatValue]];
    [cell.shopImage sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"mainPictureUrl"]]];
    cell.titleLabel.text = [dic objectForKey:@"goodsName"];
    cell.shopNameLabel.text =[dic objectForKey:@"goodsNo"];
    cell.shopPriceLabel.text = [NSString stringWithFormat:@"单价:￥%.1f",[[dic objectForKey:@"dpPrice"] floatValue]];
    cell.delegetButton.tag = indexPath.row;
    
    [cell.delegetButton addTarget:self action:@selector(delegetButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.shopSelectBtn setBackgroundImage:[UIImage imageNamed:@"circular2"] forState:UIControlStateSelected];
    [cell.shopSelectBtn setBackgroundImage:[UIImage imageNamed:@"circular1"] forState:0];
    cell.shopSelectBtn.selected = allSelectButton.selected;
    
    cell.shopSelectBtn.tag = indexPath.row;
    shopSelectNum = cell.shopSelectBtn.tag;
    [cell.shopSelectBtn addTarget:self action:@selector(shopSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic =[[NSDictionary alloc] init];
    dic =[_dataArray objectAtIndex:indexPath.row];
    NSString * string =[NSString stringWithFormat:@"%@",[dic objectForKey:@"goodsNo"]];
    NSString * mainPicString =[NSString stringWithFormat:@"%@",[dic objectForKey:@"mainPictureUrl"]];
    ProductViewController * product =[[ProductViewController alloc] init];
    product.hidesBottomBarWhenPushed = YES;
    product.currentNavigationController = self.currentNavigationController;
    product.goodNoString =string;
    product.mainPictureUrlString = mainPicString;
    product.disPriceString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"disPrice"]];
    [self.currentNavigationController pushViewController:product animated:YES];
}
//删除
-(void)delegetButtonClick:(UIButton * )sender{
    
    UIAlertView * alertView =[[UIAlertView alloc] initWithTitle:@"是否确定删除该商品" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    shopDeleget = sender.tag;
    [alertView show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:{
            
            NSDictionary * dic =[[NSDictionary alloc] init];
            dic = [_dataArray objectAtIndex:shopDeleget];
            Numberstring = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalQty"]];
            Moneystring =[NSString stringWithFormat:@"%.@",[dic objectForKey:@"totalAmount"]];
            
            allNumberstring = [NSString stringWithFormat:@"%.2f",allNumberstring.floatValue-Numberstring.floatValue];
            allMoneystring = [NSString stringWithFormat:@"%.2f",allMoneystring.floatValue-Moneystring.floatValue];
            
            quantityLabel.text =[NSString stringWithFormat:@"总数量:%.1f 件",allNumberstring.floatValue];
            allMoney.text = [NSString stringWithFormat:@"总金额:￥%.2f",allMoneystring.floatValue];
            
            _goodsNoString = [dic objectForKey:@"goodsNo"];
 
            [[ShopSaveManage shareManager] deleteTableDataByFieldNameValue:@"SizeData" fieldName:@"goodsNo" fieldValue:_goodsNoString];
            
            
            [self httpdelegetGetOrders];
            
            
        }
            
            break;
            
        default:
            break;
    }
}
//全选
-(void)selectButtonClick:(UIButton*)sender{

    if (sender.selected == NO) {
        sender.selected = YES;
        sumNum = 1;
        allNumberstring = nil;
        allMoneystring =nil;

        for (NSDictionary  * dic in _dataArray) {
            
            NSString * stringNum = [dic objectForKey:@"totalQty"];
            NSString * stringMon = [dic objectForKey:@"totalAmount"];
            allNumberstring = [NSString stringWithFormat:@"%.2f",allNumberstring.floatValue+stringNum.floatValue];
            allMoneystring =[NSString stringWithFormat:@"%.2f",allMoneystring.floatValue + stringMon.floatValue];
        }
        quantityLabel.text =[NSString stringWithFormat:@"总数量:%.1f 件",allNumberstring.floatValue];
        allMoney.text = [NSString stringWithFormat:@"总金额:￥%.2f",allMoneystring.floatValue];
        
        seartchDataArray = allPassShopArray;
        
        
    }else{
        sender.selected = NO;
        sumNum= 0;
        allNumberstring = nil;
        allMoneystring =nil;
        quantityLabel.text =[NSString stringWithFormat:@"总数量:%.1f 件",allNumberstring.floatValue];
        allMoney.text = [NSString stringWithFormat:@"总金额:￥%.2f",allMoneystring.floatValue];
        [seartchDataArray removeAllObjects];
    
    }
    [cartTableView reloadData];
}
//shop选择
-(void)shopSelectBtn:(UIButton * )sender{
 
    if (sender.selected==NO) {
        sender.selected = YES;
        NSDictionary * dic = [_dataArray objectAtIndex:sender.tag];
        Numberstring = [dic objectForKey:@"totalQty"];
        Moneystring  =  [dic objectForKey:@"totalAmount"];
        
        allNumberstring = [NSString stringWithFormat:@"%.2f",allNumberstring.floatValue+Numberstring.floatValue];
        allMoneystring = [NSString stringWithFormat:@"%.2f",allMoneystring.floatValue+Moneystring.floatValue];
        quantityLabel.text =[NSString stringWithFormat:@"总数量:%.1f 件",allNumberstring.floatValue];
        allMoney.text = [NSString stringWithFormat:@"总金额:￥%.2f",allMoneystring.floatValue];
        [[ShopSaveManage shareManager] saveLocaProduct:dic];
        seartchDataArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"ProductData" fieldName:nil fieldValue:nil];
        
        
    }else{
         sender.selected = NO;
        NSDictionary * dic = [_dataArray objectAtIndex:sender.tag];
        Numberstring = [dic objectForKey:@"totalQty"];
        Moneystring  =  [dic objectForKey:@"totalAmount"];
        allNumberstring = [NSString stringWithFormat:@"%.2f",allNumberstring.floatValue-Numberstring.floatValue];
        allMoneystring = [NSString stringWithFormat:@"%.2f",allMoneystring.floatValue-Moneystring.floatValue];
        
        quantityLabel.text =[NSString stringWithFormat:@"总数量:%.1f 件",allNumberstring.floatValue];
        allMoney.text = [NSString stringWithFormat:@"总金额:￥%.2f",allMoneystring.floatValue];        NSString * goodsNoString = [dic objectForKey:@"goodsNo"];
        [[ShopSaveManage shareManager] deleteTableDataByFieldNameValue:@"ProductData" fieldName:@"goodsNo" fieldValue:goodsNoString];
        seartchDataArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"ProductData" fieldName:nil fieldValue:nil];
    }
}

-(void)btnClick{
    
    if (allNumberstring.integerValue>0 ) {
        [self httpgetOrdersCeateorder];

    }
}

-(void)succeed{
    
    for (SizeData * sizeLocalcont in seartchDataArray) {
        [[ShopSaveManage shareManager] deleteTableDataByFieldNameValue:@"SizeData" fieldName:@"goodsNo" fieldValue:sizeLocalcont.goodsNo];

    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *coverView = [[UIView alloc]init];
    coverView.backgroundColor = [UIColor grayColor];
    coverView.frame = window.bounds;
    coverView.alpha = 0.8;
    [window addSubview:coverView];
    self.coverView  = coverView;
    
    
    UIImageView * imageView =[[UIImageView alloc] initWithFrame:CGRectMake((SIZEwidth-320)/2, 120, 320, 400)];
    imageView.image = [UIImage imageNamed:@"succeedbg"];
    [coverView addSubview:imageView];
    
    UIButton * backBtn =[[UIButton alloc] initWithFrame:CGRectMake((SIZEwidth-240)/2, 580, 240, 50)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"selectBackBtn4"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_coverView addSubview:backBtn];
}
-(void)backBtnClick{
    
    [_coverView removeFromSuperview];
    [self httpGetOrders];
}
//上传订单列表的请求
-(void)httpgetOrdersCeateorder{
    
    NSString * serveSreing =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * userNo =[PublicKit getPlistParameter:NameTextString];
    NSString * channelCode =[PublicKit getPlistParameter:channelCodeString];
    
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/orderslater/ceateorder",serveSreing];
    NSMutableDictionary * parmdic = [[NSMutableDictionary alloc] init];
    NSMutableArray * array =[[NSMutableArray alloc] init];
    NSMutableDictionary* shopDic =[[NSMutableDictionary alloc] init];
    NSString * dateMonthString =[PublicKit getNowDateMonthTimeString];
    NSString * datetimeString = [PublicKit getNowDateTimeString];
 
    for (ProductData * productLocal in seartchDataArray) {
        NSDictionary * dictionary =  [PublicKit saveLocaDicShop:productLocal];
        shopDic = [PublicKit saveLocaArrayShop:productLocal setDictionary:dictionary];
        [array addObject:shopDic];

    }
    [parmdic setObject:array forKey:@"details"];
    [parmdic setObject:channelCode forKey:@"channelCode"];
    [parmdic setObject:userNo forKey:@"createBy"];
    [parmdic setObject:@(0) forKey:@"procesStatus"];
    [parmdic setObject:@"" forKey:@"remark"];
    [parmdic setObject:dateMonthString forKey:@"createDate"];
    [parmdic setObject:datetimeString forKey:@"createTime"];
    [parmdic setObject:@(1) forKey:@"status"];
    [parmdic setObject:@(allMoneystring.floatValue) forKey:@"totalAmount"];
    [parmdic setObject:@(allNumberstring.integerValue) forKey:@"totalQty"];
    [[RSNetworkManager sharedManager] POST:urlString parameters:parmdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        NSLog(@"dic=====: %@", dic);
        [self succeed];
        [cartTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

//获取订单数据的请求
-(void)httpGetOrders{
    
    NSString * serveSreing =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * userNo =[PublicKit getPlistParameter:NameTextString];
    NSString * channelCode =[PublicKit getPlistParameter:channelCodeString];
    
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/ordersgoods/getorder",serveSreing];
    NSMutableDictionary * parmdic = [[NSMutableDictionary alloc] init];
    
    [parmdic setObject:channelCode forKey:@"customer_id"];
    [parmdic setObject:userNo forKey:@"userNo"];
    [[RSNetworkManager sharedManager] POST:urlString parameters:parmdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        _dataArray = [dic objectForKey:@"data"];
        [[ShopSaveManage shareManager] deleteTableDataByFieldNameValue:@"ProductData" fieldName:nil fieldValue:nil];
        if (_dataArray.count>0) {
            for (NSDictionary * goosInfoDictionary in _dataArray) {
                [[ShopSaveManage shareManager] saveLocaOrderProduct:goosInfoDictionary];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shoppingCarAccountNoti" object:self];
        [self footViewLayOut];
        [cartTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

//获取删除订单数据的请求
-(void)httpdelegetGetOrders{
    
    NSString * serveSreing =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * userNo =[PublicKit getPlistParameter:NameTextString];
    NSString * channelCode =[PublicKit getPlistParameter:channelCodeString];
    
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/ordersgoods/delectordergoods",serveSreing];
    NSMutableDictionary * parmdic = [[NSMutableDictionary alloc] init];
    
    [parmdic setObject:channelCode forKey:@"customer_id"];
    [parmdic setObject:userNo forKey:@"userNo"];
    [parmdic setObject:_goodsNoString forKey:@"goodno"];
    
    [[RSNetworkManager sharedManager] POST:urlString parameters:parmdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        NSLog(@"dic=====%@",dic);
        [self httpGetOrders];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}


- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
