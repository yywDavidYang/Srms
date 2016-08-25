//
//  NSString+RSString.h
//  Srms
//
//  Created by RegentSoft on 16/8/8.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RSString)
/**
 *  计算字符串的长宽
 *
 *  @param font 字体
 *  @param size 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 *
 *  @return <#return value description#>
 */
- (CGSize) sizeWithFont:(UIFont *)font maxiSize:(CGSize)size;
/**
 *  金额数据格式
 *
 *  @param numberString 需要修改格式的字符
 *
 *  @return <#return value description#>
 */
+(NSString *)countNumAndChangeformat:(NSString *)numberString;

@end
