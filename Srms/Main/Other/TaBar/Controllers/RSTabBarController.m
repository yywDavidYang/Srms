//
//  RSTabBarController.m
//  iPadDemo
//
//  Created by YYW on 16/7/16.
//  Copyright © 2016年 YYW. All rights reserved.
//

#import "RSTabBarController.h"
#import "Masonry.h"
#import "RSNavigationViewController.h"
#import "RSTabBarTableViewCell.h"
#import "RSNavigationPopView.h"

// 补货
#import "RSHotProductViewController.h"
#import "RSNewProductViewController.h"
#import "RSStockProductViewController.h"
#import "RSRecommendViewController.h"

#import "RSMatchedViewController.h"

// 报表
#import "RSSumReportViewController.h"
#import "RSPercentReportViewController.h"
// 管理
#import "RSMyOrderViewController.h"
#import "RSMyInfoViewController.h"
#import "RSSysSetViewController.h"
// 分类弹窗
#import "RSClassifyPopView.h"



@interface RSTabBarController ()<UITableViewDelegate,UITableViewDataSource>
// 左侧tabBar栏
@property (nonatomic, strong) UIView *tabBarView;
@property (nonatomic, strong) UITableView *tabBarTableView;
@property (nonatomic, strong) NSArray *sectionTitleArray;
@property (nonatomic, strong) NSArray *stockImageArray;
@property (nonatomic, strong) NSArray *stockSelectedImageArray;

@property (nonatomic, strong) NSArray *reportImageArray;
@property (nonatomic, strong) NSArray *reportSelectedImageArray;

@property (nonatomic, strong) NSArray *managerImageArray;
@property (nonatomic, strong) NSArray *managerSelectedImageArray;

@property (nonatomic, strong) NSArray *tagArray;
// 左侧弹窗
@property (nonatomic, strong) RSNavigationPopView *navigationPopView;
// 退出按钮
@property (nonatomic, strong) UIButton *logoutButton;
// 分类弹窗
@property (nonatomic, strong) RSClassifyPopView * classifyView;
// 左侧栏弹出
@property (nonatomic, strong) UIButton *popLeftViewButton;
// tabBar数组
@property(nonatomic,strong) NSMutableArray *viewControllers;
@property(nonatomic,assign) NSInteger selectedIndex;

@end

@implementation RSTabBarController
- (void) initData{
    _sectionTitleArray = @[@"补货",@"报表",@"管理"];
    _viewControllers = [NSMutableArray array];
    _tagArray = @[@[@0,@1,@2,@3,@4],@[@5,@6],@[@7,@8]];
    _stockImageArray = @[[UIImage imageNamed:@"lift30"],[UIImage imageNamed:@"lift32"],[UIImage imageNamed:@"lift34"],[UIImage imageNamed:@"lift36"],[UIImage imageNamed:@"lift60"]];
    _stockSelectedImageArray = @[[UIImage imageNamed:@"lift29"],[UIImage imageNamed:@"lift31"],[UIImage imageNamed:@"lift33"],[UIImage imageNamed:@"lift35"],[UIImage imageNamed:@"lift59"]];
    
    _reportImageArray = @[[UIImage imageNamed:@"lift40"],[UIImage imageNamed:@"lift42"]];
    _reportSelectedImageArray = @[[UIImage imageNamed:@"lift39"],[UIImage imageNamed:@"lift41"]];
    
    _managerImageArray = @[[UIImage imageNamed:@"lift46"],[UIImage imageNamed:@"lift48"]];
    _managerSelectedImageArray = @[[UIImage imageNamed:@"lift45"],[UIImage imageNamed:@"lift47"]];
}
- (instancetype) init{
    
    if (self = [super init]) {
        
        [self initData];
        [self createUI];
        [self setAutolay];
        [self addObserver];
    }
    return self;
}

