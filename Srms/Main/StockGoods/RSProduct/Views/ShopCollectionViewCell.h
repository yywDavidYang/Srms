//
//  ShopCollectionViewCell.h
//  Srms
//
//  Created by ohm on 16/6/7.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;//起批的件数
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;//已批的件数

@end
