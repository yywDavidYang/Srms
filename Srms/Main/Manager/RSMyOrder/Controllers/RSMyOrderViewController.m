//
//  MyOrderViewController.m
//  CloudShoping
//
//  Created by ohm on 16/5/30.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSMyOrderViewController.h"
#import "RSMyOrderCell.h"
#import "MJExtension.h"
#import "OrderModel.h"
#import "ShoppingCartViewController.h"
#import "RSCalendarView.h"
#import "RSMyOrderModel.h"

@interface RSMyOrderViewController ()<UITableViewDataSource,UITableViewDelegate,BtnClickDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;//标题数组
@property (nonatomic, strong) UIButton *orderstates;//选择订单状态
@property (nonatomic, strong) UIButton *dateBtn;//选择日期
@property (nonatomic, weak) UIView *coverView;//一个遮罩的view
@property (nonatomic,retain)NSDictionary * dataArr;
@property (nonatomic, strong) UIView *detailView;
@property (nonatomic, assign) NSInteger clickIndex;
// 日历
@property (nonatomic,strong) RSCalendarView *calendarView;
// 开始日期
@property (nonatomic, strong) UIButton *dateButton;
// 参数
@property (nonatomic, strong) NSMutableDictionary *paramdic;
// 审批的id
@property (nonatomic, strong) NSNumber *orderStatus;
// 订单状态
@property (nonatomic, strong) UIView *orderStatuesView;
// 背景
@property (nonatomic, strong) UIView *orderStatusBackView;
// 模型数组
@property (nonatomic, strong) NSMutableArray *modelArray;
// 组头
@property (nonatomic, strong) UIView *headerview;
// 滚动图表
@property (nonatomic, strong) UIScrollView *tableScroller;
// 滚动视容器
@property (nonatomic, strong) UIView *scrollerViewContain;
// 滚动条
@property (nonatomic, strong) UIImageView *scrollerBarImageView;
@end

@implementation RSMyOrderViewController

- (void)initData{
    NSString *channelCode = [PublicKit getPlistParameter:channelCodeString];
    NSString *userAccount = [PublicKit getPlistParameter:NameTextString];
    NSString *orderBeginDate = [self getLastMonthDateWithMonth:-1];
    NSString *orderEndDate = [self getCurrentDate];
    self.paramdic = [[NSMutableDictionary alloc]initWithDictionary:@{@"channelCode":channelCode,@"userAccount":userAccount,@"orderId":@"",@"orderBeginDate":orderBeginDate,@"orderEndDate":orderEndDate,@"orderStatus":@99,@"pageIndex":@1,@"pageSize":@10}];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [self httpGetOrder];
    self.tabBarController.tabBar.hidden = YES;
    self.currentNavigationController.titleText= @"我的订单";
    self.currentNavigationController.isHideReturnBtn = YES;
    [self.currentNavigationController setDIYNavigationBarHidden:NO];
    [self.currentNavigationController setNavigationScreenButtonHidden:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    self.tableScroller = [[UIScrollView alloc]init];
    [self.view addSubview:self.tableScroller];
    self.tableScroller.pagingEnabled = NO;
    self.tableScroller.bounces = NO;
    self.tableScroller.backgroundColor = [UIColor whiteColor];
    [self.tableScroller mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.equalTo(self.view.mas_top).offset(95);
        make.left.equalTo(self.view.mas_left).offset(16);;
        make.right.bottom.equalTo(self.view);
    }];
    
    self.scrollerViewContain = [[UIView alloc]init];
    [self.tableScroller addSubview:self.scrollerViewContain];
    [self.scrollerViewContain mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.edges.equalTo(self.tableScroller);
        make.height.equalTo(self.tableScroller);
    }];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = RGBA(208, 208, 208, 1);
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.scrollerViewContain addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.top.bottom.equalTo(self.scrollerViewContain);
        make.width.mas_equalTo(9 * 110 + 200);
    }];
    
    [self.scrollerViewContain mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.right.equalTo(self.tableView.mas_right);
    }];

    _headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,9 * 110 + 200,44)];
    _headerview.backgroundColor = RGBA(223, 240, 224, 1);
    //创建一个UILable（v_headerLab）用来显示标题
    
    UILabel *topLineLabel = [[UILabel alloc]init];
    topLineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [_headerview addSubview:topLineLabel];
    [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.left.right.equalTo(_headerview);
        make.height.mas_equalTo(1);
    }];
    NSArray *headerTitleArray = @[@"订单号",@"数量",@"金额",@"配货数",@"出货数",@"收货数",@"订单欠数",@"日期",@"订单状态",@"操作"];
    float labelWidth = 110;
    UILabel *lastTtitleLabel ;
    UILabel *lastLineLabel ;
    for (NSInteger i = 0; i < headerTitleArray.count; i ++) {
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.text = headerTitleArray[i];
        [_headerview addSubview:titleLabel];
        if (i == 0) {
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.equalTo(topLineLabel.mas_bottom).offset(0);
                make.left.bottom.equalTo(_headerview);
                make.width.mas_equalTo(200);
            }];
        }else{
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.equalTo(topLineLabel.mas_bottom).offset(0);
                make.bottom.equalTo(_headerview);
                make.left.equalTo(lastLineLabel.mas_right).offset(0);
                make.width.mas_equalTo(labelWidth);
            }];
        }
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [_headerview addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.top.bottom.equalTo(_headerview);
            make.left.equalTo(titleLabel.mas_right).offset(0);
            make.width.mas_equalTo(1);
        }];
        
        lastLineLabel   = lineLabel;
        lastTtitleLabel = titleLabel;
    }
    
    UILabel *bottomLine = [[UILabel alloc]init];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [_headerview addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.bottom.equalTo(_headerview);
        make.left.right.equalTo(_headerview);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *rightLineLabel = [[UILabel alloc]init];
    rightLineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.headerview addSubview:rightLineLabel];
    [rightLineLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.bottom.equalTo(self.headerview);
        make.right.equalTo(self.headerview.mas_right).offset(0);
        make.width.mas_equalTo(1);
    }];
    
    UILabel *leftLineLabel = [[UILabel alloc]init];
    leftLineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.headerview addSubview:leftLineLabel];
    [leftLineLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.bottom.equalTo(self.headerview);
        make.left.equalTo(self.headerview.mas_left).offset(0);
        make.width.mas_equalTo(1);
    }];
