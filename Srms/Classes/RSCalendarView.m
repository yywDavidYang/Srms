//
//  RSCalendarView.m
//  CalendarDemo
//
//  Created by RegentSoft on 16/7/27.
//  Copyright © 2016年 RegentSoft. All rights reserved.
//

#import "RSCalendarView.h"
#import "Masonry.h"
#import "WHUCalendarView.h"

@interface RSCalendarView()

@property (nonatomic,strong) WHUCalendarView *frontView;
@property (nonatomic,strong) UIButton* backBtn;
@property (nonatomic,strong) UIButton*sureBtn;// 确认按钮
@property (nonatomic,strong) NSDate *dateSelected;//日期

@end

#define RSCalendarView_WeakSelf __attribute__((objc_ownership(weak))) __typeof__(self)
#define RSCalendarView_StrongSelf __attribute__((objc_ownership(strong))) __typeof__(self)

@implementation RSCalendarView

-(id)initWithFrame:(CGRect)frame{
    CGRect screenBounds=[[UIScreen mainScreen] bounds];
    self = [super initWithFrame:screenBounds];
    if(self){
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.hidden = YES;
        _backBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = screenBounds;
        [_backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.backgroundColor=[UIColor clearColor];
        [self addSubview:_backBtn];
        
        _frontView = [[WHUCalendarView alloc]init];
        [self addSubview:_frontView];
        [_frontView mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.height.width.mas_equalTo(300);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(screenBounds.size.height/2 + 150);
        }];
        
        _sureBtn = [[UIButton alloc]init];
        _sureBtn.backgroundColor = [UIColor colorWithRed:0.93 green:0.92 blue:0.95 alpha:1];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor grayColor] forState:0];
        [_sureBtn addTarget:self action:@selector(sureDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.width.equalTo(_frontView.mas_width);
            make.height.mas_equalTo(25);
            make.top.equalTo(_frontView.mas_bottom);
            make.centerX.equalTo(self.mas_centerX);
        }];

        RSCalendarView_WeakSelf weakself = self;
        _frontView.onDateSelectBlk=^(NSDate* date){
            
            RSCalendarView_StrongSelf self = weakself;
            self.dateSelected = date;
        };
    }
    return self;
}

- (void)sureDateBtnClick:(UIButton *)btn{
    if (self.dateSelected) {
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [format stringFromDate:self.dateSelected];
        if (self.onDateSelectBlk) {
            
            self.onDateSelectBlk(dateString);
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC));
            dispatch_after(time, dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        }
    }else{
        
    }
}

- (void)dismiss{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [_frontView mas_updateConstraints:^(MASConstraintMaker *make){
            
            make.centerY.equalTo(self.mas_centerY).offset(screenBounds.size.height/2 + 150);
        }];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
    } completion:^(BOOL b){
    
         self.hidden = YES;
    }];
}

- (void) show{
    
    self.hidden = NO;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [_frontView mas_updateConstraints:^(MASConstraintMaker *make){

            make.centerY.equalTo(self.mas_centerY).offset(0);
        }];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
    } completion:nil];
}

@end
