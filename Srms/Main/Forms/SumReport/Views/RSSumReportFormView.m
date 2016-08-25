//
//  RSSumReportFormView.m
//  Srms
//
//  Created by RegentSoft on 16/7/20.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSSumReportFormView.h"

@interface RSSumReportFormView()

//@property (nonatomic,strong) UILabel *
//@property (nonatomic,strong) UILabel *
//@property (nonatomic,strong) UILabel *
//@property (nonatomic,strong) UILabel *
//@property (nonatomic,strong) UILabel *
//@property (nonatomic,strong) UILabel *

@end

@implementation RSSumReportFormView
- (instancetype) init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createSumaryFormUIWithDataArray:(NSArray *)dataArray{
    
    for(UIView *view in self.subviews){
        
        [view removeFromSuperview];
    }
    NSArray *titleArray = @[@"单数",@"件数",@"吊牌总额",@"结算额",@"平均折扣(%)"];
    UILabel *leftLine = [[UILabel alloc]init];
    leftLine.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.bottom.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(1);
    }];
    
    UILabel *medleLine = [[UILabel alloc]init];
    medleLine.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self addSubview:medleLine];
    [medleLine mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.bottom.equalTo(self).offset(0);
        make.left.equalTo(self).offset(150);
        make.width.mas_equalTo(1);
    }];
    
    UILabel *rightLine = [[UILabel alloc]init];
    rightLine.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.bottom.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.width.mas_equalTo(1);
    }];
    
    for (NSInteger i = 0; i < 5; i ++) {
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make){
        
            make.top.equalTo(self).offset(i * 50);
            make.right.left.equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *bottomline = [[UILabel alloc]init];
        bottomline.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [self addSubview:bottomline];
        [bottomline mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.bottom.equalTo(self);
            make.right.left.equalTo(self);
            make.height.mas_equalTo(1);
        }];
        if (i < 5) {
            
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.font = [UIFont systemFontOfSize:15];
            titleLabel.backgroundColor = RGBA(246, 246, 246, 1);
            titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = titleArray[i];
            [self addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.equalTo(line.mas_bottom).offset(0);
                make.left.equalTo(leftLine.mas_right).offset(0);
                make.height.mas_equalTo(48);
                make.right.equalTo(medleLine.mas_left).offset(0);
            }];
            
            UILabel *numberLabel = [[UILabel alloc]init];
            numberLabel.font = [UIFont systemFontOfSize:15];
            numberLabel.textColor = [UIColor colorWithHexString:@"#4baf4f"];
            numberLabel.textAlignment = NSTextAlignmentCenter;
            numberLabel.text = dataArray[i];
            [self addSubview:numberLabel];
            [numberLabel mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.equalTo(line.mas_bottom).offset(0);
                make.left.equalTo(medleLine.mas_right).offset(0);
                make.height.mas_equalTo(48);
                make.right.equalTo(rightLine.mas_left).offset(0);
            }];
        }
    }
}

@end
