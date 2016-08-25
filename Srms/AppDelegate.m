//
//  AppDelegate.m
//  Srms
//
//  Created by ohm on 16/5/31.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "LoginViewController.h"
#import "RSNavigationViewController.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>
@interface AppDelegate ()<UIAlertViewDelegate>{
    NSString * pgyUrl;


}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor blackColor];
    [[CoreDataManager shareManager] saveContext];
    [[PgyManager sharedPgyManager] startManagerWithAppId:PGY_APP_ID];//蒲公英内测
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:PGY_APP_ID];
    [PgyManager sharedPgyManager].enableFeedback = NO;
    
    //蒲公英检查更新
    //   [[PgyManager sharedPgyManager] checkUpdate];
    //强制更新需要自定义UIAlertView 触发按钮后的操作
    [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
    
    [self loginController];
    return YES;
}

//检查更新的回调
- (void)updateMethod:(NSDictionary *)response
{
    if (response[@"downloadURL"]) {
        
        NSString *message = response[@"releaseNote"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发现新版本"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil,
                                  nil];
        alertView.tag = 2016;
        [alertView show];
        pgyUrl = response[@"downloadURL"];
        // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:response[@"downloadURL"]]];
    }
    //    调用checkUpdateWithDelegete后可用此方法来更新本地的版本号，如果有更新的话，在调用了此方法后再次调用将不提示更新信息。
    [[PgyUpdateManager sharedPgyManager] updateLocalBuildNumber];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2016) {
        if (buttonIndex == 0) {
            //点击 好的
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:pgyUrl]];
            
        }
        
    }
    
}

// 登录界面
- (void)loginController{
    
    LoginViewController *loginVC =[[LoginViewController alloc] init];
    UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:loginVC];
    
    loginVC.appDelegate = self;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 保存最后的登录时间
    [PublicKit setPlistParameter:[self getCurrentDate] setKey:RSLastLoginTime];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // 保存最后的登录时间
    [PublicKit setPlistParameter:[self getCurrentDate] setKey:RSLastLoginTime];
}

// 获取当前日期
- (NSString *)getCurrentDate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    return date;
}

@end