//    获取数据
    [self layOut];
}



//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return _headerview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CELLID = @"cellID";
    RSMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (cell == nil) {
        cell = [[RSMyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    RSMyOrderModel *model = _modelArray[indexPath.row];
    NSDictionary *dic = dataArray[indexPath.row];
    NSArray *contentArray = @[dic[@"orderNo"] ,dic[@"totalQty"],dic[@"totalAmount"],[dic[@"deliveryQuantity"] isEqual:[NSNull null]]?@"":dic[@"deliveryQuantity"],dic[@"sortingQuantity"],dic[@"deliverys"],dic[@"accnotes"],dic[@"createDate"],dic[@"status"],dic[@"procesStatus"]];
   
    [cell setCellDataWithArray:contentArray withCeateDate:model.createTime];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dic =[dataArray objectAtIndex:indexPath.row];
    
    ShoppingCartViewController * shopCartView= [[ShoppingCartViewController alloc] init];
    shopCartView.hidesBottomBarWhenPushed = YES;
    shopCartView.currentNavigationController = self.currentNavigationController;
    shopCartView.orderIDString = [dic objectForKey:@"orderNo"];
    [self.navigationController pushViewController:shopCartView animated:YES];
}

- (void)btnClickk:(UIButton *)btn{
    if (btn.selected == NO) {

    }else{
        
        [btn setTitle:@"完成" forState:UIControlStateNormal];
         btn.backgroundColor = [UIColor grayColor];
    }
}

- (void)closeClick {
    
    NSLog(@"点击了xxx按钮");
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.y -= [UIScreen mainScreen].bounds.size.height;
        self.detailView.y -= [UIScreen mainScreen].bounds.size.height;

    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.detailView removeFromSuperview];
    }];
}

- (void)btnClick:(UIButton *)button{
    
    _clickIndex = button.tag;
}

