//
//  MyInformationViewController.m
//  CloudShoping
//
//  Created by ohm on 16/5/30.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSMyInfoViewController.h"

@interface RSMyInfoViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *LogoImage;//店铺的Logo
@property (nonatomic, strong) UILabel *shopNmae;//店铺名字
@property (nonatomic, strong) UILabel *addressLab;//地址
@property (nonatomic, strong) UILabel *lastLogin;//最后登录时间
@property (nonatomic, strong) UILabel *userName;//用户名字
@property (nonatomic, strong) UIButton *changeInfo;//修改信息
@property (nonatomic, strong) UIView *coverView;//盖在上面的view
@property (nonatomic, strong) UIView *changePwd;//修改密码的view
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *oldPwdString;
@property (nonatomic, copy) NSString *surePwdString;
@property (nonatomic, copy) NSString *NewPwdString;
@property (nonatomic, strong) UITextField *userNameTf;
@property (nonatomic, strong) UITextField *oldPwdTf;
@property (nonatomic, strong) UITextField *NewPwdTf;
@property (nonatomic, strong) UITextField *surePwdTf;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIImageView *oldImageView;
@property (nonatomic, strong) UIImageView *sureImageView;
@end

@implementation RSMyInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    _titleArray = @[@"用户名",@"旧密码",@"新密码",@"确认密码"];
    [self setNavigationModel];
}
// 设置导航栏的样式
- (void) setNavigationModel{
     self.tabBarController.tabBar.hidden = YES;
    self.currentNavigationController.titleText= @"我的信息";
    self.currentNavigationController.isHideReturnBtn = YES;
    [self.currentNavigationController setDIYNavigationBarHidden:NO];
    [self.currentNavigationController setNavigationScreenButtonHidden:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor grayColor];
    // 背景
    self.imageView = [[UIImageView alloc]init];
    self.imageView.image = [UIImage imageNamed:@"我的信息背景图片.jpg"];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.edges.equalTo(self.view);
    }];
    
    self.userName = [[UILabel alloc]init];
    self.userName.font = [UIFont systemFontOfSize:19 weight:1.0f];
    self.userName.text = [NSString stringWithFormat:@"用户名: %@",[PublicKit getPlistParameter:NameTextString]];
    self.userName.textColor = [UIColor whiteColor];
    [self.view addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(270);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(300);
    }];
    
    self.shopNmae = [[UILabel alloc]init];
    self.shopNmae.font = [UIFont systemFontOfSize:19 weight:1.0f];
    self.shopNmae.text = [NSString stringWithFormat:@"店铺名: %@",[PublicKit getPlistParameter:[PublicKit getPlistParameter:NameTextString]]];
    self.shopNmae.textColor = [UIColor whiteColor];
    [self.view addSubview:self.shopNmae];
    [self.shopNmae mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.userName.mas_bottom).offset(20);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(300);
    }];
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.font = [UIFont systemFontOfSize:19 weight:1.0f];
    self.addressLab.text = [NSString stringWithFormat:@"地    址: %@",[PublicKit getPlistParameter:RSChannelAddress]];
    self.addressLab.textColor = [UIColor whiteColor];
    [self.view addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.shopNmae.mas_bottom).offset(20);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(300);
    }];
    
    // 最后的登录时间
    NSString *lastLoginTime = [PublicKit getPlistParameter:RSLastLoginTime];
    self.lastLogin = [[UILabel alloc]init];
    self.lastLogin.text = [NSString stringWithFormat:@"最后登录时间：%@",lastLoginTime?lastLoginTime:@""];
    self.lastLogin.backgroundColor = RGBA(4, 66, 3, 1.0f);
    self.lastLogin.textColor = [UIColor whiteColor];
    self.lastLogin.textAlignment = NSTextAlignmentCenter;
    self.lastLogin.font = [UIFont systemFontOfSize:15 weight:1.0f];
    [self.view addSubview:self.lastLogin];
    [self.lastLogin mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.addressLab.mas_bottom).offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(300);
    }];
    
    self.changeInfo = [[UIButton alloc]initWithFrame:CGRectMake(400, 620, 200, 60)];
    [self.changeInfo setBackgroundImage:[UIImage imageNamed:@"修改信息.png"] forState:UIControlStateNormal];
    [self.changeInfo setBackgroundImage:[UIImage imageNamed:@"修改信息点击.png"] forState:UIControlStateHighlighted];
    self.changeInfo.layer.cornerRadius = 10.0;
    [self.view addSubview:self.changeInfo];
    self.changeInfo.contentMode = UIViewContentModeScaleAspectFit;
    [self.changeInfo addTarget:self action:@selector(changeInfoClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeInfo mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.equalTo(self.lastLogin.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(250);
    }];
    
}

