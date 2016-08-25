//
//  RSProductCommentCell.h
//  Srms
//
//  Created by YYW on 16/8/4.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSCommentModel.h"

@interface RSProductCommentCell : UITableViewCell
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,assign) BOOL isHide;
@property(nonatomic,strong) void(^commentCellBlock)(UIButton *btn, NSIndexPath *index);
- (void) loadViewCommentData:(RSCommentModel *)commentModel indexPath:(NSIndexPath *)index;

@end