-(void)layOut{
    
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(16,45, self.view.frame.size.width-20, 50)];
    view.backgroundColor = [UIColor whiteColor];
    classButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 10, 120, 30)];
    [classButton setTitle:@"全部" forState:UIControlStateNormal];
    [classButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [classButton setBackgroundImage:[UIImage imageNamed:@"btn8_01"] forState:UIControlStateNormal];
    [classButton addTarget:self action:@selector(classliyClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:classButton];
    
    startDateButton = [[UIButton alloc]init];
    startDateButton.tag = 20111;
    startDateButton.layer.cornerRadius = 4.0;
    startDateButton.layer.masksToBounds = YES;
    startDateButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [startDateButton setBackgroundImage:[UIImage imageNamed:@"btn8_01"] forState:0];
    [startDateButton setTitle:[self getLastMonthDateWithMonth:-1] forState:0];
    startDateButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [startDateButton setTitleColor:[UIColor grayColor] forState:0];
    [startDateButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:startDateButton];
    
    endDateLabel = [[UILabel alloc]init];
    endDateLabel.font = [UIFont systemFontOfSize:20 weight:3];
    endDateLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    endDateLabel.text = @"至";
    endDateLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:endDateLabel];
    
    endDateButton = [[UIButton alloc]init];
    endDateButton.tag = 20112;
    endDateButton.layer.cornerRadius = 4.0;
    endDateButton.layer.masksToBounds = YES;
    endDateButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    endDateButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [endDateButton setBackgroundImage:[UIImage imageNamed:@"btn8_01"] forState:0];
    [endDateButton setTitle:[self getCurrentDate] forState:0];
    [endDateButton setTitleColor:[UIColor grayColor] forState:0];
    [endDateButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:endDateButton];
    
    [startDateButton mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(classButton.mas_right).offset(30);
        make.centerY.equalTo(view);
        make.top.equalTo(view.mas_top).offset(10);
        make.bottom.equalTo(view.mas_bottom).offset(-10);
        make.width.mas_equalTo(130);
    }];
    
    [endDateLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(startDateButton.mas_right).offset(1);
        make.centerY.equalTo(view);
        make.top.equalTo(view.mas_top).offset(10);
        make.bottom.equalTo(view.mas_bottom).offset(-10);
        make.width.mas_equalTo(30);
        
    }];
    
    [endDateButton mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(endDateLabel.mas_right).offset(1);
        make.centerY.equalTo(view);
        make.top.equalTo(view.mas_top).offset(10);
        make.bottom.equalTo(view.mas_bottom).offset(-10);
        make.width.mas_equalTo(130);
    }];
    
    
    searchText = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width-275, 10, 160, 30)];
    searchText.textAlignment = NSTextAlignmentLeft;
    searchText.placeholder = @"请输入货品id";
    searchText.background =[UIImage imageNamed:@"btn8_02"];
    searchText.font =[UIFont systemFontOfSize:14.0f];
    [view addSubview:searchText];
    
    UIButton * searchButton =[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-115, 10, 34, 30)];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"btn8_03"] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:searchButton];
    [self.view addSubview:view];
    
}
// 待审批
- (void)classliyClick:(UIButton *)btn{
    [self loadLeftOrderStatuesView];
    NSLog(@"点击了审核状态按钮");
}
- (void)searchButton:(UIButton*)btn{
    [_paramdic setObject:searchText.text forKey:@"orderId"];
    [self httpGetOrder];
    NSLog(@" 点击了搜索框");
}