- (void)changeInfoClick:(UIButton*)btn{

    //    点击cell的时候弹出一个view
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *coverView = [[UIView alloc]init];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.frame = window.bounds;
    coverView.alpha = 0.5;
    self.coverView = coverView;
    [self.view addSubview:coverView];
    
   // coverView上加一个view
    CGSize size = window.bounds.size;
    UIView *changePwd = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 500, size.height - 200)];
    changePwd.backgroundColor = [UIColor whiteColor];
    changePwd.center = window.center;
    [self.view addSubview:changePwd];
    self.changePwd = changePwd;
    
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 500, 40)];
    titleImageView.backgroundColor = RGBA(0, 167, 75, 1.0f);
    titleImageView.userInteractionEnabled = YES;
    [changePwd addSubview:titleImageView];
    
    // view上的关闭按钮
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"popViewCloseBtn"] forState:UIControlStateNormal];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"popViewCloseBtn3"] forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    // 把按钮添加到活动的图片上
    [titleImageView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.right.top.equalTo(titleImageView);
        make.height.equalTo(titleImageView.mas_height);
        make.width.mas_equalTo(60);
    }];
    
    UILabel *headerLabel = [[UILabel alloc]init];
    headerLabel.text = @"修改密码";
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont systemFontOfSize:18];
    [titleImageView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerX.equalTo(titleImageView.mas_centerX);
         make.centerY.equalTo(titleImageView.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *lastTitleLabel = nil;
    for (NSInteger i = 0; i < 5; i ++) {
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [changePwd addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.right.equalTo(changePwd);
            make.height.mas_equalTo(1);
            make.top.equalTo(lastTitleLabel?lastTitleLabel.mas_bottom:titleImageView.mas_bottom).offset(lastTitleLabel?5:10);
        }];
        
        if (i < 4) {
            
            UILabel *titleLabel = [[UILabel alloc]init];
            //    headerLabel.backgroundColor = [UIColor redColor];
            titleLabel.text = _titleArray[i];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.font = [UIFont systemFontOfSize:18];
            [changePwd addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(changePwd.mas_left).offset(40);
                make.top.equalTo(lineLabel.mas_bottom).offset(5);
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(40);
            }];
            
            UIImageView *imageJudge = [[UIImageView alloc]init];
            imageJudge.backgroundColor = [UIColor whiteColor];
            [changePwd addSubview:imageJudge];
            [imageJudge mas_makeConstraints:^(MASConstraintMaker *make){
            
                make.right.equalTo(changePwd.mas_right).offset(-5);
                make.top.equalTo(lineLabel.mas_bottom).offset(15);
                make.height.mas_equalTo(20);
                make.width.mas_equalTo(20);
            }];
            
            UITextField *textField = [[UITextField alloc]init];
            textField.secureTextEntry = YES;
            textField.delegate = self;
            textField.backgroundColor = [UIColor whiteColor];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [changePwd addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(titleLabel.mas_right).offset(5);
                make.right.equalTo(imageJudge.mas_left).offset(-5);
                make.top.equalTo(lineLabel.mas_bottom).offset(5);
                make.height.mas_equalTo(40);
                
            }];
            switch (i) {
                case 0:{
                    textField.text = [PublicKit getPlistParameter:NameTextString];
                    textField.secureTextEntry = NO;
                    self.userNameTf = textField;
                }
                    break;
                case 1:
                {
                    self.oldImageView = imageJudge;
                    textField.placeholder = @"请输入旧密码...";
                    textField.clearButtonMode = UITextFieldViewModeAlways;
                    self.oldPwdTf = textField;
                }
                    break;
                case 2:
                {
                    textField.clearButtonMode = UITextFieldViewModeAlways;
                    textField.placeholder = @"请输入新密码...";
                    self.NewPwdTf = textField;
                }
                    break;
                case 3:
                {
                    self.sureImageView = imageJudge;
                    self.surePwdTf = textField;
                    textField.placeholder = @"请再次新密码...";
                    textField.clearButtonMode = UITextFieldViewModeAlways;
                }
                    break;
                    
                default:
                    break;
            }
            lastTitleLabel = titleLabel;
        }
    }
    // 保存按钮
    UIButton *saveBtn = [[UIButton alloc]init];
    [changePwd addSubview:saveBtn];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"保存按钮.png"] forState:UIControlStateNormal];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"保存按钮点击.png"] forState:UIControlStateSelected];
    [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerX.equalTo(changePwd.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(45);
        make.bottom.equalTo(changePwd.mas_bottom).offset(-110);
    }];
}
// 取消用户名的编辑状态
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.userNameTf]) {
        
        return NO;
    }
    else{
        
        return YES;
    }
}