- (void) createUI{
    _tabBarView = [[UIView alloc]init];
    _tabBarView.backgroundColor = RGBA(247, 247, 247, 1);
    [self.view addSubview:_tabBarView];
    
    _popLeftViewButton = [[UIButton alloc]init];
    _popLeftViewButton.tag = 10111;
    _popLeftViewButton.selected = NO;
    [_popLeftViewButton setBackgroundImage:[UIImage imageNamed:@"lift26"] forState:UIControlStateNormal];
    [_popLeftViewButton addTarget:self action:@selector(popLeftViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tabBarView addSubview:_popLeftViewButton];
    
    _tabBarTableView = [[UITableView alloc]init];
    _tabBarTableView.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    _tabBarTableView.layer.borderWidth = 1.0f;
    _tabBarTableView.backgroundColor = RGBA(247, 247, 247, 1);
    _tabBarTableView.delegate = self;
    _tabBarTableView.dataSource = self;
    _tabBarTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tabBarTableView registerClass:[RSTabBarTableViewCell class] forCellReuseIdentifier:@"RSTabBarTableViewCell"];
    [self.tabBarView addSubview:_tabBarTableView];
    
    _navigationPopView = [[RSNavigationPopView alloc]init];
    [self.view addSubview:_navigationPopView];
    
    _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_logoutButton setBackgroundImage:[UIImage imageNamed:@"lift52"] forState:0];
    [_logoutButton addTarget:self action:@selector(logoutClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tabBarView addSubview:_logoutButton];
    
    _classifyView = [[RSClassifyPopView alloc]init];
    [self.view addSubview:_classifyView];
}
- (void) setAutolay{
    
    [_tabBarView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.width.mas_equalTo(60);
    }];
    
    [_popLeftViewButton mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.top.right.equalTo(self.tabBarView);
        make.height.mas_equalTo(45);
    }];
    
    [_logoutButton mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.bottom.right.equalTo(self.tabBarView);
        make.height.mas_equalTo(45);
    }];
    
    [_tabBarTableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_popLeftViewButton.mas_bottom).offset(0);
        make.left.right.equalTo(_tabBarView);
        make.bottom.equalTo(_logoutButton.mas_top).offset(0);
    }];
    
    [_navigationPopView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(-140);
        make.width.mas_equalTo(140);
    }];
}
- (void) addObserver{
    // 弹出左边栏的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(obserNotification:) name:@"popLeftView" object:nil];
    // 全局分类的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obserNotification:) name:@"classifyView" object:nil];
    // 打开我的搭配的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obserNotification:) name:@"collocationPoolOpenMyCollocation" object:nil];
}

- (void)obserNotification:(NSNotification *)noti{
    
    if ([noti.name isEqualToString:@"popLeftView"]) {
        
        if ([noti.object isEqualToString:@"1"]) {
            
            [self showOrCloseLeftPopView:YES];
        }else{
            
            [self showOrCloseLeftPopView:NO];
        }
    }else if ([noti.name isEqualToString:@"classifyView"]){
        [self.view bringSubviewToFront:self.classifyView];
        [self.classifyView show];
    }else if ([noti.name isEqualToString:@"collocationPoolOpenMyCollocation"]){
        //打开搭配
        self.selectedIndex = 4;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
        RSTabBarTableViewCell *viewCell = [_tabBarTableView cellForRowAtIndexPath:indexPath];
       // 获取button
        UIButton *selectBtn = [viewCell viewWithTag:self.selectedIndex];
        // 改变tabBar中的button的背景图片
        [self changeTableViewCellColorWithButton:selectBtn];
        [self changeSubViewController];
    }
}

