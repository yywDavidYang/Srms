//
//  CollectionViewCell.m
//  Srms
//
//  Created by YYW on 16/7/27.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSClassifyCollectionViewCell.h"

@interface RSClassifyCollectionViewCell()

@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIButton *titleBtn;
//@property (nonatomic,strong) UIImageView *bgImageView;

@end

@implementation RSClassifyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        self.layer.borderWidth = 1.0f;
        
        [self createUI];
        [self setAutolayout];
    }
    return self;
}

- (void) createUI{
    
//    _bgImageView = [[UIImageView alloc]init];
//    _bgImageView.image = [UIImage imageNamed:@"1"];
//    [self.contentView addSubview:_bgImageView];
    
//    _titleLable = [[UILabel alloc]init];
//    _titleLable.textColor = [UIColor blackColor];
//    _titleLable.textAlignment = NSTextAlignmentCenter;
//    _titleLable.font = [UIFont systemFontOfSize:18 weight:0.6];
//    [self.contentView addSubview:_titleLable];
    
    _titleBtn = [[UIButton alloc]init];
    _titleBtn.selected = NO;
    [_titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_titleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [_titleBtn addTarget:self action:@selector(selecteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _titleBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _titleBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleBtn];
}

- (void)setAutolayout{
    
    [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.edges.equalTo(self.contentView);
    }];
    
//    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make){
//    
//        make.left.right.mas_equalTo(self.contentView).offset(0);
//        make.bottom.equalTo(self.contentView).offset(-10);
//        make.top.equalTo(self.contentView).offset(10);
//    }];
}

- (void) selecteButtonClick:(UIButton *)btn{
    
    // 返回按钮
    self.buttonSelectBlock(btn,_indexPath);
}

- (void) setCellTitle:(NSString *)cellTitle{
    _cellTitle = cellTitle;
    [self.titleBtn setTitle:_cellTitle forState:UIControlStateNormal];
}

//   获取选中的item的indexpath
- (void) setIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath = indexPath;
}

- (void) setSelectedTag:(NSString *)selectedTag{
    
    _selectedTag = selectedTag;
    if ([_selectedTag isEqualToString:@"1"]) {
        
        _titleBtn.selected = YES;
    }
    else if ([_selectedTag isEqualToString:@"0"]){
        
        _titleBtn.selected = NO;
    }
}


@end
