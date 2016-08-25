//
//  RSPercentReportGridViewCell.h
//  Srms
//
//  Created by RegentSoft on 16/7/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPercentReportChildsModel.h"

@interface RSPercentReportGridViewCell : UITableViewCell

// 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void) loadTableViewCellDataWithModel:(RSPercentReportChildsModel *)model lastCell:(BOOL)isLastCell;

@end
