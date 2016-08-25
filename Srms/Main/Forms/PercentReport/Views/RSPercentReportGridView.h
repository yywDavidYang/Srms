//
//  RSPercentReportGridView.h
//  Srms
//
//  Created by RegentSoft on 16/7/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSPercentReportViewFooterView.h"

@interface RSPercentReportGridView : UIView

/**
 *  每组的数据
 */
@property (nonatomic,strong) NSArray *lismodelArray;
/**
 *  加载表格底部数据
 */

- (void)loadFooterViewDataWithModel:(RSPercentReportSumModel *)model;
@end
