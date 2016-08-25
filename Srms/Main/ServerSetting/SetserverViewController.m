//
//  SetserverViewController.m
//  Srms
//
//  Created by ohm on 16/6/1.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "SetserverViewController.h"
//#import "PublicKit.h"
//#define SERVER_ADDRESS_KEY @"ServerServicesUrl" //服务地址KEY
@interface SetserverViewController ()

@end

@implementation SetserverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    viewSet =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    viewSet.image =[UIImage imageNamed:@"bg.jpg"];
    viewSet.alpha=1.0;
    [self.view addSubview:viewSet];
    

    UIView * imageView =[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-240, self.view.frame.size.height/2-200, 480, 240)];
    imageView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:imageView];
    
    tf =[[UITextField alloc] initWithFrame:CGRectMake(15, 80, 450, 60)];
    tf.textAlignment = NSTextAlignmentLeft;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.placeholder = @"输入服务器地址";
    NSString *servicesUrl =[PublicKit getPlistParameter:SERVER_ADDRESS_KEY];
    [tf setText:servicesUrl];
    tf.textColor = [UIColor brownColor];
    tf.font=[UIFont systemFontOfSize:14.0f];
    [imageView addSubview:tf];
    
    UILabel * titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(160, 0, 160, 30)];
    titleLabel.text = @"服务器地址设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font=[UIFont systemFontOfSize:14.0f];
    [imageView addSubview:titleLabel];
    
    UIButton * setBackButton =[[UIButton alloc] initWithFrame:CGRectMake(5, 200, 230, 35)];
    setBackButton.backgroundColor = [UIColor greenColor];
    [setBackButton setTitle:@"取消" forState:UIControlStateNormal];
    [setBackButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:setBackButton];
    
    
    UIButton * setButton =[[UIButton alloc] initWithFrame:CGRectMake(240, 200, 230, 35)];
    setButton.backgroundColor = [UIColor greenColor];
    [setButton setTitle:@"确定" forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:setButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"点击");
    [tf resignFirstResponder];
    
}

-(void)backButton{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)buttonClick{
    
    if (![tf.text isEqualToString:@""]||tf.text !=nil) {
        [PublicKit setPlistParameter:tf.text setKey:SERVER_ADDRESS_KEY];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    
    
    }
    
    
}

@end
