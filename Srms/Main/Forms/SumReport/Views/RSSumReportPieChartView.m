//
//  RSSumReportPieChartView.m
//  Srms
//
//  Created by RegentSoft on 16/7/20.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSSumReportPieChartView.h"
#import "RSSumReportSinglePieChartView.h"

@interface RSSumReportPieChartView()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation RSSumReportPieChartView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
    
    }
    return self;
}

- (void) createUI{
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
}

- (void) autolayOut{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.edges.equalTo(self);
    }];
}

- (void)loadPieChartViewWithModelArray:(NSArray *)modelArray{
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    _scrollView = nil;
    [self createUI];
    [self autolayOut];
    
    UIView *contentView = [[UIView alloc]init];
    [_scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
    }];
    RSSumReportSinglePieChartView *lastSingleView = nil;
    for (NSInteger i = 0; i < modelArray.count; i ++) {
       
        RSSumReportSinglePieChartView *singlePieChartView = [[RSSumReportSinglePieChartView alloc]init];
        singlePieChartView.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        singlePieChartView.layer.borderWidth = 1.0f;
        [singlePieChartView setPieChartViewDataWithModelArray:modelArray[i]];
        
        [contentView addSubview:singlePieChartView];
        if (i % 2 == 0) {
                
            [singlePieChartView mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(contentView.mas_left).offset(30);
                make.width.height.mas_equalTo(300);
                make.top.equalTo(lastSingleView?lastSingleView.mas_bottom:contentView.mas_top).offset(10);
            }];
        }
        else{
        
            [singlePieChartView mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lastSingleView.mas_right).offset(200);
                make.width.height.mas_equalTo(300);
                make.top.equalTo(lastSingleView.mas_top).offset(0);
            }];
        }
        
        lastSingleView = singlePieChartView;
    }
    if (lastSingleView) {
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make){
    
           make.bottom.equalTo(lastSingleView.mas_bottom).offset(16);
        }];
    }
}

@end
