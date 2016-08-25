//
//  RSLoginChannelView.m
//  Srms
//
//  Created by RegentSoft on 16/8/10.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSLoginChannelView.h"
#import "RSLoginChannelViewCell.h"
#import "RSLoginChannelInfoListModel.h"

@interface RSLoginChannelView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@end

@implementation RSLoginChannelView
- (instancetype) init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self ceateUI];
        [self setAutolayOut];
    }
    return self;
}

- (void)ceateUI{
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    self.tableView.bounces = NO;
    [self addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[RSLoginChannelViewCell class] forCellReuseIdentifier:@"RSLoginChannelViewCell"];
}

- (void) setAutolayOut{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.edges.equalTo(self);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    RSLoginChannelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RSLoginChannelViewCell"];
    if (cell == nil) {
        
        cell = [[RSLoginChannelViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RSLoginChannelViewCell"];
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    RSLoginChannelInfoListModel *listModel = _dataArray[indexPath.row];
    cell.textString = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    RSLoginChannelInfoListModel *listModel = _dataArray[indexPath.row];
    if(self.channelNemeBlock){
        self.channelNemeBlock(_dataArray[indexPath.row]);
    }
}

- (void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
    [self.tableView reloadData];
}


@end
