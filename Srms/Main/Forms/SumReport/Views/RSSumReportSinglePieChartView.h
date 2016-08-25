//
//  RSSumReportSinglePieChartView.h
//  Srms
//
//  Created by RegentSoft on 16/7/21.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    RSBrandModel,
    RSCategoryModel,
    RSPatternModel,
    RSRangeModel,
    RSSeasonModel,
    RSYearModel
}PieChartModel;

@interface RSSumReportSinglePieChartView : UIView
/**
 *  加载饼状图数据
 *
 *  @param modelArray 加载饼状图数据
 */
- (void)setPieChartViewDataWithModelArray:(NSArray *)modelArray;

@end
