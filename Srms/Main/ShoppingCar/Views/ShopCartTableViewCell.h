//
//  ShopCartTableViewCell.h
//  Srms
//
//  Created by ohm on 16/7/11.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
//搭配款，替代款
@interface ShopCartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *disCount;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNoLabel;

- (void) loadOrderInfoWithDic:(NSDictionary *)dic;

@end
