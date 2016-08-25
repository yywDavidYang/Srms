//
//  RSPercentReportGridViewCell.m
//  Srms
//
//  Created by RegentSoft on 16/7/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSPercentReportGridViewCell.h"

@interface RSPercentReportGridViewCell()

@property(nonatomic,strong) UILabel *leftLabel;

@end

@implementation RSPercentReportGridViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    _leftLabel = [[UILabel alloc]init];
    _leftLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_leftLabel];
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.width.mas_equalTo(51);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.height.mas_equalTo(0.6);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.bottom.right.equalTo(self.contentView);
        make.left.equalTo(_leftLabel.mas_right).offset(0);
        make.height.mas_equalTo(1);
    }];
}

- (void) loadTableViewCellDataWithModel:(RSPercentReportChildsModel *)model lastCell:(BOOL)isLastCell{
    
    for (UIView *view in self.contentView.subviews) {
        
        [view removeFromSuperview];
    }
    
    [self creatUI];
    NSArray *dataArray = @[ [NSString stringWithFormat:@"%@",@""],
                             [NSString stringWithFormat:@"%@",model.goodsName],
                             [NSString stringWithFormat:@"%@",@""],
                             [NSString stringWithFormat:@"%@",model.quantity],
                             [NSString stringWithFormat:@"%@",model.logoAmount],
                             [NSString stringWithFormat:@"%@",model.settlementAmount],
                             [NSString stringWithFormat:@"%.2f",[model.discount floatValue]],
                             [NSString stringWithFormat:@"%@",model.receiptNumber],
                             [NSString stringWithFormat:@"%0.2f",[model.accounting floatValue]]];

    NSArray *titleArray = @[@"货号",@"品名",@"SKU数",@"补货数",@"吊牌额",@"结算额",@"折扣(%)",@"收货数",@"占比(%)"];
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.width.mas_equalTo(0.6);
        make.left.equalTo(self.contentView.mas_left).offset(50);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
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
                
                NSString *num = [NSString countNumAndChangeformat:dataArray[i]];
                titleLable.text = num;
            }else{
                NSString *numberString =  [NSString stringWithFormat:@"%@.00",[NSString countNumAndChangeformat:dataArray[i]]];
                titleLable.text = numberString;
            }
            
        }else{
            
            titleLable.text = dataArray[i];
        }
        
        titleLable.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:titleLable];
        if (i == 2 || i == 3 || i == 6 ) {
            
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lastTitleLabel.mas_right).offset(0);
                make.top.equalTo(self.contentView.mas_top).offset(10);
                make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
                make.width.mas_equalTo(width + 20);
            }];
        }
        else if(i == 8){
            titleLable.textAlignment = NSTextAlignmentLeft;
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lastTitleLabel.mas_right).offset(25);
                make.top.equalTo(self.contentView.mas_top).offset(10);
                make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
                make.right.equalTo(self.contentView).offset(0);
            }];
            
        }else if(i == 0){
            
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lineLabel.mas_right).offset(1);
                make.top.equalTo(self.contentView.mas_top).offset(10);
                make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
                make.width.mas_equalTo(width + 100);
            }];
            
        }else if(i == 1 || i == 4 || i == 5 || i == 7 ){
            
            
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make){
                
                make.left.equalTo(lastTitleLabel.mas_right).offset(0);
                make.top.equalTo(self.contentView.mas_top).offset(10);
                make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
                make.width.mas_equalTo(width + 60);
            }];
        }
        lastTitleLabel = titleLable;
    }
    
    UILabel *directoryLabel = [[UILabel alloc]init];
    directoryLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:directoryLabel];
    if (isLastCell) {
        
        _leftLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        
        [directoryLabel mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.left.equalTo(self.contentView).offset(25);
            make.bottom.equalTo(self.contentView.mas_centerY).offset(0);
            make.top.equalTo(self.contentView).offset(0);
            make.width.mas_equalTo(0.6);
        }];
    }
    else{
       
        [directoryLabel mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.left.equalTo(self.contentView).offset(25);
            make.bottom.equalTo(self.contentView).offset(0);
            make.top.equalTo(self.contentView).offset(0);
            make.width.mas_equalTo(0.6);
        }];
    }
    
    UILabel *honLabel = [[UILabel alloc]init];
    honLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:honLabel];
    [honLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(directoryLabel.mas_right).offset(0);
        make.height.mas_equalTo(0.6);
        make.width.mas_equalTo(10);
    }];
}

// 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellIdentify = @"viewCell";
    
    RSPercentReportGridViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        
        cell = [[RSPercentReportGridViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    return cell;
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
