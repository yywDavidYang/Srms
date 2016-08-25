//
//  ShoppingCartViewController.m
//  Srms
//
//  Created by ohm on 16/7/11.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShopCartTableViewCell.h"
#import "ProductViewController.h"
@interface ShoppingCartViewController (){
    
    UITableView * cartTableView ;
    UIView * headerView;
    UIView * footerView;
    UIButton * allSelecteBtn;//全选按钮
    UILabel *goodsCountLabel;//订单总数
    UILabel *amountLabel;// 总金额
}

@end

@implementation ShoppingCartViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [self setNavigationModel];
}

- (void) setNavigationModel{
    
    [self.currentNavigationController setDIYNavigationBarHidden:NO];
    self.currentNavigationController.isHideReturnBtn = NO;
    self.currentNavigationController.titleText = @"订单详情";
    [self.currentNavigationController setNavigationScreenButtonHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self httpgetordergoods];
    [self loadHeaderView];
    [self loadFooterView];
    
    cartTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    cartTableView.delegate =self;
    cartTableView.dataSource = self;
    [self.view addSubview:cartTableView];
    [cartTableView registerClass:[ShopCartTableViewCell class] forCellReuseIdentifier:@"cellIdenifer"];
    [cartTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(footerView.mas_top).offset(0);
        make.top.equalTo(headerView.mas_bottom).offset(0);
    }];
}
// 顶部列表
- (void) loadHeaderView{
    
    headerView =[[UIView alloc] init];//WithFrame:CGRectMake(5, 50, SIZEwidth - 65, 45)];
    headerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.view.mas_top).offset(50);
    }];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [headerView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(headerView);
        make.height.mas_equalTo(1);
    }];
    
    
    // 全选按钮
    allSelecteBtn = [[UIButton alloc] init];//WithFrame:CGRectMake(5, 10, 40, 40)];
    allSelecteBtn.selected = YES;
    [allSelecteBtn setBackgroundImage:[UIImage imageNamed:@"circular2"] forState:UIControlStateSelected];
    [allSelecteBtn setBackgroundImage:[UIImage imageNamed:@"circular1"] forState:UIControlStateNormal];
    [headerView addSubview:allSelecteBtn];
    [allSelecteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(headerView.mas_centerY);
        make.left.equalTo(headerView.mas_left).offset(0);
        make.height.width.mas_equalTo(40);
    }];
    
    UILabel * allLabel =[[UILabel alloc] init];//WithFrame:CGRectMake(50, 20, 40, 20)];
    allLabel.text = @"全部";
    allLabel.textColor = [UIColor blackColor];
    allLabel.font = [UIFont systemFontOfSize:17.0];
    allLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:allLabel];
    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(headerView.mas_centerY);
        make.left.equalTo(allSelecteBtn.mas_right).offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    UILabel * shopLabel =[[UILabel alloc] init];//WithFrame:CGRectMake(180, 20,80, 20)];
    shopLabel.text = @"商品信息";
    shopLabel.textColor = [UIColor blackColor];
    shopLabel.font = [UIFont systemFontOfSize:17.0];
    shopLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:shopLabel];
    [shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(headerView.mas_centerY);
        make.left.equalTo(allLabel.mas_right).offset(0);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(20);
    }];
    
    CGFloat width = (self.view.size.width - 65 - 5 - 40 - 40 - 250)/5;
    NSArray *titleArray = @[@"价格",@"数量",@"折扣",@"金额",@"删除"];
    UILabel *lastLabel = nil;
    for (NSInteger i = 0; i < titleArray.count; i ++) {
        
        UILabel * titleLabel =[[UILabel alloc] init];//WithFrame:CGRectMake(180, 20,80, 20)];
        titleLabel.text = titleArray[i];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:17.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(headerView.mas_centerY);
            make.left.equalTo(lastLabel?lastLabel.mas_right:shopLabel.mas_right).offset(0);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(20);
        }];
        
        lastLabel = titleLabel;
    }
}

- (void)loadFooterView{
    
    footerView =[[UIView alloc] init];//WithFrame:CGRectMake(5, 50, SIZEwidth - 65, 45)];
    footerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [footerView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(footerView);
        make.height.mas_equalTo(1);
    }];
    // 数量
    amountLabel =[[UILabel alloc] init];
    amountLabel.text = @"¥";
    amountLabel.backgroundColor = [UIColor whiteColor];
    amountLabel.textColor = [UIColor grayColor];
    amountLabel.font = [UIFont systemFontOfSize:19.0];
    amountLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:amountLabel];
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(footerView.mas_centerY);
        make.right.equalTo(footerView.mas_right).offset(-80);
        make.height.mas_equalTo(40);
    }];
    
    goodsCountLabel =[[UILabel alloc] init];
    goodsCountLabel.text = @" 件";
    goodsCountLabel.backgroundColor = [UIColor whiteColor];
    goodsCountLabel.textColor = [UIColor grayColor];
    goodsCountLabel.font = [UIFont systemFontOfSize:19.0];
    goodsCountLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:goodsCountLabel];
    [goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(footerView.mas_centerY);
        make.right.equalTo(amountLabel.mas_left).offset(-30);
        make.height.mas_equalTo(40);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdenifer =@"cellIdenifer";
    ShopCartTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellIdenifer];
    if (!cell) {
        cell =[[ShopCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenifer];
    }
    NSDictionary * dic =[_dataArray objectAtIndex:indexPath.row];
    [cell loadOrderInfoWithDic:dic];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic =[_dataArray objectAtIndex:indexPath.row];
    NSString * string =[dic objectForKey:@"goodsNo"];
    NSString * dpString = [dic objectForKey:@"disPrice"];
    ProductViewController * product =[[ProductViewController alloc] init];
    product.currentNavigationController = self.currentNavigationController;
    product.hidesBottomBarWhenPushed = YES;
    product.goodNoString =string;
    product.disPriceString = dpString;
    
    [self.navigationController pushViewController:product animated:YES];
}

//获取订单列表的请求
-(void)httpgetordergoods{

    NSString * orderId =_orderIDString;
    NSString * serveSreing =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/orders/getordergoods/%@",serveSreing,orderId];
    NSDictionary * dic =[[NSDictionary alloc] init];
    dic =nil;
    [self loadProgressViewIsShow:YES];// 提示框
    [[RSNetworkManager sharedManager] GET:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        _dataArray =[dic objectForKey:@"data"];
        for (NSInteger  i = 0; i < _dataArray.count; i ++) {
            
            NSDictionary *dataDic = _dataArray[i];
            NSString *num = [NSString stringWithFormat:@"%@",dataDic[@"totalQty"]];
            NSString *totalAmount = [NSString stringWithFormat:@"%@",dataDic[@"totalAmount"]];
            goodsCountLabel.text = [NSString stringWithFormat:@"%d 件",[num  intValue] + [[[goodsCountLabel.text componentsSeparatedByString:@" "] firstObject] intValue]];
            amountLabel.text = [NSString stringWithFormat:@"¥ %.2f",[totalAmount  floatValue] + [[[amountLabel.text componentsSeparatedByString:@" "] lastObject] floatValue]];
        }
        [cartTableView reloadData];
        [self loadProgressViewIsShow:NO];// 隐藏提示框
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self loadProgressViewIsShow:NO];// 隐藏提示框
    }];
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

@end
