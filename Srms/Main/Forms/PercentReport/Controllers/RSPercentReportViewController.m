//
//  ReportViewController.m
//  CloudShoping
//
//  Created by ohm on 16/5/30.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSPercentReportViewController.h"
#import "RSPercentReportTopView.h"
#import "RSReportNetwork.h"
#import "RSPercentReportGridView.h"
#import "RSCalendarView.h"


@interface RSPercentReportViewController()

@property (nonatomic, strong) RSPercentReportTopView *topView;
// 动态加载提示框
@property (nonatomic,strong) MBProgressHUD *progressHUB;
@property (nonatomic, strong) RSReportNetwork *reportNetwork;
// 网络请求参数类型
@property (nonatomic,strong) NSArray *typeArray;
//选择的参数
@property (nonatomic,strong) NSMutableDictionary *paramsDic;
/**
 *   表格
 */
@property (nonatomic, strong) RSPercentReportGridView *gridView;
// 日历
@property (nonatomic,strong) RSCalendarView *calendarView;
// 开始日期
@property (nonatomic, strong) UIButton *dateButton;

@end

@implementation RSPercentReportViewController

- (void)initWithData{
    
    _typeArray = @[@"color",@"size"];
    _reportNetwork = [[RSReportNetwork alloc]init];
    NSString *name =[PublicKit getPlistParameter:channelCodeString];
    if (name == nil) {
        
        name = @"";
    }
    _paramsDic =[[NSMutableDictionary alloc]initWithDictionary:@{@"channelCode":name,@"beginDate":[self getLastMonthDateWithMonth:-1],@"endDate":[self getCurrentDate],@"colorSize":@"color"}];
}

- (void)viewWillAppear:(BOOL)animated{

    [self setNavigationModel];
    [self getUrlData];
}

// 设置导航栏的样式
- (void) setNavigationModel{
    self.tabBarController.tabBar.hidden = YES;
    self.currentNavigationController.titleText = @"商品占比";
    [self.currentNavigationController setDIYNavigationBarHidden:NO];
    self.currentNavigationController.isHideReturnBtn = YES;
    [self.currentNavigationController setNavigationScreenButtonHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithData];
    [self createUI];
    [self topViewButtonClickResponder];
}
- (void)createUI{

    _gridView = [[RSPercentReportGridView alloc]init];
    _gridView.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    _gridView.layer.borderWidth = 1.0f;
    [self.view addSubview:_gridView];
    
    _topView = [[RSPercentReportTopView alloc]init];
    [self.view addSubview:_topView];

    
    [self autoLayout];
}
- (void)autoLayout{
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(self.view);
        make.right.equalTo(self.view).offset(-5);
        make.top.equalTo(self.view.mas_top).offset(45);
        make.height.mas_equalTo(50);
    }];
    
    [_gridView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.equalTo(self.view).offset(5);
        make.top.equalTo(_topView.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(0);
    }];
}
// 获取数据
- (void)getUrlData{
    __block RSReportNetwork *network = _reportNetwork;
    [self loadProgressViewIsShow:YES];
    [_reportNetwork postGoodsPercentDataWithUrl:RS_API_CON(RSQueryGoodsSettlementURL,@"") paramsDic:_paramsDic succss:^(NSMutableArray *array){
        
        _gridView.lismodelArray = network.percentReportListArray;
        [_gridView loadFooterViewDataWithModel:network.percentReportSumModel];

        [self loadProgressViewIsShow:NO];
    } fail:^(NSError *error){
        
        [self loadProgressViewIsShow:NO];
    }];
}

// 顶部栏按钮回调
- (void) topViewButtonClickResponder{
    __weak typeof(self) weakSelf = self;
    _topView.percentReportBtn = ^(UIButton *btn){
        
        switch (btn.tag) {
            case kStartDateButtonTag:
            {
                weakSelf.dateButton = btn;
                [weakSelf showCalendar];
                
            }
                break;
            case kEndDateButtonTag:
            {
                weakSelf.dateButton = btn;
                [weakSelf showCalendar];
            }
                break;
            case kColorButtonTag:
            {
            
                NSString *colorSizeString = weakSelf.paramsDic[@"colorSize"];
                NSArray *array = [colorSizeString componentsSeparatedByString:@","];
                NSMutableArray *colorSizeArray = [[NSMutableArray alloc]initWithArray:array];
                if (btn.selected) {
                    
                    if (![colorSizeArray containsObject:@"color"]) {
                        
                        [colorSizeArray addObject:@"color"];
                    }
                    
                }else{
                    
                    if ([colorSizeArray containsObject:@"color"]) {
                        
                        [colorSizeArray removeObject:@"color"];
                    }
                }
                
                colorSizeString = [colorSizeArray componentsJoinedByString:@","];
                [weakSelf.paramsDic setObject:colorSizeString forKey:@"colorSize"];
                
            }
                break;
            case kSizeButtonTag:
            {//尺寸选择
                NSString *colorSizeString = weakSelf.paramsDic[@"colorSize"];
                NSArray *array = [colorSizeString componentsSeparatedByString:@","];
                NSMutableArray *colorSizeArray = [[NSMutableArray alloc]initWithArray:array];
                if (btn.selected) {
                    
                    if (![colorSizeArray containsObject:@"size"]) {
                        
                        [colorSizeArray addObject:@"size"];
                    }
                }else{
                    if ([colorSizeArray containsObject:@"size"]) {
                        [colorSizeArray removeObject:@"size"];
                    }
                }
                colorSizeString = [colorSizeArray componentsJoinedByString:@","];
                [weakSelf.paramsDic setObject:colorSizeString forKey:@"colorSize"];
            }
                break;
            case kQueryButtonTag:
            {
                [weakSelf getUrlData];
            }
                break;
                
            default:
                break;
        }
    };
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
    // 日历数据回调
    __weak typeof (self) weakSelf = self;
    _calendarView.onDateSelectBlk = ^(NSString* dateString){
        
        [weakSelf.dateButton setTitle:dateString forState:0];
        
        //添加日期到参数字典中
        if (weakSelf.dateButton.tag == kStartDateButtonTag) {
            
            [weakSelf.paramsDic setObject:dateString forKey:@"beginDate"];
            
        }else if (weakSelf.dateButton.tag == kEndDateButtonTag){
            
            [weakSelf.paramsDic setObject:dateString forKey:@"endDate"];
        }
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
