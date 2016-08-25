//
//  RSSumReportTopView.m
//  Srms
//
//  Created by RegentSoft on 16/7/18.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSSumReportTopView.h"

#define kStartDateBtnTag 20111;
#define kEndDateBtnTag 20112;
#define kQueryDateBtnTag 20119;


@interface RSSumReportTopView()
// 开始日期
@property(nonatomic, strong) UILabel *startDateLabel;
// 结束日期
@property(nonatomic, strong) UILabel *endDateLabel;
// 选择开始日期
@property(nonatomic, strong) UIButton *startDateBtn;
// 选择结束日期
@property(nonatomic, strong) UIButton *endDateBtn;
// 查询按钮
@property(nonatomic, strong) UIButton *queryBtn;

@end

@implementation RSSumReportTopView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
        [self setAutolayout];
    }
    return self;
}
- (void) createUI{
    
//    _startDateLabel = [[UILabel alloc]init];
//    _startDateLabel.textColor = [UIColor colorWithHexString:@"#333333"];
//    _startDateLabel.text = @"开始日期:";
//    _startDateLabel.font = [UIFont systemFontOfSize:20 weight:3];
//    _startDateLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_startDateLabel];
    
    _startDateBtn = [[UIButton alloc]init];
    _startDateBtn.tag = kStartDateBtnTag;
    _startDateBtn.layer.cornerRadius = 4.0;
    _startDateBtn.layer.masksToBounds = YES;
    _startDateBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_startDateBtn setBackgroundImage:[UIImage imageNamed:@"btn8_01"] forState:0];
    [_startDateBtn setTitle:[self getLastMonthDateWithMonth:-1] forState:0];
    _startDateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [_startDateBtn setTitleColor:[UIColor grayColor] forState:0];
    [_startDateBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_startDateBtn];
    
    _endDateLabel = [[UILabel alloc]init];
    _endDateLabel.font = [UIFont systemFontOfSize:20 weight:3];
    _endDateLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _endDateLabel.text = @"至";
    _endDateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_endDateLabel];
    
    _endDateBtn = [[UIButton alloc]init];
    _endDateBtn.tag = kEndDateBtnTag;
    _endDateBtn.layer.cornerRadius = 4.0;
    _endDateBtn.layer.masksToBounds = YES;
    _endDateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _endDateBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_endDateBtn setBackgroundImage:[UIImage imageNamed:@"btn8_01"] forState:0];
    [_endDateBtn setTitle:[self getCurrentDate] forState:0];
    [_endDateBtn setTitleColor:[UIColor grayColor] forState:0];
    [_endDateBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_endDateBtn];
    
    _queryBtn = [[UIButton alloc]init];
    _queryBtn.tag = kQueryDateBtnTag;
    [_queryBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_queryBtn setImage:[UIImage imageNamed:@"报表btn1_2"] forState:0];
    
    [self addSubview:_queryBtn];
    
}

- (void) setAutolayout{
    
    
    [_startDateBtn mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(self.mas_left).offset(5);
        make.centerY.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(130);
    }];
    
    [_endDateLabel mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.equalTo(_startDateBtn.mas_right).offset(1);
        make.centerY.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(30);
    
    }];
    
    [_endDateBtn mas_makeConstraints:^(MASConstraintMaker *make){
       
        make.left.equalTo(_endDateLabel.mas_right).offset(1);
        make.centerY.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(130);
    }];

    
    [_queryBtn mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(65);
    }];
//    NSArray *btnTitleArray = @[@"季节",@"年份",@"款型",@"类别",@"系列",@"品牌"];
    NSArray *btnImageArray = @[[UIImage imageNamed:@"Seasonbtn6_2"],[UIImage imageNamed:@"Yearbtn5_2"],[UIImage imageNamed:@"Patternbtn4_2"],[UIImage imageNamed:@"Categorybtn3_2"],[UIImage imageNamed:@"RangeBtn2_2"],[UIImage imageNamed:@"brandBtn1_1"]];
    
    NSArray *btnSelectImageArray = @[[UIImage imageNamed:@"Seasonbtn6"],[UIImage imageNamed:@"Yearbtn5"],[UIImage imageNamed:@"Patternbtn4"],[UIImage imageNamed:@"Categorybtn3"],[UIImage imageNamed:@"RangeBtn2"],[UIImage imageNamed:@"brandBtn1"]];
    UIButton *button = nil;
    for(NSInteger i = 0 ; i < 6;i ++){
        
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 20118 - i;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.selected = NO;
        if (i <= 4 && i >= 2) {
            
            btn.selected = YES;
        }
        [btn setBackgroundImage:btnSelectImageArray[i] forState:UIControlStateSelected];
        [btn setBackgroundImage:btnImageArray[i] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(_queryBtn.mas_left).offset(button?-80 * i - 50:-50);
            make.centerY.equalTo(self);
            make.top.equalTo(self.mas_top).offset(7.5);
            make.bottom.equalTo(self.mas_bottom).offset(-7.5);
            make.width.mas_equalTo(60);
        }];
        
        button = btn;
    }
}

- (void)buttonClick:(UIButton *)button{
    
    if (button.selected) {
            
        button.selected = NO;
    }else{
            
        button.selected = YES;
    }
    self.sumReportBtn(button);
}

// 获取当前日期
- (NSString *)getCurrentDate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    return date;
}

// 获取隔几个月的日期
- (NSString *)getLastMonthDateWithMonth:(NSInteger)month{
    // 获取当天时间
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:month];
    
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    return beforDate;
}

@end