- (void) showOrCloseLeftPopView:(BOOL)isShow{
    
    if (isShow) {
        
        [UIView animateWithDuration:0.50f animations:^{
            
            [_navigationPopView mas_updateConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(self.view.mas_left).offset(0);
            }];
        }];
        [_navigationPopView layoutIfNeeded];
        
    }
    else{
        [UIView animateWithDuration:0.50f animations:^{
            
            [_navigationPopView mas_updateConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(self.view.mas_left).offset(-145);
            }];
            [_navigationPopView layoutIfNeeded];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarController];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 5;
    }
    else if(section == 1){
        
        return 2;
    }
    else{
        
        return 2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RSTabBarTableViewCell *cell = [RSTabBarTableViewCell cellWithTableView:tableView];
    NSArray *selectedArray = _tagArray[indexPath.section];
    NSNumber *number = selectedArray[indexPath.row];
    switch (indexPath.section) {
        case 0:
        {
            [cell loadImageWithImage:_stockImageArray[indexPath.row] selectImage:_stockSelectedImageArray[indexPath.row] tag:[number integerValue]];
            if (indexPath.row == 0) {
                
                UIButton *btn = [cell.contentView.subviews firstObject];
                btn.selected = YES;
            }
        }
            break;
        case 1:
        {
            [cell loadImageWithImage:_reportImageArray[indexPath.row] selectImage:_reportSelectedImageArray[indexPath.row] tag:[number integerValue]];
        }
            break;
        case 2:
        {
    
            [cell loadImageWithImage:_managerImageArray[indexPath.row] selectImage:_managerSelectedImageArray[indexPath.row] tag:[number integerValue]];
        }
            break;
            
        default:
            break;
    }
    cell.buttonReturnBlock = ^(UIButton *button){
        
        self.selectedIndex = button.tag;
        [self changeTableViewCellColorWithButton:button];
        [self changeSubViewController];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *headerId = @"headerView";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerId];
    }
    headerView.contentView.backgroundColor = RGBA(247, 247, 247, 1);
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor grayColor];
    [headerView.contentView addSubview:lineView];
    
    UILabel *sectionTitle = [[UILabel alloc]init];
    sectionTitle.font  = [UIFont systemFontOfSize:20 weight:3];
    sectionTitle.textAlignment = NSTextAlignmentCenter;
    sectionTitle.text = _sectionTitleArray[section];
    sectionTitle.textColor = [UIColor blackColor];
    [headerView.contentView addSubview:sectionTitle];
    [sectionTitle mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.edges.equalTo(headerView);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.top.right.equalTo(headerView);
        make.height.mas_equalTo(2);
    }];
    if (section == 0) {
        
        sectionTitle.textColor = RGBA(67, 170, 77, 1);
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return  65;
}

// 左边栏弹出
- (void)popLeftViewClick:(UIButton *)popButton{
  
    
}
- (void) changeTableViewCellColorWithButton:(UIButton *)button{

    NSArray *allCellArray = [_tabBarTableView indexPathsForVisibleRows];
    NSIndexPath *sectionPath;
    for (NSIndexPath *indexPath in allCellArray) {
        
        RSTabBarTableViewCell *cell  = [_tabBarTableView cellForRowAtIndexPath:indexPath];
        for(UIButton *btn in cell.contentView.subviews) {
            
            btn.selected = NO;
            if ([btn isEqual:button]) {
                
                sectionPath = indexPath;
            }
        }
    }
    for (NSInteger i = 0; i < 3; i ++) {
       
        UITableViewHeaderFooterView *headerView = [_tabBarTableView headerViewForSection:i];
        UILabel *sectionTitle = headerView.contentView.subviews[1];
        sectionTitle.textColor = [UIColor blackColor];
    }
    UITableViewHeaderFooterView *headerView = [_tabBarTableView headerViewForSection:sectionPath.section];
    UILabel *sectionTitle = headerView.contentView.subviews[1];
    sectionTitle.textColor = RGBA(67, 170, 77, 1);
    button.selected = YES;
}

- (void)logoutClick:(UIButton *)btn{
    
    [self.appDelegate loginController];
}

