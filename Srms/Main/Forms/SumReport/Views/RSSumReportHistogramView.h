//
//  RSSumReportHistogramView.h
//  Srms
//
//  Created by RegentSoft on 16/7/20.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSumReportHistogramView : UIView
// 回传货号进行订单详情条转
@property(nonatomic,strong) void(^pushToOrderDetailBlock)(NSString *goodNo);
// 没有选中柱状图
@property(nonatomic,strong) void(^selectNothingBlock)();
//为柱形图设置数据
- (void)setHistogramDataWithModelArray:(NSArray *)dataArray;


@end
