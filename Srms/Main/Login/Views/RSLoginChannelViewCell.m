//
//  RSLoginChannelViewCell.m
//  Srms
//
//  Created by RegentSoft on 16/8/10.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSLoginChannelViewCell.h"
@interface RSLoginChannelViewCell()

@property(nonatomic,strong) UILabel  *channelNameLabel;

@end
@implementation RSLoginChannelViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = RGBA(57, 162, 66, 1.0f);
        [self createUI];
    }
    return self;
}
- (void) createUI{
    
    _channelNameLabel = [[UILabel alloc]init];
    _channelNameLabel.textAlignment = NSTextAlignmentCenter;
    _channelNameLabel.textColor = [UIColor whiteColor];
    _channelNameLabel.font = [UIFont systemFontOfSize:17 weight:0.5];
    _channelNameLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_channelNameLabel];
    [self.channelNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.edges.equalTo(self.contentView);
    }];
}

- (void) setTextString:(NSString *)textString{
    
    _textString = textString;
    _channelNameLabel.text = _textString;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
