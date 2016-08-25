//
//  RSNavigationPopView.m
//  Srms
//
//  Created by RegentSoft on 16/7/15.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSNavigationPopView.h"

@implementation RSNavigationPopView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor redColor];
        [self createUI];
    }
    return self;
}

- (void) createUI{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"lift0"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(45);
    }];
}

@end
