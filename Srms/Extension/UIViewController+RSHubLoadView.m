//
//  UIViewController+RSHubLoadView.m
//  Srms
//
//  Created by RegentSoft on 16/7/29.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "UIViewController+RSHubLoadView.h"


@implementation UIViewController (RSHubLoadView)

// 加载数据提示框
- (void)loadProgressViewIsShow:(BOOL)isShow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *progressHUB = nil;
    for (UIView *loadView in window.subviews) {
        
        if ([loadView isKindOfClass:[MBProgressHUD class]]) {
            
            progressHUB = (MBProgressHUD *)loadView;
        }
    }
    if (progressHUB == nil) {
        
        progressHUB = [[MBProgressHUD alloc]init];
//        progressHUB.mode = MBProgressHUDModeDeterminate;
        progressHUB.removeFromSuperViewOnHide = YES;
        progressHUB.center = window.center;
        [window addSubview:progressHUB];
        
//        [progressHUB mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.center.equalTo(self.view);
//        }];
    }
    
    if (isShow) {
        window.backgroundColor = [UIColor blackColor];
        window.alpha = 0.7;
        [progressHUB show:YES];
    }
    else{
        window.backgroundColor = [UIColor clearColor];
        window.alpha = 1;
        [progressHUB hide:YES];
    }
    
}

#pragma mark --- 提示框(MBProgressHUD) ---
-(void)showLoadProgressViewWithMessage:(NSString *)string delay:(float)delayTime
{
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[MBProgressHUD class]]) {
            
            [view removeFromSuperview];
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.center = self.view.center;
    hud.yOffset = 100.0f;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = string;
    hud.margin = 20.f;
    hud.labelFont = [UIFont systemFontOfSize:12];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delayTime];
}

@end
