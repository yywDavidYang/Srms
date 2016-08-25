//
//  RSMyOrderModel.h
//  Srms
//
//  Created by RegentSoft on 16/8/4.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSMyOrderModel : NSObject

@property (nonatomic, copy) NSNumber *sortingQuantity;
@property (nonatomic, copy) NSNumber *totalAmount;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSNumber *totalQty;
@property (nonatomic, copy) NSString *details;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *channelCode;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSNumber *deliveryQuantity;
@property (nonatomic, copy) NSNumber *procesStatus;
@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, copy) NSString *createBy;

@end