- (void) changeSubViewController{
    if(self.currentNaviVC){
        
        [self.currentNaviVC.view removeFromSuperview];
        [self.currentNaviVC removeFromParentViewController];
        self.currentNaviVC = nil;
    }
    self.currentNaviVC = [[RSNavigationViewController alloc]initWithRootViewController:self.viewControllers[self.selectedIndex]];
    id vc = self.viewControllers[self.selectedIndex];
    if ([vc isKindOfClass:[RSHotProductViewController class]]) {
        
       RSHotProductViewController *currentVC = (RSHotProductViewController *)vc;
        currentVC.currentNavigationController = self.currentNaviVC;
    }else if ([vc isKindOfClass:[RSNewProductViewController class]]){
        
        RSNewProductViewController *currentVC = (RSNewProductViewController *)vc;
        currentVC.currentNavigationController = self.currentNaviVC;
    }
    else if ([vc isKindOfClass:[RSStockProductViewController class]]){
        
        RSStockProductViewController *currentVC = (RSStockProductViewController *)vc;
        currentVC.currentNavigationController = self.currentNaviVC;
    }
    else if ([vc isKindOfClass:[RSRecommendViewController class]]){
        
        RSRecommendViewController *currentVC = (RSRecommendViewController *)vc;
        currentVC.currentNavigationController = self.currentNaviVC;
    }
    else if ([vc isKindOfClass:[RSMatchedViewController class]]){
        
        RSMatchedViewController *currentVC = (RSMatchedViewController *)vc;
        currentVC.currentNavigationController = self.currentNaviVC;
    }
    else if ([vc isKindOfClass:[RSSumReportViewController class]]){
        
        RSSumReportViewController *currentVC = (RSSumReportViewController *)vc;
        currentVC.currentNavigationController = self.currentNaviVC;
        
    }else if ([vc isKindOfClass:[RSPercentReportViewController class]]){
        RSPercentReportViewController *currentVC = (RSPercentReportViewController *)vc;
        currentVC.currentNavigationController = self.currentNaviVC;
        
    }else if ([vc isKindOfClass:[RSMyOrderViewController class]]){
        
        RSMyOrderViewController *currentVC = (RSMyOrderViewController *)vc;
        currentVC.currentNavigationController = self.currentNaviVC;
    }else if ([vc isKindOfClass:[RSMyInfoViewController class]]){
        
        RSMyInfoViewController *currentVC = (RSMyInfoViewController *)vc;
        currentVC.currentNavigationController = self.currentNaviVC;
    }
    self.currentNaviVC.view.frame = CGRectMake(60, 0, self.view.frame.size.width - 45, self.view.frame.size.height);
    [self.view insertSubview:self.currentNaviVC.view belowSubview:_tabBarTableView];
}

- (void) setTabBarController{
    
    // 补货
    RSHotProductViewController *hotProductVC = [[RSHotProductViewController alloc]init];
    hotProductVC.hidesBottomBarWhenPushed = YES;
    RSNewProductViewController *newProductVC = [[RSNewProductViewController alloc]init];
    newProductVC.hidesBottomBarWhenPushed = YES;
    RSStockProductViewController *stockVC = [[RSStockProductViewController alloc]init];
    stockVC.hidesBottomBarWhenPushed = YES;
    RSRecommendViewController *recommendVC = [[RSRecommendViewController alloc]init];
    recommendVC.hidesBottomBarWhenPushed = YES;
    // 搭配
    RSMatchedViewController  * matchedVC =[[RSMatchedViewController alloc] init];
    matchedVC.hidesBottomBarWhenPushed = YES;
    //报表
    RSSumReportViewController *sumReportVC = [[RSSumReportViewController alloc]init];
    sumReportVC.hidesBottomBarWhenPushed = YES;
    RSPercentReportViewController *percentVC = [[RSPercentReportViewController alloc]init];
    percentVC.hidesBottomBarWhenPushed = YES;
    // 管理
    RSMyOrderViewController *orderVC = [[RSMyOrderViewController alloc]init];
    orderVC.hidesBottomBarWhenPushed = YES;
    RSMyInfoViewController *infoVC = [[RSMyInfoViewController alloc]init];
    infoVC.hidesBottomBarWhenPushed = YES;

    self.viewControllers = [NSMutableArray arrayWithObjects:hotProductVC,newProductVC,stockVC,recommendVC,matchedVC,sumReportVC,percentVC,orderVC,infoVC, nil];
    
    // 补货
    RSNavigationViewController *hotProductVC_Navi = [[RSNavigationViewController alloc]initWithRootViewController:hotProductVC];
    hotProductVC.currentNavigationController = hotProductVC_Navi;
    self.currentNaviVC = hotProductVC_Navi;
     self.currentNaviVC.view.frame = CGRectMake(60, 0,DeviceWidth - 60, self.view.frame.size.height);
    [self.view addSubview:self.currentNaviVC.view];
    [self addChildViewController:self.currentNaviVC];
}

// 隐藏tabBar
- (void) setIsHiddenTabBar:(BOOL)isHiddenTabBar{
    
    _isHiddenTabBar = isHiddenTabBar;
    self.tabBarView.hidden = _isHiddenTabBar;
}


- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"tab 已经被销毁");
}

@end
