//
//  RSSumReportPieChartView.h
//  Srms
//
//  Created by RegentSoft on 16/7/20.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSumReportPieChartView : UIView
/**
 *   加载不同病状图的数据
 *
 *  @param modelArray 元素为模型数组
 */
- (void)loadPieChartViewWithModelArray:(NSArray *)modelArray;

@end
