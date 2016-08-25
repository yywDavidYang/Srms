//
//  RSTabBarTableViewCell.h
//  Srms
//
//  Created by YYW on 16/7/16.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RSButtonReturnBlock)(UIButton *button);

@interface RSTabBarTableViewCell : UITableViewCell

@property (nonatomic, copy) RSButtonReturnBlock buttonReturnBlock;
- (void) loadImageWithImage:(UIImage *)image selectImage:(UIImage *)selectImage tag:(NSInteger)buttonTag;
+(instancetype) cellWithTableView:(UITableView *)tableView;
@end
