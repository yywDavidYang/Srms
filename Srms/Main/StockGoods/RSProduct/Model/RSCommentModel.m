//
//  RSCommentModel.m
//  Srms
//
//  Created by YYW on 16/8/4.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSCommentModel.h"
#import "RSCommentDetailsModel.h"

@implementation RSCommentModel

- (instancetype)init{
    if (self = [super init]) {
        _details = [NSMutableArray array];
        _isOpen = NO;
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _id_con = value;
    }else if([key isEqualToString:@"details"]){
        
        for (NSDictionary *dic in value) {
            RSCommentDetailsModel *deailModel = [[RSCommentDetailsModel alloc] init];
            [deailModel setValuesForKeysWithDictionary:dic];
            [_details addObject:deailModel];
        }
    }else{
        
        [super setValue:value forKey:key];
    }
}


@end
