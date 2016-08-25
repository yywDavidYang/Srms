//
//  RSSumReportBarChartView.m
//  Srms
//
//  Created by RegentSoft on 16/7/19.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSSumReportBarChartView.h"
#import "RSSumReportFormView.h"
#import "RSSumReportHistogramView.h"
#import "RSSumReportPieChartView.h"

@interface RSSumReportBarChartView()
// 顶部的分界线
@property (nonatomic, strong) UIView *topLineView;
// 低部的分界线
@property (nonatomic, strong) UIView *bottonLineView;
// 表格
@property (nonatomic, strong) RSSumReportFormView *formView;
// 柱形图
@property (nonatomic, strong) RSSumReportHistogramView *histogramView;

@end

@implementation RSSumReportBarChartView

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self createUI];
        [self setAutolayout];
    }
    return self;
}

- (void) createUI{
    
    _topLineView = [[UIView alloc]init];
    _topLineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self addSubview:_topLineView];
    
    _bottonLineView = [[UIView alloc]init];
    _bottonLineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self addSubview:_bottonLineView];
    
    _formView = [[RSSumReportFormView alloc]init];//WithFrame:CGRectMake(70, 10, 400, self.frame.size.height - 20)];
    _formView.layer.cornerRadius = 3.0;
    _formView.layer.masksToBounds = YES;
    [self addSubview:_formView];
    
    _histogramView = [[RSSumReportHistogramView alloc]init];
    _histogramView.layer.cornerRadius = 3.0f;
    _histogramView.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    _histogramView.layer.borderWidth = 1.0f;
    _histogramView.layer.masksToBounds = YES;
    _histogramView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_histogramView];
    
}

- (void) setAutolayout{
    
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(0.4);
    }];
    
    [_bottonLineView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.4);
    }];
    
    [_formView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-10);
        make.width.mas_equalTo(400);
    }];
    
    [_histogramView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.equalTo(self).offset(10);
        make.left.equalTo(_formView.mas_right).offset(10);
        make.right.equalTo(self).offset(-10);;
        make.bottom.equalTo(self).offset(-10);
    }];
}

- (void) loadFormsDataArray:(NSArray *)array{
    
    [_formView createSumaryFormUIWithDataArray:array];
}

- (void)loadHistogramViewDataWithArray:(NSArray *)dataArray{
    
    [_histogramView setHistogramDataWithModelArray:dataArray];
}

@end
