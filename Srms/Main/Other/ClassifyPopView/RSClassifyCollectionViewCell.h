//
//  CollectionViewCell.h
//  Srms
//
//  Created by YYW on 16/7/27.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSClassifyCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *cellTitle;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSString *selectedTag;

@property (nonatomic, copy) void(^buttonSelectBlock)(UIButton *btn,NSIndexPath *indexPath);

@end
