//
//  UIViewController+RSHubLoadView.h
//  Srms
//
//  Created by RegentSoft on 16/7/29.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (RSHubLoadView)

/**
 *  加载提示框
 *
 *  @param isShow Yes 展示，No 隐藏
 */
- (void)loadProgressViewIsShow:(BOOL)isShow;

/**
 *  加载提醒框
 *
 *  @param string    提醒的信息
 *  @param delayTime 提醒停留的时间
 */
-(void)showLoadProgressViewWithMessage:(NSString *)string delay:(float)delayTime;

@end
