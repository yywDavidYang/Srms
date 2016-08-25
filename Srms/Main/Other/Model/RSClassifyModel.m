//
//  RSClassifyModel.m
//  Srms
//
//  Created by RegentSoft on 16/7/28.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSClassifyModel.h"

@implementation RSClassifyModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}

@end
