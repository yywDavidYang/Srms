//
//  NSString+RSString.m
//  Srms
//
//  Created by RegentSoft on 16/8/8.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "NSString+RSString.h"

@implementation NSString (RSString)

- (CGSize) sizeWithFont:(UIFont *)font maxiSize:(CGSize)size{
    
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
