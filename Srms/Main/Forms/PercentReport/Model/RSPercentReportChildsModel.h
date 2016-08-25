//
//  RSPercentReportChildsModel.h
//  Srms
//
//  Created by RegentSoft on 16/7/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSPercentReportChildsModel : NSObject

@property (nonatomic, copy) NSString *accounting;
@property (nonatomic, strong) NSNumber *discount;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, strong) NSNumber *logoAmount;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSNumber *receiptNumber;
@property (nonatomic, strong) NSNumber *settlementAmount;

@end
