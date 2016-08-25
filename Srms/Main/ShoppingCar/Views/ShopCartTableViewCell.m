//
//  ShopCartTableViewCell.m
//  Srms
//
//  Created by ohm on 16/7/11.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "ShopCartTableViewCell.h"

@interface ShopCartTableViewCell(){
    
    
    UIView *goodsInfoView;
}
@end

@implementation ShopCartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void) loadOrderInfoWithDic:(NSDictionary *)dic{
    
    [self loadGoodsInfoViewWithDic:dic];
    [self loadGoodsAllInfoWitArray:@[[dic objectForKey:@"disPrice"],[dic objectForKey:@"totalQty"],[dic objectForKey:@"disRate"],[dic objectForKey:@"totalAmount"]]];
}

- (void)loadGoodsInfoViewWithDic:(NSDictionary *)dic{
    
    goodsInfoView = [[UIView alloc]init];
    goodsInfoView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:goodsInfoView];
    [goodsInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(330);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.selected = YES;
    [btn setBackgroundImage:[UIImage imageNamed:@"circular2"] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"circular1"] forState:UIControlStateNormal];
    [goodsInfoView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(40);
    }];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor yellowColor];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"mainPictureUrl"]]] placeholderImage:[UIImage imageNamed:@"err"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [goodsInfoView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(btn.mas_right).offset(0);
        make.centerY.equalTo(goodsInfoView.mas_centerY).offset(0);
        make.width.height.mas_equalTo(90);
    }];
    
    UILabel *goodsIdLabel = [[UILabel alloc]init];
    goodsIdLabel.textAlignment = NSTextAlignmentLeft;
    goodsIdLabel.text = [NSString stringWithFormat:@"货单号:%@",[dic objectForKey:@"goodsNo"]];
    goodsIdLabel.font = [UIFont systemFontOfSize:17];
    [goodsInfoView addSubview:goodsIdLabel];
    [goodsIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(goodsInfoView.mas_centerY);
        make.left.equalTo(imageView.mas_right).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *goodsNameLabel = [[UILabel alloc]init];
    goodsNameLabel.textAlignment = NSTextAlignmentLeft;
    goodsNameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"goodsName"]];
    goodsNameLabel.font = [UIFont systemFontOfSize:18];
    [goodsInfoView addSubview:goodsNameLabel];
    [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(goodsIdLabel.mas_top).offset(0);
        make.left.equalTo(imageView.mas_right).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *goodsPriceLabel = [[UILabel alloc]init];
    goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
    goodsPriceLabel.text = [NSString stringWithFormat:@"单价:%@",[dic objectForKey:@"disPrice"]];
    goodsPriceLabel.font = [UIFont systemFontOfSize:17];
    [goodsInfoView addSubview:goodsPriceLabel];
    [goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(goodsIdLabel.mas_bottom).offset(0);
        make.left.equalTo(imageView.mas_right).offset(10);
        make.height.mas_equalTo(30);
    }];
    
}

- (void) loadGoodsAllInfoWitArray:(NSArray *)infoArray{
    
    CGFloat width = (DeviceWidth - 65 - 5 - 40 - 40 - 250)/5;
    UILabel *lastLabel = nil;
    for (NSInteger i = 0; i < 5; i ++) {
        
        UILabel * titleLabel =[[UILabel alloc] init];//WithFrame:CGRectMake(180, 20,80, 20)];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:17.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        if (i < 4) {
            NSString *string = [NSString stringWithFormat:@"%@",infoArray[i]];
            if (i == 0 || i == 3) {
                
                titleLabel.text = [NSString stringWithFormat:@"%0.2f",[string floatValue]];
            }else if (i == 2){
                
                titleLabel.text = [NSString stringWithFormat:@"%@",string];
            }else{
                
                titleLabel.text = string;
            }
            
        }else{
            
            titleLabel.text = @"";
        }
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(lastLabel?lastLabel.mas_right:goodsInfoView.mas_right).offset(0);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(20);
        }];
        
        lastLabel = titleLabel;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
