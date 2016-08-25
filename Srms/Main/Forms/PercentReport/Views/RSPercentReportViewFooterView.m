//
//  RSPercentReportViewFooterView.m
//  Srms
//
//  Created by RegentSoft on 16/7/25.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSPercentReportViewFooterView.h"

@interface RSPercentReportViewFooterView()

@property (nonatomic,strong) UILabel *topLabel;

@end
@implementation RSPercentReportViewFooterView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];

    }
    return self;
}

- (void)createUI{
    
    _topLabel = [[UILabel alloc]init];
    _topLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self addSubview:_topLabel];
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(0.6);
    }];
    
}
- (void)loadFooterViewDataWithModel:(RSPercentReportSumModel *)sumModel{
    
    NSArray *dataArray = @[ [NSString stringWithFormat:@"%@",@""],
                            [NSString stringWithFormat:@"%@",@""],
                            [NSString stringWithFormat:@"%@",sumModel.sumsku],
                            [NSString stringWithFormat:@"%@",sumModel.sumquantity],
                            [NSString stringWithFormat:@"%.1f",[sumModel.sumlogoAmount floatValue]],
                            [NSString stringWithFormat:@"%.1f",[sumModel.sumsettlementAmount floatValue]],
                            [NSString stringWithFormat:@"%@",@""],
                            [NSString stringWithFormat:@"%@",sumModel.sumreceiptNumber],
                            [NSString stringWithFormat:@"%@",@"100%"]];
    
    NSArray *titleArray = @[@"货号",@"品名",@"SKU数",@"补货数",@"吊牌额",@"结算额",@"折扣(%)",@"收货数",@"占比(%)"];
    UILabel *footerViewTitleLabel = [[UILabel alloc]init];
    footerViewTitleLabel.textColor = [UIColor blackColor];
    footerViewTitleLabel.text = @"合计 :";
    footerViewTitleLabel.font = [UIFont systemFontOfSize:15];
    footerViewTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:footerViewTitleLabel];
    [footerViewTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.mas_equalTo(50);
    }];
    
    UILabel *lastTitleLabel = nil;
    for (NSInteger i = 0; i < 9; i ++) {
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [self addSubview:lineLabel];
        
        if (lastTitleLabel) {
            
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.width.mas_equalTo(0.6);
                make.left.equalTo(lastTitleLabel.mas_right).offset(0);
                make.top.bottom.equalTo(self).offset(0);
            }];
            
        }else{
            
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.width.mas_equalTo(0.6);
                make.left.equalTo(self.mas_left).offset(60);
                make.top.bottom.equalTo(self).offset(0);
            }];
        }
        
        //计算字符串的大小
        CGSize size = [titleArray[i] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.0f]}];
        float width = size.width;
        UILabel *titleLable = [[UILabel alloc]init];
        titleLable.backgroundColor = [UIColor whiteColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = [UIColor blackColor];

        titleLable.text = dataArray[i];
        titleLable.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLable];
        if (i == 2 || i == 3 || i == 6 ) {
            
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lineLabel.mas_right).offset(1);
                make.top.equalTo(self).offset(10);
                make.bottom.equalTo(self).offset(-10);
                make.width.mas_equalTo(width + 20);
            }];
        }
        else if(i == 8){
            
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lineLabel.mas_right).offset(1);
                make.top.equalTo(self).offset(10);
                make.bottom.equalTo(self).offset(-10);
//                make.right.equalTo(self).offset(0);
                make.width.mas_equalTo(width + 20);
            }];
            
        }else if(i == 0){
            
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lineLabel.mas_right).offset(1);
                make.top.equalTo(self).offset(10);
                make.bottom.equalTo(self).offset(-10);
                make.width.mas_equalTo(width + 80);
            }];
            
        }else if(i == 1 || i == 4 || i == 5 || i == 7 ){
            
            
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lineLabel.mas_right).offset(1);
                make.top.equalTo(self).offset(10);
                make.bottom.equalTo(self).offset(-10);
                make.width.mas_equalTo(width + 60);
            }];
        }
        
        lastTitleLabel = titleLable;
    }
}

@end
