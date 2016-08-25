//
//  ShopContainerTableViewCell.h
//  Srms
//
//  Created by ohm on 16/7/20.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopContainerTableViewCell : UITableViewCell



@property(nonatomic, retain)UIImageView* shopImage; //商品图片
@property(nonatomic, retain)UILabel* titleLabel;//shop 名称
@property(nonatomic, retain)UILabel* shopNameLabel;//shop 货号
@property(nonatomic, retain)UILabel* shopPriceLabel; // shop 价格
@property(nonatomic, retain)UILabel * priceLabel;    //折扣价
@property(nonatomic, retain)UILabel * numberLabel;   // 数量
@property(nonatomic, retain)UILabel * dpPriceLabel;  //折扣率
@property(nonatomic, retain)UILabel * allPriceLabel;  //总金额
@property(nonatomic, retain)UIButton *delegetButton;
@property(nonatomic, retain)UIButton* shopSelectBtn;
@end
