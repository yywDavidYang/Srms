//
//  RSSumReportSummarymodel.h
//  
//
//  Created by RegentSoft on 16/7/19.
//
//

#import <Foundation/Foundation.h>

@interface RSSumReportSummarymodel : NSObject

// 货物的数量
@property (nonatomic,strong) NSNumber *goodsAmount;
// 订单的数量
@property (nonatomic,strong) NSNumber *orderAmount;
//
@property (nonatomic,strong) NSNumber *settlementAmount;
//
@property (nonatomic,strong) NSNumber *tagPriceAmount;

@end
