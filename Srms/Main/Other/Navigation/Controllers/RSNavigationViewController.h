//
//  RSNavigationViewController.h
//  Srms
//
//  Created by RegentSoft on 16/7/15.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

typedef void(^ShoppingCarButtonBlock)(UIButton *shoppingCarButton);

@interface RSNavigationViewController : UINavigationController
// 自定义的导航栏
@property (nonatomic,strong) UINavigationBar *bar;
// 导航栏的标题
@property (nonatomic, copy) NSString *titleText;
// 导航栏购物车按钮回调
@property (nonatomic, copy) ShoppingCarButtonBlock naviShoppingCarBtnBlock;
// 显示和隐藏返回按钮
@property (nonatomic, assign) BOOL isHideReturnBtn;

//隐藏自定义的导航栏
- (void)setDIYNavigationBarHidden:(BOOL)isHidden;
// 隐藏分类按钮
- (void) setNavigationScreenButtonHidden:(BOOL)isHidden;
// 购物车按钮不可点击
- (void) setShoppingCarButtonInteraction:(BOOL) isCanClick;
// 搭配池是否可以点击
- (void) setMatchPoolButtonInteraction:(BOOL) isCanClick;

@end
