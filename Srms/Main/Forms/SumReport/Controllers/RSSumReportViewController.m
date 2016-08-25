//
//  ProportionshopViewController.m
//  CloudShoping
//
//  Created by ohm on 16/5/30.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSSumReportViewController.h"
#import "RSSumReportTopView.h"
#import "RSSumReportBarChartView.h"
#import "RSReportNetwork.h"
#import "RSSumReportPieChartView.h"
#import "RSCalendarView.h"


@interface RSSumReportViewController ()

@property (nonatomic, strong) RSSumReportTopView *topView;
@property (nonatomic, strong) RSSumReportBarChartView *barChartView;

@property (nonatomic, strong) RSReportNetwork *reportNetwork;
// 饼状图
@property (nonatomic,strong) RSSumReportPieChartView *pieChartView;
//选择的参数
@property (nonatomic,strong) NSMutableDictionary *paramsDic;
// 动态加载提示框
@property (nonatomic,strong) MBProgressHUD *progressHUB;
// 网络请求参数类型
@property (nonatomic,strong) NSArray *typeArray;
// 日历
@property (nonatomic,strong) RSCalendarView *calendarView;
// 开始日期
@property (nonatomic, strong) UIButton *dateButton;


@end

@implementation RSSumReportViewController

- (void)initData{
    
    _typeArray = @[@"brand",@"range",@"category",@"pattern",@"year",@"season"];
    _reportNetwork = [[RSReportNetwork alloc]init];
    NSString *name =[PublicKit getPlistParameter:channelCodeString];
    if (name == nil) {
        
        name = @"";
    }
    _paramsDic =[[NSMutableDictionary alloc]initWithDictionary:@{@"channelCode":name,@"beginDate":[self getLastMonthDateWithMonth:-1],@"endDate":[self getCurrentDate],@"pieChartDimes":@"category,range,pattern"}];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self setNavigationModel];
    [self getData];
}

// 设置导航栏的样式
- (void) setNavigationModel{
    self.tabBarController.tabBar.hidden = YES;
    self.currentNavigationController.titleText = @"总结报表";
    [self.currentNavigationController setDIYNavigationBarHidden:NO];
    self.currentNavigationController.isHideReturnBtn = YES;
    [self.currentNavigationController setNavigationScreenButtonHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self createUI];
    [self topViewButtonClick];
}

- (void)getData{

    __block RSSumReportViewController *selfVC = self;
    [self loadProgressViewIsShow:YES];
    [_reportNetwork postSumStatisticsDataWithUrl:RS_API_CON(RSReportSummaryURL, @"") params:_paramsDic success:^(NSMutableArray *array){
       // 获取表格的数据
        float discount = ([[NSString stringWithFormat:@"%@",_reportNetwork.summarymodel.settlementAmount] floatValue] - [[NSString stringWithFormat:@"%@",_reportNetwork.summarymodel.tagPriceAmount] floatValue])/[[NSString stringWithFormat:@"%@",_reportNetwork.summarymodel.settlementAmount] floatValue] * 100.0;
        NSString *discountString = [NSString stringWithFormat:@"%.2f",discount];
        NSArray *sumModelArray =@[[
                                   NSString stringWithFormat:@"%@",_reportNetwork.summarymodel.orderAmount],
                                   [NSString stringWithFormat:@"%@",_reportNetwork.summarymodel.goodsAmount],
                                   [NSString stringWithFormat:@"%@",_reportNetwork.summarymodel.settlementAmount],
                                   [NSString stringWithFormat:@"%@",_reportNetwork.summarymodel.tagPriceAmount],
                                   discountString];
        [selfVC.barChartView loadFormsDataArray:sumModelArray];
        
        // 获取柱状图的数据
        [selfVC.barChartView loadHistogramViewDataWithArray:_reportNetwork.orderBarGraphArray];
        // 加载饼状图数据
        [selfVC.pieChartView loadPieChartViewWithModelArray:_reportNetwork.allCatogeryArray];
        [self loadProgressViewIsShow:NO];
    } fail:^(NSError *error){
    
        [self loadProgressViewIsShow:NO];
    
    }];
}

- (void)createUI{
    
    _topView = [[RSSumReportTopView alloc]init];
    [self.view addSubview:_topView];
    
    _barChartView = [[RSSumReportBarChartView alloc]init];
    [self.view addSubview:_barChartView];
    
    _pieChartView = [[RSSumReportPieChartView alloc]init];
    [self.view addSubview:_pieChartView];
    [self autoLayout];
}
- (void)autoLayout{
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.equalTo(self.view);
        make.right.equalTo(self.view).offset(-5);
        make.top.equalTo(self.view.mas_top).offset(45);
        make.height.mas_equalTo(50);
    }];
    
    
    [_barChartView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(self.view);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(_topView.mas_bottom).offset(0);
        make.height.mas_equalTo(275);
    }];
    
    
    [_pieChartView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.right.equalTo(self.view);
        make.top.equalTo(_barChartView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view);
    }];
    
}

- (void) topViewButtonClick{
    __block RSSumReportViewController *selfVC = self;
    _topView.sumReportBtn = ^(UIButton *btn){
        
        NSLog(@"date = %ld",(long)btn.tag);
        [selfVC changeDicParamsWithButton:btn];
    };
}

- (void)changeDicParamsWithButton:(UIButton *)btn{
    
    if (btn.tag >= 20113 && btn.tag <= 20118) {
        NSInteger index = btn.tag - 20113;
        NSLog(@"已经进来 = %ld",(long)index);
        NSString *buttonTypeString = _typeArray[index];
        NSString *pieChartDimesString = _paramsDic[@"pieChartDimes"];
        if (btn.selected) {
            
            if (![pieChartDimesString containsString:buttonTypeString]) {
                if ([pieChartDimesString isEqualToString:@""] || !pieChartDimesString) {
                    pieChartDimesString = [NSString stringWithFormat:@"%@",buttonTypeString];
                }else{
                    pieChartDimesString = [NSString stringWithFormat:@"%@,%@",pieChartDimesString,buttonTypeString];
                }
                [_paramsDic setValue:pieChartDimesString forKey:@"pieChartDimes"];
            }
        }
        else{
            
            if ([pieChartDimesString containsString:buttonTypeString]) {
            
                NSArray *stringArray = [pieChartDimesString componentsSeparatedByString:@","];
                NSMutableArray *mutString = [[NSMutableArray alloc]initWithArray:stringArray];
                [mutString removeObject:buttonTypeString];
                NSString *changedString = [mutString componentsJoinedByString:@","];
                [_paramsDic setValue:changedString forKey:@"pieChartDimes"];
            }
        }
        NSLog(@"修改后的字符串 ＝ %@",_paramsDic[@"pieChartDimes"]);
    }
    else if (btn.tag == 20119){
        
        [self getData];
        
    }
    else if (btn.tag == 20111){
        
        _dateButton = btn;
        [self showCalendar];
    }else if (btn.tag == 20112){
        _dateButton = btn;
        [self showCalendar];
    }
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
            
            [weakSelf.paramsDic setObject:dateString forKey:@"beginDate"];
        }else if (weakSelf.dateButton.tag == 20112){
            
            [weakSelf.paramsDic setObject:dateString forKey:@"endDate"];
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