- (void)textFieldDidChange:(UITextField*)textField{//类似UIButton addTag..监听方法
    
    if ([textField isEqual:self.oldPwdTf]) {
        
        if ([self.oldPwdTf.text isEqualToString:@""] ) {
            
            self.oldImageView.image = [UIImage imageNamed:@""];
        }else{
            
            if (![self.oldPwdTf.text isEqualToString:[PublicKit getPlistParameter:PassWordString]]) {
                
                self.oldImageView.image = [UIImage imageNamed:@"我的信息3"];
            }else{
                
                 self.oldImageView.image = [UIImage imageNamed:@"我的信息4"];
            }
        }
    }else if ([textField isEqual:self.surePwdTf]){
        
        if ([self.surePwdTf.text isEqualToString:@""] ) {
            
             self.sureImageView.image = [UIImage imageNamed:@""];
        }else{
            
            if (![self.surePwdTf.text isEqualToString:self.NewPwdTf.text]) {
                
                self.sureImageView.image = [UIImage imageNamed:@"我的信息3"];
            }else{
                
                self.sureImageView.image = [UIImage imageNamed:@"我的信息4"];
            }
        }
    }
    NSLog(@"输入框内容 = %@",textField.text);
}

//点击弹出view上的关闭按钮
- (void)closeClick{

        [UIView animateWithDuration:0.5 animations:^{
            
            self.coverView.y -= [UIScreen mainScreen].bounds.size.height;
            self.changePwd.y -= [UIScreen mainScreen].bounds.size.height;
            
        } completion:^(BOOL finished) {
            
            [self.changePwd removeFromSuperview];
            [self.coverView removeFromSuperview];
        }];
}

//点击保存按钮
- (void)saveBtnClick:(UIButton *)btn{

    self.nameString = self.userNameTf.text;
    self.NewPwdString = self.NewPwdTf.text;
    self.surePwdString = self.surePwdTf.text;
    if(![self.oldPwdTf.text isEqualToString:[PublicKit getPlistParameter:PassWordString]]){
        
        [self showWithMessage:@"密码错误"];
        return;
    }
    if([self.oldPwdTf.text isEqualToString:@""]){
        
        [self showWithMessage:@"请输入旧密码"];
        return;
    }
    if([self.NewPwdTf.text isEqualToString:@""]){
        
        [self showWithMessage:@"请输入新密码"];
        return;
    }
    if([self.surePwdTf.text isEqualToString:@""]){
        
        [self showWithMessage:@"请再次输入新密码"];
        return;
    }
    if(![self.NewPwdTf.text isEqualToString:self.surePwdTf.text]){
        
        [self showWithMessage:@"新密码不一致"];
        return;
    }
    if (self.nameString && [self.surePwdString isEqualToString:self.NewPwdString]) {
        
        NSString * serveString =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
        NSString * urlString =[NSString stringWithFormat:@"%@/rs/user/modifypwd",serveString];
        
        NSDictionary *parameters = @{@"userAccount": self.nameString,@"userPwd":self.surePwdString};
        [[RSNetworkManager sharedManager] POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
            NSLog(@"dic === %@",dic);
            if ([[dic objectForKey:@"msg" ]isEqualToString:@""]) {
                
                [self showWithMessage:[dic objectForKey:@"data"]];
            }else if ([[dic objectForKey:@"data"] isEqualToString:@""]){
                NSLog(@"msg = %@",[dic objectForKey:@"msg"]);
                [self showWithMessage:[dic objectForKey:@"msg"]];
            }
            [PublicKit setPlistParameter:self.surePwdString setKey:PassWordString];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self showWithMessage:@"修改密码失败。。"];
        }];
    }
}

#pragma mark --- 提示框(MBProgressHUD) ---
-(void)showWithMessage:(NSString *)string
{
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[MBProgressHUD class]]) {
            
            [view removeFromSuperview];
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.center = self.changePwd.center;
    hud.yOffset = 100.0f;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = string;
    hud.margin = 20.f;
    hud.labelFont = [UIFont systemFontOfSize:12];
    hud.removeFromSuperViewOnHide = YES;
    [self.view bringSubviewToFront:hud];
    [hud hide:YES afterDelay:2.0];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
- (BOOL)prefersStatusBarHidden{
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
