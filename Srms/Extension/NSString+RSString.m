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

+(NSString *)countNumAndChangeformat:(NSString *)numberString
{
    int count = 0;
    long long int a = numberString.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:numberString];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

@end
