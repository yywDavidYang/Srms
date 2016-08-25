//
//  RSPercentReportGridHeaderView.m
//  Srms
//
//  Created by RegentSoft on 16/7/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSPercentReportGridHeaderView.h"

@implementation RSPercentReportGridHeaderView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = RGBA(246, 246, 246, 1.0f);
        [self createUI];
    }
    return self;
}
- (void) createUI{
    
    NSArray *titleArray = @[@"货号",@"品名",@"SKU数",@"补货数",@"吊牌额",@"结算额",@"折扣(%)",@"收货数",@"占比(%)"];
    UILabel *lastTitleLabel = nil;
    for (NSInteger i = 0; i < 9; i ++) {
        
        //计算字符串的大小
        CGSize size = [titleArray[i] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.0f]}];
        float width = size.width;
        
         UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:lineLabel];
        if (i == 3 || i ==4 || i == 7 ) {
    
           [lineLabel mas_makeConstraints:^(MASConstraintMaker *make){
            
                make.width.mas_equalTo(1);
                make.left.equalTo(lastTitleLabel.mas_right).offset(10);
                make.top.equalTo(self.mas_top).offset(20);
                make.bottom.equalTo(self.mas_bottom).offset(-20);
            }];
            
        }else if (i == 0){
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.width.mas_equalTo(1);
                make.left.equalTo(self.mas_left).offset(50);
                make.top.equalTo(self.mas_top).offset(20);
                make.bottom.equalTo(self.mas_bottom).offset(-20);
            }];
        
        }
        else{
            
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.width.mas_equalTo(1);
                make.left.equalTo(lastTitleLabel.mas_right).offset(30);
                make.top.equalTo(self.mas_top).offset(20);
                make.bottom.equalTo(self.mas_bottom).offset(-20);
            }];
        }

        UILabel *titleLable = [[UILabel alloc]init];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = [UIColor blackColor];
        titleLable.text = titleArray[i];
        titleLable.font = [UIFont systemFontOfSize:18];
        [self addSubview:titleLable];
        if (i == 2 || i == 3 || i == 6 ) {
            
           [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
            
               make.left.equalTo(lineLabel.mas_right).offset(10);
               make.top.equalTo(self.mas_top).offset(10);
               make.bottom.equalTo(self.mas_bottom).offset(-10);
            }];
        }
        else if(i == 8){
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lineLabel.mas_right).offset(10);
                make.top.equalTo(self.mas_top).offset(10);
                make.bottom.equalTo(self.mas_bottom).offset(-10);
            }];
            
        }
        else if(i == 0){
        
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lineLabel.mas_right).offset(30);
                make.top.equalTo(self.mas_top).offset(10);
                make.bottom.equalTo(self.mas_bottom).offset(-10);
                make.width.mas_equalTo(width + 40);
            }];
        }else{
            
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lineLabel.mas_right).offset(30);
                make.top.equalTo(self.mas_top).offset(10);
                make.bottom.equalTo(self.mas_bottom).offset(-10);
            }];
        }
        lastTitleLabel = titleLable;
    }
    
    // 地步分割线
    UILabel *bottomLineLabel = [[UILabel alloc]init];
    bottomLineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self addSubview:bottomLineLabel];
    [bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.height.mas_equalTo(1);
        make.left.bottom.right.equalTo(self);
    }];
}


@end
