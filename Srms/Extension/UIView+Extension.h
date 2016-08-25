//
//  UIView+Extension.h
//  srms
//
//  Created by Vincent_Guo on 16-6-16.
//  Copyright (c) 2016年 Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/**
 *  UIView的尺寸
 */
@property(nonatomic,assign)CGSize size;

/**
 *  获取或者更改控件的宽度
 */
@property(nonatomic,assign)CGFloat w;

/**
 *  获取或者更改控件的高度
 */
@property(nonatomic,assign)CGFloat h;

/**
 *  获取或者更改控件的x坐标
 */
@property(nonatomic,assign)CGFloat x;

/**
 *  获取或者更改控件的y坐标
 */
@property(nonatomic,assign)CGFloat y;
@end