- (void) loadLeftOrderStatuesView{
    if (_orderStatuesView == nil) {
        _orderStatusBackView = [[UIView alloc]init];
        _orderStatusBackView.frame = self.view.bounds;
        _orderStatusBackView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        _orderStatusBackView.hidden = YES;
        [_orderStatusBackView addGestureRecognizer:tap];
        [self.view addSubview:_orderStatusBackView];
        _orderStatuesView = [[UIView alloc]init];
        _orderStatuesView.hidden = YES;
        _orderStatuesView.backgroundColor = RGBA(44, 146, 44,1.0f);
        [self.view addSubview:_orderStatuesView];
        [_orderStatuesView mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(120);
            make.top.equalTo(classButton.mas_bottom).offset(0);
            make.left.equalTo(classButton.mas_left);
        }];
        NSArray *buttonArray = @[@"全部",@"未审批",@"已审批"];
        UIButton *lastButton = nil;
        for (NSInteger i = 0;i < 3;i ++) {
            
            UIButton *button = [[UIButton alloc]init];
            [button setTitle:buttonArray[i] forState:0];
            [button addTarget:self action:@selector(orderStatuesClick:) forControlEvents:UIControlEventTouchUpInside];
            [_orderStatuesView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make){
            
                make.top.equalTo(lastButton?lastButton.mas_bottom:_orderStatuesView.mas_top);
                make.left.right.equalTo(_orderStatuesView).offset(0);
                make.height.mas_equalTo(40);
            }];
            lastButton = button;
            switch (i) {
                case 0:
                {
                    button.tag = 99;
                }
                    break;
                case 1:
                {
                    button.tag = 0;
                }
                    break;
                case 2:
                {
                    button.tag = 1;
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    _orderStatuesView.hidden = NO;
    _orderStatusBackView.hidden = NO;
}
- (void)httpGetOrder{
    
    NSString * serve =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/orders/getorders",serve];
    [self loadProgressViewIsShow:YES];
    
    [[RSNetworkManager sharedManager] POST:urlString parameters:self.paramdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _modelArray = [NSMutableArray array];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        NSLog(@"获取回来的数据 = %@",dic);
        dataArray =[dic objectForKey:@"data"];
        for (NSInteger i = 0; i < dataArray.count; i ++) {
            
            NSDictionary *dataDic = dataArray[i];
            RSMyOrderModel *model = [[RSMyOrderModel alloc]init];
            [model setValuesForKeysWithDictionary:dataDic];
            [_modelArray addObject:model];
        }
        [self.tableView reloadData];
        [self loadProgressViewIsShow:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self loadProgressViewIsShow:NO];
    }];
    NSLog(@"paramDic = %@",self.paramdic);
}

//将json数据转换成模型对象
- (void)jsonToObject:(NSString *)json_data{

//    NSString ->NSData
    NSData *data = [json_data dataUsingEncoding:NSUTF8StringEncoding]
    ;
//    NSData ->NSDictionary
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//将字典转化为模型数组
    NSArray *arr = [OrderModel mj_objectArrayWithKeyValuesArray:jsonObject];
//    打印模型
    for (OrderModel *order  in arr) {
        
        NSLog(@"orderNum = %@,date = %@",order.orderNum,order.date);
    }
}

// 订单状态
- (void) orderStatuesClick:(UIButton *)btn{
    
    [classButton setTitle:btn.titleLabel.text forState:0];
    [_paramdic setObject:[NSNumber numberWithInteger:btn.tag] forKey:@"orderStatus"];
    _orderStatuesView.hidden = YES;
    _orderStatusBackView.hidden = YES;
}
// 隐藏下拉
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    _orderStatuesView.hidden = YES;
    _orderStatusBackView.hidden = YES;
}
//  日历
- (void)buttonClick:(UIButton *)button{
    
    if (button.selected) {
        
        button.selected = NO;
    }else{
        
        button.selected = YES;
    }
    self.dateButton = button;
    [self showCalendar];
}

// 显示日历
-(void) showCalendar{
    
    if (_calendarView) {
        
        [_calendarView removeFromSuperview];
        _calendarView = nil;
    }
    //日历
    _calendarView = [[RSCalendarView alloc]init];
    [_calendarView show];
    [self.view addSubview:_calendarView];
    __weak typeof (self) weakSelf = self;
    _calendarView.onDateSelectBlk = ^(NSString* dateString){
        
        [weakSelf.dateButton setTitle:dateString forState:0];
        //添加日期到参数字典中
        if (weakSelf.dateButton.tag == 20111) {
            
            [weakSelf.paramdic setObject:dateString forKey:@"orderBeginDate"];
        }else if (weakSelf.dateButton.tag == 20112){
            
            [weakSelf.paramdic setObject:dateString forKey:@"orderEndDate"];
        }
        NSLog(@"%@",dateString);
    };
}


// 获取当前日期
- (NSString *)getCurrentDate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    return date;
}

// 获取隔几个月的日期
- (NSString *)getLastMonthDateWithMonth:(NSInteger)month{
    // 获取当天时间
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:month];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    return beforDate;
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
