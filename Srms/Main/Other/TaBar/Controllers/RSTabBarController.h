//
//  RSTabBarController.h
//  iPadDemo
//
//  Created by YYW on 16/7/16.
//  Copyright © 2016年 YYW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface RSTabBarController : UIViewController

@property (nonatomic,strong) RSNavigationViewController *currentNaviVC;
@property (nonatomic,strong) AppDelegate *appDelegate;
@property (nonatomic,assign) BOOL isHiddenTabBar;


@end
