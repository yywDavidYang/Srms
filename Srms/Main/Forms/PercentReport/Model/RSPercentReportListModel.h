//
//  RSPercentReportListModel.h
//  Srms
//
//  Created by RegentSoft on 16/7/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSPercentReportListModel : NSObject

@property (nonatomic,copy)   NSString *accounting;
@property (nonatomic,strong) NSMutableArray *childs;
@property (nonatomic,strong) NSNumber *discount;
@property (nonatomic,copy)   NSString *goodsName;
@property (nonatomic,strong) NSNumber *goodsNo;
@property (nonatomic,strong) NSNumber *logoAmount;
@property (nonatomic,strong) NSNumber *quantity;
@property (nonatomic,strong) NSNumber *receiptNumber;
@property (nonatomic,strong) NSNumber *settlementAmount;
@property (nonatomic,strong) NSNumber *sku;

@property (nonatomic,assign) BOOL isOpen;

@end
