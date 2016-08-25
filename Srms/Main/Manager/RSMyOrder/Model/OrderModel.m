//
//  OrderModel.m
//  Srms
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel


- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)orderWithDic:(NSDictionary *)dic{

    return [[self alloc]initWithDictionary:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    //写了之后可以防止字典中的key没有定义属性.
}



@end
