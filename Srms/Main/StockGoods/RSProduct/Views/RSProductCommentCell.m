//
//  RSProductCommentCell.m
//  Srms
//
//  Created by YYW on 16/8/4.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSProductCommentCell.h"
#import "RSCommentDetailsModel.h"


#define RSScreenSizeWidth [UIScreen mainScreen].bounds.size.width
#define RSBtnTag 100001

@interface RSProductCommentCell()

@property (nonatomic,strong) UIButton *moreButton;
@property (nonatomic,strong) UIView *commentView;
@property (nonatomic, assign) BOOL isExpend;

@end

@implementation RSProductCommentCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.isExpend = NO;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
// 设置底部分界线
- (void) createBottomLine{
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void) loadViewCommentData:(RSCommentModel *)commentModel indexPath:(NSIndexPath *)index{
    for (UIView *btnView in self.contentView.subviews) {
        
        [btnView removeFromSuperview];
    }
    _moreButton = nil;
    _commentView = nil;
    [self createBottomLine];
    _indexPath = index;
    NSString *commentString = @"";
    for(RSCommentDetailsModel *deailsModel in commentModel.details) {
        
        commentString = [NSString stringWithFormat:@"%@%@",commentString,deailsModel.comment];
    }
    CGSize size = {RSScreenSizeWidth/3-65,MAXFLOAT};
    CGSize lastSize = [commentString sizeWithFont:[UIFont systemFontOfSize:12] maxiSize:size];;
    NSArray *stringArray = [commentString componentsSeparatedByString:@" "];
    commentString = [stringArray componentsJoinedByString:@""];
    //计算字符串的大小
    _isHide = YES;
    if(commentString){
        if (lastSize.height / 20 > 2) {
            
            _isHide = NO;
        }
     }
    // 设置评论星星
    UILabel * starLabel =[[UILabel alloc] init];
    starLabel.text =@"评价 :";
    starLabel.textColor = [UIColor grayColor];
    starLabel.font =[UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:starLabel];
    [starLabel mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.top.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    UIImageView *lastImageView;
    for (NSInteger i = 0; i < 5 ; i ++) {
        
        UIImageView *starImageView = [[UIImageView alloc]init];
        starImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:starImageView];
        [starImageView mas_makeConstraints:^(MASConstraintMaker *make){
        
            make.centerY.equalTo(starLabel.mas_centerY);
            make.height.width.mas_equalTo(15);
            make.left.equalTo(lastImageView?lastImageView.mas_right:starLabel.mas_right).offset(5);
        }];
        if (i < [commentModel.star integerValue]) {
            
            starImageView.image = [UIImage imageNamed:@"stars10"];
        }else{
            starImageView.image = [UIImage imageNamed:@"stars0"];
        }
        lastImageView = starImageView;
    }
   
    // 评论用户
    UILabel * userLabel =[[UILabel alloc] init];
    userLabel.text = commentModel.userName;
    userLabel.textColor = [UIColor grayColor];
    userLabel.font =[UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
    _moreButton = [[UIButton alloc]init];
    _moreButton.backgroundColor = [UIColor whiteColor];
    _moreButton.hidden = _isHide;
    _moreButton.selected = commentModel.isOpen;
    _moreButton.tag = RSBtnTag;
    [_moreButton setBackgroundImage:[UIImage imageNamed:@"moreBtn2"] forState:0];
    [_moreButton setBackgroundImage:[UIImage imageNamed:@"packUp"] forState:UIControlStateSelected];
    [_moreButton addTarget:self action:@selector(packUpCell:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreButton];
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(self.contentView).offset(-3);
        make.right.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(20);
    }];
    
    // 评论日期
    NSArray *dateArray = [commentModel.commentDate componentsSeparatedByString:@" "];
    UILabel * dateLabel =[[UILabel alloc] init];
    dateLabel.text = [dateArray firstObject];
    dateLabel.font =[UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.moreButton.mas_left).offset(-5);
        make.height.mas_equalTo(20);
    }];
    
    _commentView = [[UIView alloc]init];
    _commentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_commentView];
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make){
            
        make.top.mas_equalTo(starLabel.mas_bottom).offset(0);
        make.bottom.mas_equalTo(userLabel.mas_top).offset(0);
        make.left.right.mas_equalTo(self.contentView);
    }];

    // 评论内容
    UILabel *lastCommengtLabel;
    for( NSInteger i = 0 ; i <  commentModel.details.count ; i ++) {
        RSCommentDetailsModel *deailsModel =  commentModel.details[i];
        
        UILabel * CategoryLabel =[[UILabel alloc] init];
        CategoryLabel.font =[UIFont systemFontOfSize:12.0];
        CategoryLabel.textColor = RGBA(59, 160, 60, 1);
        CategoryLabel.numberOfLines = 0;
        [_commentView addSubview:CategoryLabel];
        
        [CategoryLabel mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.left.right.equalTo(_commentView);
            make.top.equalTo(lastCommengtLabel?lastCommengtLabel.mas_bottom:_commentView.mas_top).offset(0);
        }];
        NSString *typeCode = [NSString stringWithFormat:@"%@",deailsModel.commentTypeCode];
        if ([typeCode  isEqualToString:@"01"]) {
            
            CategoryLabel.text = [NSString stringWithFormat:@"%@",@""];
        }else{
            
            CategoryLabel.text = [NSString stringWithFormat:@"%@:",deailsModel.commentTypeName];
        }
        
        UILabel * commentLabel =[[UILabel alloc] init];
        commentLabel.font =[UIFont systemFontOfSize:12.0];
        commentLabel.text = deailsModel.comment;
        commentLabel.numberOfLines = 0;
        [_commentView addSubview:commentLabel];
        if (i == commentModel.details.count -1) {
            [commentLabel mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.right.equalTo(_commentView);
                make.top.equalTo(CategoryLabel.mas_bottom).offset(0);
                make.bottom.equalTo(_commentView.mas_bottom).offset(0);
            }];
        }else{
            
            [commentLabel mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.right.equalTo(_commentView);
                make.top.equalTo(CategoryLabel.mas_bottom).offset(0);
            }];
        }
        lastCommengtLabel = commentLabel;
    }
    
}

- (void)packUpCell:(UIButton *)btn{
    NSLog(@"indexPath = %@,_commenCellBlock = %@",_indexPath,_commentCellBlock);
    if (_indexPath) {
    
        _commentCellBlock(btn,_indexPath);
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"RSProductCommentCell"object:nil userInfo:@{@"btn":btn,@"index":_indexPath}];
    }
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
