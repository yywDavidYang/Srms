//
//  OrderModel.h
//  Srms
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, OrderStateType)
{
    OrderStateType_OK = 0, // 通过
    OrderStateType_FAILED = 1, // 未通过
    OrderStateType_WAIT = 2,//待审核
};

@interface OrderModel : NSObject
@property (nonatomic, copy) NSString *orderNum;//订单号
@property (nonatomic, assign) int countNum;//数量
@property (nonatomic, copy) NSString *date;//日期
@property (nonatomic, assign) OrderStateType type;//订单状态
@property  BOOL isOK;//是否确认收货

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)orderWithDic:(NSDictionary *)dic;
@end
