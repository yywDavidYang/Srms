//
//  RSSumReportModel.h
//  Srms
//
//  Created by RegentSoft on 16/7/19.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSOrderBarGraphModel : NSObject
// 时间
@property (nonatomic,strong) NSString *datetime;
// 订单的id
@property (nonatomic,strong) NSString *orderID;
// 订单的数量
@property (nonatomic,strong) NSString *settlementAmount;


@end
