//
//  RSPercentReportViewHeaderView.m
//  Srms
//
//  Created by YYW on 16/7/23.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSPercentReportViewHeaderView.h"

@interface RSPercentReportViewHeaderView()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *bottomLineLabel;

@end

@implementation RSPercentReportViewHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _isOpen = NO;
        self.contentView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecognizer:)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}

- (void) createUI{
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.image = [UIImage imageNamed:@"报表btn5"];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.bottom.left.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(50);
    }];
}

// 组头
+ (instancetype) headerViewWithTableView:(UITableView *)tableView{
    
    static NSString *headerIdentify = @"RSPercentReportViewHeaderView";
    RSPercentReportViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
    if (headerView == nil) {
        
        headerView = [[RSPercentReportViewHeaderView alloc]initWithReuseIdentifier:headerIdentify];
    }
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

- (void)tapRecognizer:(UITapGestureRecognizer *)tap{
    
    if (_isOpen) {
        _isOpen = NO;
        self.imageView.image = [UIImage imageNamed:@"报表btn5"];
        _bottomLineLabel.backgroundColor = [UIColor redColor];
        self.isOpenSectionBlock(_isOpen);
    }else{
        _isOpen = YES;
        _bottomLineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        self.imageView.image = [UIImage imageNamed:@"报表btn4"];
        self.isOpenSectionBlock(_isOpen);
    }
}


- (void)loadHeaderViewLabelWithTitle:(NSArray *)listArray model:(RSPercentReportListModel *)listModel{
    
    for (UIView *view in self.contentView.subviews) {
        
        [view removeFromSuperview];
    }
    _bottomLineLabel = nil;
    self.imageView = nil;
    [self createUI];
    _isOpen = listModel.isOpen;
    if (_isOpen) {
        self.imageView.image = [UIImage imageNamed:@"报表btn4"];
    }else{
         self.imageView.image = [UIImage imageNamed:@"报表btn5"];
    }
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.width.mas_equalTo(0.6);
        make.left.equalTo(self.contentView.mas_left).offset(50);
        make.top.bottom.equalTo(self.contentView).offset(0);
    }];
    
    NSArray *titleArray = @[@"货号",@"品名",@"SKU数",@"补货数",@"吊牌额",@"结算额",@"折扣(%)",@"收货数",@"占比(%)"];
    UILabel *lastTitleLabel = nil;
    for (NSInteger i = 0; i < 9; i ++) {
        //计算字符串的大小
        CGSize size = [titleArray[i] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.0f]}];
        float width = size.width;
        UILabel *titleLable = [[UILabel alloc]init];
        titleLable.backgroundColor = [UIColor whiteColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        if (i > 2) {
            
            titleLable.textColor = [UIColor orangeColor];
        }else{
            
            titleLable.textColor = [UIColor blackColor];
        }
        
        if (i <= 5 && i >= 3) {
            
            if (i == 3) {
                
                NSString *num = [NSString countNumAndChangeformat:listArray[i]];
                titleLable.text = num;
            }else{
                NSString *numberString =  [NSString stringWithFormat:@"%@.00",[NSString countNumAndChangeformat:listArray[i]]];
                titleLable.text = numberString;
            }
            
        }else{
            
            titleLable.text = listArray[i];
        }
//        titleLable.text = listArray[i];
        titleLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleLable];
        if (i == 2 || i == 3 || i == 6 ) {
            //SKU.补货数.折扣
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lastTitleLabel.mas_right).offset(0);
                make.top.equalTo(self.contentView).offset(10);
                make.bottom.equalTo(self.contentView).offset(-10);
                make.width.mas_equalTo(width + 20);
            }];
        }
        else if(i == 8){
            // 占比
            titleLable.textAlignment = NSTextAlignmentLeft;
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lastTitleLabel.mas_right).offset(25);
                make.top.equalTo(self.contentView).offset(10);
                make.bottom.equalTo(self.contentView).offset(-10);
                make.right.equalTo(self.contentView).offset(0);
//                make.width.mas_equalTo(width + 20);
            }];
            
        }else if(i == 0){
            // 货号
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lineLabel.mas_right).offset(1);
                make.top.equalTo(self.contentView).offset(10);
                make.bottom.equalTo(self.contentView).offset(-10);
                make.width.mas_equalTo(width + 100);
            }];
           
        }else if(i == 1 || i == 4 || i == 5 || i == 7 ){
            // 品名。吊牌数。计算额。收货数
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lastTitleLabel.mas_right).offset(0);
                make.top.equalTo(self.contentView).offset(10);
                make.bottom.equalTo(self.contentView).offset(-10);
                make.width.mas_equalTo(width + 60);
            }];
        }
        
        lastTitleLabel = titleLable;
    }
//
    // 地步分割线
    _bottomLineLabel = [[UILabel alloc]init];
    _bottomLineLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_bottomLineLabel];
    [_bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.height.mas_equalTo(0.6);
        make.left.bottom.right.equalTo(self.contentView);
    }];
}

@end
