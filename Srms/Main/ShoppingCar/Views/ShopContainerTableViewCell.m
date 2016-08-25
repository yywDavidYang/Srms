//
//  ShopContainerTableViewCell.m
//  Srms
//
//  Created by ohm on 16/7/20.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "ShopContainerTableViewCell.h"
#define Cellwidth [UIScreen mainScreen].bounds.size.width
#define Cellgeight [UIScreen mainScreen].bounds.size.height

@implementation ShopContainerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, Cellwidth, Cellgeight)];
        [self addSubview:view];
        
        UIImageView* image =[[UIImageView alloc] initWithFrame:CGRectMake(60, 50, self.frame.size.width-60, 60)];
        image.image = [UIImage imageNamed:@"brgoud3"];
        [self addSubview:image];
        
        _shopSelectBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, 40, 40, 40)];
        
        [self addSubview:_shopSelectBtn];
        
        
        _shopImage =[[UIImageView alloc] initWithFrame:CGRectMake(60, 10, 100, 100)];
        
        [self addSubview:_shopImage];
        
        _titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(170, 10, 160, 30)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];

        _shopNameLabel =[[UILabel alloc] initWithFrame:CGRectMake(170, 45, 160, 30)];
        _shopNameLabel.textColor = [UIColor blackColor];
        _shopNameLabel.font = [UIFont systemFontOfSize:14.0];
        _shopNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_shopNameLabel];
        
        _shopPriceLabel =[[UILabel alloc] initWithFrame:CGRectMake(170, 80, 160, 30)];
        _shopPriceLabel.textColor = [UIColor blackColor];
        _shopPriceLabel.font = [UIFont systemFontOfSize:14.0];
        _shopPriceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_shopPriceLabel];
        
        
        _priceLabel =[[UILabel alloc] initWithFrame:CGRectMake(Cellwidth-630, 40, 80, 20)];
        _priceLabel.text = @"价格";
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.font = [UIFont systemFontOfSize:14.0];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_priceLabel];
        
        _numberLabel =[[UILabel alloc] initWithFrame:CGRectMake(Cellwidth-550, 40, 100, 20)];
        _numberLabel.text = @"数量";
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.font = [UIFont systemFontOfSize:14.0];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numberLabel];
        
        
        _dpPriceLabel =[[UILabel alloc] initWithFrame:CGRectMake(Cellwidth-450, 40, 150, 20)];
        _dpPriceLabel.text = @"折扣";
        _dpPriceLabel.textColor = [UIColor blackColor];
        _dpPriceLabel.font = [UIFont systemFontOfSize:14.0];
        _dpPriceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dpPriceLabel];
        
        
        _allPriceLabel =[[UILabel alloc] initWithFrame:CGRectMake(Cellwidth-320, 40, 150, 20)];
        _allPriceLabel.text = @"金额";
        _allPriceLabel.textColor = [UIColor blackColor];
        _allPriceLabel.font = [UIFont systemFontOfSize:14.0];
        _allPriceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_allPriceLabel];
        
        _delegetButton =[[UIButton alloc] initWithFrame:CGRectMake(Cellwidth-160, 30, 40, 40)];
        [_delegetButton setBackgroundImage:[UIImage imageNamed:@"delegetbtn2.pnga"] forState:UIControlStateNormal];
        [self addSubview:_delegetButton];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
