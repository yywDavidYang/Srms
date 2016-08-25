//
//  RSPercentReportView.m
//  Srms
//
//  Created by RegentSoft on 16/7/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSPercentReportTopView.h"



@interface RSPercentReportTopView()

// 开始日期
@property(nonatomic, strong) UILabel *seperateLabel;
// 结束日期
@property(nonatomic, strong) UILabel *middleLabel;
// 选择开始日期
@property(nonatomic, strong) UIButton *startDateBtn;
// 选择结束日期
@property(nonatomic, strong) UIButton *endDateBtn;
// 查询按钮
@property(nonatomic, strong) UIButton *queryBtn;
// 颜色
@property(nonatomic, strong) UIButton *colorBtn;
// 尺寸
@property(nonatomic, strong) UIButton *sizeBtn;

@end

@implementation RSPercentReportTopView


- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
        [self setAutolayout];
    }
    return self;
}
- (void) createUI{
    // 选择开始日期
    _startDateBtn = [[UIButton alloc]init];
    _startDateBtn.tag = kStartDateButtonTag;
    _startDateBtn.layer.cornerRadius = 4.0;
    _startDateBtn.layer.masksToBounds = YES;
    _startDateBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_startDateBtn setBackgroundImage:[UIImage imageNamed:@"btn8_01"] forState:0];
    [_startDateBtn setTitle:[self getLastMonthDateWithMonth:-1] forState:0];
    _startDateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [_startDateBtn setTitleColor:[UIColor grayColor] forState:0];
    [_startDateBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_startDateBtn];
    
    _middleLabel = [[UILabel alloc]init];
    _middleLabel.font = [UIFont systemFontOfSize:20 weight:3];
    _middleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _middleLabel.text = @"至";
    _middleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_middleLabel];

    // 选择结束日期
    _endDateBtn = [[UIButton alloc]init];
    _endDateBtn.tag = kEndDateButtonTag;
    _endDateBtn.layer.cornerRadius = 4.0;
    _endDateBtn.layer.masksToBounds = YES;
    _endDateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _endDateBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_endDateBtn setBackgroundImage:[UIImage imageNamed:@"btn8_01"] forState:0];
    [_endDateBtn setTitle:[self getCurrentDate] forState:0];
    [_endDateBtn setTitleColor:[UIColor grayColor] forState:0];
    [_endDateBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_endDateBtn];
    
    // 中间分隔线
    _seperateLabel = [[UILabel alloc]init];
    _seperateLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self addSubview:_seperateLabel];
    
    // 颜色选择按钮
    _colorBtn = [[UIButton alloc]init];
    _colorBtn.selected = YES;
    _colorBtn.backgroundColor = [UIColor redColor];
    _colorBtn.tag = kColorButtonTag;
    _colorBtn.layer.cornerRadius = 4.0;
    _colorBtn.layer.masksToBounds = YES;
    [_colorBtn setBackgroundImage:[UIImage imageNamed:@"Color7_2"] forState:0];
    [_colorBtn setBackgroundImage:[UIImage imageNamed:@"Color7"] forState:UIControlStateSelected];
    [_colorBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_colorBtn];
    
    // 尺寸选择按钮
    _sizeBtn = [[UIButton alloc]init];
    _sizeBtn.backgroundColor = [UIColor redColor];
    _sizeBtn.selected = NO;
    _sizeBtn.hidden = YES;
    _sizeBtn.tag = kSizeButtonTag;
    _sizeBtn.layer.cornerRadius = 4.0;
    _sizeBtn.layer.masksToBounds = YES;
    [_sizeBtn setBackgroundImage:[UIImage imageNamed:@"size8_2"] forState:0];
    [_sizeBtn setBackgroundImage:[UIImage imageNamed:@"size8"] forState:UIControlStateSelected];
    [_sizeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sizeBtn];
    
    // 查询按钮
    _queryBtn = [[UIButton alloc]init];
    _queryBtn.tag = kQueryButtonTag;
    [_queryBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_queryBtn setImage:[UIImage imageNamed:@"报表btn1_2"] forState:0];
    
    [self addSubview:_queryBtn];
    
    
    UIView *topLineView = [[UIView alloc]init];
    topLineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(0.8);
    }];
    
}

- (void) setAutolayout{
    
    
    [_startDateBtn mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(self.mas_left).offset(5);
        make.centerY.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(130);
    }];
    
    [_middleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(_startDateBtn.mas_right).offset(1);
        make.centerY.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(30);
        
    }];
    
    [_endDateBtn mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(_middleLabel.mas_right).offset(1);
        make.centerY.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(130);
    }];
    
    
    [_seperateLabel mas_makeConstraints: ^(MASConstraintMaker *make){
    
        make.right.equalTo(_colorBtn.mas_left).offset(-20);
        make.centerY.equalTo(self);
        make.top.equalTo(self.mas_top).offset(15);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.width.mas_equalTo(1);
    }];
    
    [_colorBtn mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.equalTo(self.mas_centerX).offset(-30);
        make.centerY.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(60);
    }];
    
    [_sizeBtn mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(_colorBtn.mas_right).offset(20);
        make.centerY.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(60);
    }];
    
    
    [_queryBtn mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(65);
    }];
}

- (void)buttonClick:(UIButton *)btn{
    
    if (btn.selected) {
        
        btn.selected = NO;
    }else{
        
        btn.selected = YES;
    }
    
    self.percentReportBtn(btn);
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
