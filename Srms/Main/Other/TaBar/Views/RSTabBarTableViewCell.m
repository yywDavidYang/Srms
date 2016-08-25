//
//  RSTabBarTableViewCell.m
//  Srms
//
//  Created by YYW on 16/7/16.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSTabBarTableViewCell.h"
#import "Masonry.h"

@interface RSTabBarTableViewCell()

@property (nonatomic,strong) UIButton *selectButton;

@end

@implementation RSTabBarTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) loadImageWithImage:(UIImage *)image selectImage:(UIImage *)selectImage tag:(NSInteger)buttonTag{
    
    _selectButton = [[UIButton alloc]init];
    _selectButton.tag = buttonTag;
    _selectButton.selected = NO;
    [_selectButton setBackgroundImage:image forState:UIControlStateNormal];
    [_selectButton setBackgroundImage:selectImage forState:UIControlStateSelected];
    
    [_selectButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectButton];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.edges.equalTo(self.contentView);
    }];
}

- (void) buttonClick:(UIButton *)sender{

    self.buttonReturnBlock(sender);
}

+(instancetype) cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID = @"TableViewCell";
    RSTabBarTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[RSTabBarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
