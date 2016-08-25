//
//  LoginViewController.m
//  CloudShoping
//
//  Created by ohm on 16/5/30.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "LoginViewController.h"
#import "SetserverViewController.h"
#import "RSHotProductViewController.h"
#import "ShoppingCartViewController.h"
#import "RSTabBarController.h"
#import "RSNavigationViewController.h"
#import "RSLoginModel.h"
#import "RSLoginChannelView.h"
#import "RSLoginChannelInfoListModel.h"

#define kLoginAccountNillTipsMess  @"提示:请输入您的帐号!"
#define kLoginAccountBlankSpaceTipsMess  @"提示:您的账号存在空格符!"
#define kLoginPasswordNillTipsMess  @"提示:请输入您的密码!"
#define kLoginShopNameNillTipsMess  @"提示:请输入选择店铺!"
#define kLoginWrongTipsMess  @"提示:账号或者密码错误!"
#define kLoginUrlTipsMess  @"提示:配置域名或者网络异常!"
#define kLoginServerMess  @"提示:配置服务器地址!"

@interface LoginViewController ()
@property (nonatomic, retain) NSMutableData* buffer1;
// 加载动画
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property(nonatomic,strong) RSLoginModel *loginModel;
@property(nonatomic,strong) RSLoginChannelView *loginChannelView;
@property (nonatomic,strong) NSMutableArray *shopNameArray;

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
   [enterButton setBackgroundImage:[UIImage imageNamed:@"btn1登录"] forState:UIControlStateNormal];
    enterButton.backgroundColor =RGBA(224, 143, 61, 1.0f);
    [self.currentNavigationController setDIYNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];  
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    _loginModel = [[RSLoginModel alloc]init];
    _nameTf.textAlignment = NSTextAlignmentCenter;
    _passWordTf.textAlignment = NSTextAlignmentCenter;
    _shopTf.textAlignment = NSTextAlignmentCenter;
    _shopTf.delegate  = self;
    [_shopTf addTarget:self action:@selector(shopNameValueChange:) forControlEvents:UIControlEventEditingChanged];
    _passWordTf.delegate=self;
    _nameTf.text = [PublicKit getPlistParameter:NameTextString];
    _versionLabel.text = [self versionFromCurrenApp];
     _loginTipsLabel.hidden = YES;
    [self loadActivityView];
}

// 设置弹出框
- (void)createPopUIView{
    if(_loginChannelView == nil){
        
        _loginChannelView = [[RSLoginChannelView alloc]init];
        _loginChannelView.hidden = YES;
        [self.view addSubview:_loginChannelView];
    
        [_loginChannelView mas_makeConstraints:^(MASConstraintMaker *make){
        
            make.left.equalTo(_shopTf.mas_left).offset(0);
            make.bottom.equalTo(_shopTf.mas_top);
            make.width.equalTo(_shopTf);
            make.height.mas_equalTo(_loginModel.channelInfoList.count * 44 > 400?400:_loginModel.channelInfoList.count * 44);
        }];
        RS_WeakSelf weaks = self;
        _loginChannelView.channelNemeBlock = ^(NSString *channelName){
            RS_StrongSelf self = weaks;
            self.shopTf.text = channelName;
            [PublicKit setPlistParameter:channelName setKey:self.nameTf.text];
            self.loginChannelView.hidden = YES;
        };
    }
}

