//
//  RSCommentDetailsModel.m
//  Srms
//
//  Created by YYW on 16/8/4.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSCommentDetailsModel.h"

@implementation RSCommentDetailsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _id_flag = value;
    }
    else{
        [super setValue:value forKey:key];
    }
}


@end
