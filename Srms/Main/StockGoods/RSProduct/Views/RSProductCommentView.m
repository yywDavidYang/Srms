//
//  RSProductCommentView.m
//  Srms
//
//  Created by YYW on 16/8/4.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSProductCommentView.h"
#import "RSProductCommentCell.h"
#import "RSCommentDetailsModel.h"

#define RSScreenSizeWidth [UIScreen mainScreen].bounds.size.width
#define RSBtnTag 100001

@interface RSProductCommentView()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *commentTableView;
@property(nonatomic, assign) float height;
@property (nonatomic,strong) NSIndexPath *indexPath;


@end

@implementation RSProductCommentView

- (instancetype) init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self ceateUI];
        [self setAutolayOut];
    }
    return self;
}

- (void)ceateUI{
    _height = 80;
    _commentTableView = [[UITableView alloc]init];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_commentTableView];
}
- (void) setAutolayOut{
    
    [_commentTableView mas_makeConstraints:^(MASConstraintMaker *make){
        
        
        make.left.top.right.bottom.equalTo(self);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    RSCommentModel *commentModel = _dataArray[indexPath.row];
    if (commentModel.isOpen) {
        
        return _height;
    }
    return 65 + (commentModel.details.count - 1)* 23;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cell";
    RSProductCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (commentCell == nil) {
        
        commentCell = [[RSProductCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    RSCommentModel *commentModel = _dataArray[indexPath.row];
    NSLog(@"comment = %@",commentModel.details);
    [commentCell loadViewCommentData:commentModel indexPath:indexPath];
    commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    commentCell.indexPath = indexPath;
    RS_WeakSelf sself = self;
    commentCell.commentCellBlock = ^(UIButton *btn,NSIndexPath *index){
        RS_StrongSelf self = sself;
        [self openCloseCellWithBtn:btn index:index];
    };
    return commentCell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    RSCommentModel *commentModel = _dataArray[indexPath.row];
    // 
    RSProductCommentCell *cell = [_commentTableView cellForRowAtIndexPath:indexPath];
    UIButton *btn = [cell viewWithTag:RSBtnTag];
    // 展开评论
    if (cell.isHide == NO) {
        
        if (btn.selected == NO) {
            commentModel.isOpen = YES;
            btn.selected = YES;
            NSString *commentString;
            for(RSCommentDetailsModel *deailsModel in commentModel.details) {
            
                commentString = [NSString stringWithFormat:@"%@%@",commentString,deailsModel.comment];
            }
            NSArray *stringArray = [commentString componentsSeparatedByString:@" "];
            commentString = [stringArray componentsJoinedByString:@""];
            CGSize size = {RSScreenSizeWidth/3-65,MAXFLOAT};
            CGSize lastSize = [commentString sizeWithFont:[UIFont systemFontOfSize:12] maxiSize:size];
            NSLog(@"拼接后的字符串 ＝ %@",commentString);
            //计算字符串的大小
            NSLog(@"获取到的个数 ＝ %lf",lastSize.height);
            _height = lastSize.height + 90;
            _indexPath = indexPath;
            [_commentTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }else{
            // 收起评论
            commentModel.isOpen = NO;
            btn.selected = NO;
            [_commentTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (void)openCloseCellWithBtn:(UIButton *)btn index:(NSIndexPath *)indexPath{
    
    RSCommentModel *commentModel = _dataArray[indexPath.row];
    // 展开评论
    if (btn.selected == NO) {
        
        commentModel.isOpen = YES;
        btn.selected = YES;
        NSString *commentString;
        for(RSCommentDetailsModel *deailsModel in commentModel.details) {
            
            commentString = [NSString stringWithFormat:@"%@%@",commentString,deailsModel.comment];
        }
        NSArray *stringArray = [commentString componentsSeparatedByString:@" "];
        commentString = [stringArray componentsJoinedByString:@""];
        // 根据cell的宽度计算文字的高度
        CGSize size = {RSScreenSizeWidth/3-65,MAXFLOAT};
        CGSize lastSize = [commentString sizeWithFont:[UIFont systemFontOfSize:12] maxiSize:size];
        NSLog(@"拼接后的字符串 ＝ %@",commentString);
        //计算字符串的大小
        NSLog(@"获取到的个数 ＝ %lf",lastSize.height);
        _height = lastSize.height + 90;
        _indexPath = indexPath;
        [_commentTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        // 收起评论
    }else{
        
        commentModel.isOpen = NO;
        btn.selected = NO;
        [_commentTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    
    _dataArray = dataArray;
    [_commentTableView reloadData];
}








@end