// 监听店铺字符串的输入,模糊搜索结果反馈
- (void)shopNameValueChange:(UITextField *)textField{
    if (_loginModel.channelInfoList.count > 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",textField.text];
        NSArray *selectedArray = [_shopNameArray filteredArrayUsingPredicate:predicate];
        _loginChannelView.dataArray = selectedArray;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.shopTf]) {
        // 每次开始编辑时重新显示和加载店铺全部列表
        _loginChannelView.hidden = NO;
        _loginChannelView.dataArray = _shopNameArray;
    }else{
        
        _loginTipsLabel.hidden = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.passWordTf]) {
        
        _shopTf.text = @"";
        if ([_nameTf.text isEqualToString:@""] || _nameTf.text == nil) {
        
            _loginTipsLabel.text = kLoginAccountNillTipsMess;
            _loginTipsLabel.hidden = NO;
            return;
        }
        if ([_passWordTf.text isEqualToString:@""] || _passWordTf.text == nil) {
        
            _loginTipsLabel.text = kLoginPasswordNillTipsMess;
            _loginTipsLabel.hidden = NO;
            return;
        }
        
        NSString * serveSreing =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
        if([serveSreing isEqualToString:@""]||serveSreing == nil){
        
            _loginTipsLabel.text = kLoginServerMess;
            _loginTipsLabel.hidden = NO;
            return;
        }
        _loginTipsLabel.hidden = YES;
        
        nameString =[_nameTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
        passWord =_passWordTf.text;
        if (nameString !=nil && passWord !=nil) {
            NSString * serveSreing =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
            NSString * urlString =[NSString stringWithFormat:@"%@/rs/user/login",serveSreing];
           
            NSDictionary *parameters = @{@"userAccount": nameString,@"userPwd":passWord};
            [self indicatorViewStart];
            [[RSNetworkManager sharedManager] POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                _shopNameArray = [NSMutableArray array];
                _loginTipsLabel.hidden = YES;
                NSError *err;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
                NSLog(@"------>%@",dic);
                if([dic[@"msg"] isEqualToString:@"账号或密码错误！"]){
                    
                    _loginTipsLabel.hidden = NO;
                    _loginTipsLabel.text = kLoginWrongTipsMess;
                    [self indicatorViewStop];
                    return ;
                }
                NSDictionary * data =[dic objectForKey:@"data"];
                NSDictionary * dictionary =[[data objectForKey:@"channelInfoList"] firstObject];
                _shopTf.text = [dictionary objectForKey:@"channelName"];
                NSString * ischeckstockString = [NSString stringWithFormat:@"%@",[data objectForKey:@"ischeckstock"]];
                NSString * maxstockString = [NSString stringWithFormat:@"%@",[data objectForKey:@"maxstock"]];
                // 建模
                [_loginModel setValuesForKeysWithDictionary:data];
                //是否校验库存
                [PublicKit setPlistParameter:ischeckstockString setKey:IScheckstock];
                // 最大库存量
                [PublicKit setPlistParameter:maxstockString setKey:Maxstock];
                // 登录名
                [PublicKit setPlistParameter:nameString setKey:NameTextString];
                // 登录密码
                [PublicKit setPlistParameter:passWord setKey:PassWordString];
                //登录店铺的编号
                [PublicKit setPlistParameter:[dictionary objectForKey:@"channelCode"] setKey:channelCodeString];
                // 店铺的地址
                [PublicKit setPlistParameter:[dictionary objectForKey:@"channelAddress"] setKey:RSChannelAddress];
                // 店铺名称
                if (_loginModel.channelInfoList.count == 1) {
                    
                    [PublicKit setPlistParameter:[dictionary objectForKey:@"channelName"] setKey:_nameTf.text];
                    _shopTf.text = [dictionary objectForKey:@"channelName"];
                }
                // 刷新选择框
                [self createPopUIView];
                // 获取店铺的数组
                for (RSLoginChannelInfoListModel *listModel in _loginModel.channelInfoList) {
                    
                    [_shopNameArray addObject:listModel.channelName];
                }
                _loginChannelView.dataArray = _shopNameArray;
                _loginTipsLabel.hidden = YES;
                [self indicatorViewStop];
                
                // 显示默认渠道号
                NSString *channelName = [PublicKit getPlistParameter:_nameTf.text];
                _shopTf.text = channelName;
                if (!channelName || [channelName isEqualToString:@""]) {
                    _shopTf.text = channelName;
                }else{
                    _shopTf.text = [dictionary objectForKey:@"channelName"];
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                _loginTipsLabel.hidden = NO;
                _loginTipsLabel.text = kLoginUrlTipsMess;
                [self indicatorViewStop];
            }];
        }
    }else if ([self.shopTf isEqual:textField]){
        
        
    }
}

- (IBAction)butSetClick:(id)sender {
    
    SetserverViewController * serverView = [[SetserverViewController alloc] init];
    serverView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:serverView animated:YES];
}

- (IBAction)butNext:(id)sender {
    
    if (![_shopTf.text isEqualToString:@""]) {
        _loginTipsLabel.hidden = YES;
        [PublicKit setPlistParameter:_shopTf.text setKey:_nameTf.text];
        RSTabBarController *tabBarController = [[RSTabBarController alloc]init];
        tabBarController.appDelegate = self.appDelegate;
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;
        [self.appDelegate.window makeKeyAndVisible];
        [self httpGetOrders];
        
    }else{
        
        _loginTipsLabel.text = kLoginShopNameNillTipsMess;
        _loginTipsLabel.hidden = NO;
    }
}

// 获取版本号
- (NSString *)versionFromCurrenApp{
    
    NSString *nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    nowVersion = [NSString stringWithFormat:@"当前版本: %@",nowVersion];
    return nowVersion;
}

// 添加加载动画
- (void) loadActivityView{
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_indicatorView stopAnimating];
    [enterButton addSubview:_indicatorView];
    //登录加载
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.mas_equalTo(enterButton);
    }];
}
// 开始加载圈
- (void) indicatorViewStart{
    [enterButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    enterButton.userInteractionEnabled = NO;
    [_indicatorView startAnimating];
}
// 停止加载圈
- (void) indicatorViewStop{
    [_indicatorView stopAnimating];
    [enterButton setBackgroundImage:[UIImage imageNamed:@"btn1登录"] forState:UIControlStateNormal];
    enterButton.userInteractionEnabled = YES;
}


//获取订单数据的请求
-(void)httpGetOrders{
    
    NSString * serveSreing =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    NSString * userNo =[PublicKit getPlistParameter:NameTextString];
    NSString * channelCode =[PublicKit getPlistParameter:channelCodeString];
    
    NSString * urlString =[NSString stringWithFormat:@"%@/rs/ordersgoods/getorder",serveSreing];
    NSMutableDictionary * paramdic = [[NSMutableDictionary alloc] init];
    
    [paramdic setObject:channelCode forKey:@"customer_id"];
    [paramdic setObject:userNo forKey:@"userNo"];
    
    [[RSNetworkManager sharedManager] POST:urlString parameters:paramdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        NSMutableArray *  _dataArray = [dic objectForKey:@"data"];
        [[ShopSaveManage shareManager] deleteTableDataByFieldNameValue:@"ProductData" fieldName:nil fieldValue:nil];
        if (_dataArray.count>0) {
            for (NSDictionary * goosInfoDictionary in _dataArray) {
                [[ShopSaveManage shareManager] saveLocaOrderProduct:goosInfoDictionary];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shoppingCarAccountNoti" object:self];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
    _loginChannelView.hidden = YES;
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

@end
