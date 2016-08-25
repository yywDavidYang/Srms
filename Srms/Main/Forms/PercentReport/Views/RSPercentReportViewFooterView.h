//
//  RSPercentReportViewFooterView.h
//  Srms
//
//  Created by RegentSoft on 16/7/25.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPercentReportSumModel.h"

@interface RSPercentReportViewFooterView : UIView
/**
 *  加载底部的数据
 *
 *  @param sumModel <#sumModel description#>
 */
- (void)loadFooterViewDataWithModel:(RSPercentReportSumModel *)sumModel;

@end
