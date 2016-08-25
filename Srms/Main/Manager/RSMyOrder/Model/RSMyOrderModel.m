//
//  RSMyOrderModel.m
//  Srms
//
//  Created by RegentSoft on 16/8/4.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSMyOrderModel.h"

@implementation RSMyOrderModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}

@end
