//
//  LoginViewController.h
//  CloudShoping
//
//  Created by ohm on 16/5/30.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RSNavigationViewController.h"
//#import <AFNetworking/AFNetworking.h>
@interface LoginViewController : UIViewController<UITextFieldDelegate>{

    __weak IBOutlet UIButton *enterButton;
    NSString * nameString;
    NSString * passWord;
   

}
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *passWordTf;
@property (weak, nonatomic) IBOutlet UITextField *shopTf;
@property (weak, nonatomic) IBOutlet UILabel *loginTipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (weak, nonatomic) IBOutlet UIButton *channelNameSelectBtn;

@property (nonatomic,strong) RSNavigationViewController *currentNavigationController;
@property (nonatomic, strong) AppDelegate *appDelegate;

@end
