//
//  RSHeaderCollectionReusableView.m
//  Srms
//
//  Created by RegentSoft on 16/7/28.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSHeaderCollectionReusableView.h"

@interface RSHeaderCollectionReusableView()

@property (nonatomic,strong) UILabel *labelTitle;

@end

@implementation RSHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
        [self setAutolayout];
    }
    return self;
}

- (void) createUI{
    
    _labelTitle = [[UILabel alloc]init];
    _labelTitle.textColor = [UIColor blackColor];
    _labelTitle.textAlignment = NSTextAlignmentLeft;
    _labelTitle.font = [UIFont systemFontOfSize:15];
    [self addSubview:_labelTitle];
}

- (void)setAutolayout{
    
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.mas_equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
    }];
}

- (void) setSectionTitle:(NSString *)sectionTitle{
    
    _sectionTitle = sectionTitle;
    _labelTitle.text = _sectionTitle;
}

@end
