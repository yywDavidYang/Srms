//
//  MyOrderCell.m
//  Srms
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSMyOrderCell.h"

@implementation RSMyOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void) creatUI{
    UILabel *bottomLineLabel = [[UILabel alloc]init];
    bottomLineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:bottomLineLabel];
    [bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void) setCellDataWithArray:(NSArray *)titleArray withCeateDate:(NSString *)dateHour{
    
    for (UIView *view in self.contentView.subviews) {
        
        [view removeFromSuperview];
    }
    [self creatUI];
    float labelWidth = 110;
    UILabel *lastTtitleLabel ;
    UILabel *lastLineLabel ;
    for (NSInteger i = 0; i < 10; i ++) {
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleLabel];
        if (i == 0) {
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.top.bottom.equalTo(self.contentView);
                make.width.mas_equalTo(200);
            }];
        }else if (i == 7){
            titleLabel.backgroundColor = [UIColor clearColor];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.top.equalTo(self.contentView).offset(5);
                make.bottom.equalTo(self.contentView.mas_centerY).offset(0);
                make.left.equalTo(lastLineLabel.mas_right).offset(0);
                make.width.mas_equalTo(labelWidth);
            }];
            
            UILabel *dateLabel = [[UILabel alloc]init];
            dateLabel.textColor = [UIColor grayColor];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            dateLabel.backgroundColor = [UIColor clearColor];
            dateLabel.text = dateHour;//titleArray[i];
            dateLabel.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:dateLabel];
            
            [dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.bottom.equalTo(self.contentView).offset(-5);
                make.top.equalTo(self.contentView.mas_centerY).offset(0);
                make.left.equalTo(lastLineLabel.mas_right).offset(0);
                make.width.mas_equalTo(labelWidth);
            }];
        }
        else{
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.top.bottom.equalTo(self.contentView);
                make.left.equalTo(lastLineLabel.mas_right).offset(0);
                make.width.mas_equalTo(labelWidth);
            }];
        }
        NSString *titleString ;
        if ([titleArray[i] isEqual:[NSNull null]]) {
            
            titleString = [NSString stringWithFormat:@"%@",@""];
        }else{
            
            titleString = [NSString stringWithFormat:@"%@",titleArray[i]];
        }
        if (i == 8) {
            
             titleLabel.textColor = [UIColor greenColor];

            if ([titleString isEqualToString:@"1"]) {
                
                titleLabel.text = @"审批完成";
            }else{
                
                titleLabel.text = @"未审批";
            }
        }else if (i == 9){
            
            if ([titleString isEqualToString:@"1"]) {
                
                titleLabel.text = @"已操作";
            }else{
                
                titleLabel.text = @"未操作";
            }
        }else if (i == 2){
            NSString *numberString =  [NSString stringWithFormat:@"%@.00",[NSString countNumAndChangeformat:titleString]];
            titleLabel.text = numberString;
        }
        else{
            if ([titleString isEqualToString:@""]||[titleString isEqualToString:@" "]) {
                
                titleLabel.text = @"0";
            }else{
                
                 titleLabel.text = [NSString countNumAndChangeformat:titleString];;
            }
             NSLog(@".....%@",titleString);
        }
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [self.contentView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(titleLabel.mas_right).offset(0);
            make.width.mas_equalTo(1);
        }];
        
        lastLineLabel   = lineLabel;
        lastTtitleLabel = titleLabel;
    }
    
    UILabel *rightLineLabel = [[UILabel alloc]init];
    rightLineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:rightLineLabel];
    [rightLineLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.width.mas_equalTo(1);
    }];
    
    UILabel *leftLineLabel = [[UILabel alloc]init];
    leftLineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:leftLineLabel];
    [leftLineLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.width.mas_equalTo(1);
    }];
}

- (void)click:(UIButton *)sender{

    if ([_delegate respondsToSelector:@selector(btnClick:)]) {
        sender.tag = self.tag;
        [_delegate btnClick:sender];
    }
}

//给控件赋值
- (void)setModel:(OrderModel *)model{

    _model = model;
    self.orderLab.text = model.orderNum;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
