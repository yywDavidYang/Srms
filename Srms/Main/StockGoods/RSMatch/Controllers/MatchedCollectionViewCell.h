//
//  MatchedCollectionViewCell.h
//  Srms
//
//  Created by ohm on 16/8/12.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchedCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageShop;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
