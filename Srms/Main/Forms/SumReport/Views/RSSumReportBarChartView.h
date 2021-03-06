//
//  RSSumReportBarChartView.h
//  Srms
//
//  Created by RegentSoft on 16/7/19.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSumReportBarChartView : UIView
// 回传货号进行订单详情条转
@property(nonatomic,strong) void(^pushToOrderDetailBlock)(NSString *goodNo);
// 加载表格数据
- (void) loadFormsDataArray:(NSArray *)array;
/**
 *  加载柱状图的数据
 *
 *  @param dataArray 装载模型的数组
 */
- (void)loadHistogramViewDataWithArray:(NSArray *)dataArray;

@end
