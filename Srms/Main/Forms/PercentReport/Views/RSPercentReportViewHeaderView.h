//
//  RSPercentReportViewHeaderView.h
//  Srms
//
//  Created by YYW on 16/7/23.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPercentReportListModel.h"


typedef void(^PercentReportViewHeaderViewBlock)(BOOL isOpen);

@interface RSPercentReportViewHeaderView : UITableViewHeaderFooterView

// 是否展开
@property(nonatomic,assign) BOOL isOpen;
@property(nonatomic,strong) PercentReportViewHeaderViewBlock isOpenSectionBlock;

// 组头
+ (instancetype) headerViewWithTableView:(UITableView *)tableView;
// 加载每组头的数据
- (void)loadHeaderViewLabelWithTitle:(NSArray *)listArray model:(RSPercentReportListModel *)listModel;

@end
