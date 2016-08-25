//
//  RSPercentReportGridView.m
//  Srms
//
//  Created by RegentSoft on 16/7/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSPercentReportGridView.h"
#import "RSPercentReportGridHeaderView.h"
#import "RSPercentReportGridViewCell.h"
#import "RSPercentReportViewHeaderView.h"
#import "RSPercentReportListModel.h"

@interface RSPercentReportGridView()<UITableViewDelegate,UITableViewDataSource>
/**
 *  SKU数
 */
@property (nonatomic,strong) UILabel *skuLabel;
/**
 *  补货数
 */
@property (nonatomic,strong) UILabel *addGoodsLabel;
/**
 *  吊牌额
 */
@property (nonatomic,strong) UILabel *dropLabel;
/**
 *  结算额
 */
@property (nonatomic,strong) UILabel *settleAccountLabel;
/**
 *  收货数
 */
@property (nonatomic,strong) UILabel *goodsReceiptLabel;
/**
 *  占比
 */
@property (nonatomic,strong) UILabel *percentLabel;
/**
 *  网格顶部分类标题
 */
@property (nonatomic,strong) RSPercentReportGridHeaderView *gridheaderView;
/**
 *  表格底部总结
 */
@property (nonatomic,strong) RSPercentReportViewFooterView *gridFooterView;
/**
 *  <#Description#>
 */
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation RSPercentReportGridView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
        [self setAutolayout];
    }
    return self;
}
- (void) createUI{

    _gridheaderView = [[RSPercentReportGridHeaderView alloc]init];
    [self addSubview:_gridheaderView];
    
    _gridFooterView = [[RSPercentReportViewFooterView alloc]init];
    [self addSubview:_gridFooterView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
}

- (void) setAutolayout{
    
    [_gridheaderView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.top.right.left.equalTo(self);
        make.height.mas_equalTo(56);
    }];
    
    [_gridFooterView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.bottom.right.left.equalTo(self);
        make.height.mas_equalTo(56);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.top.equalTo(_gridheaderView.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.bottom.equalTo(_gridFooterView.mas_top);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    RSPercentReportListModel *listmodel = _lismodelArray[section];
    if (listmodel.isOpen) {
        
        return listmodel.childs.count;
        
    }else{
        
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _lismodelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RSPercentReportGridViewCell *cell = [RSPercentReportGridViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RSPercentReportListModel *listmodel = _lismodelArray[indexPath.section];
    RSPercentReportChildsModel *childsModel = listmodel.childs[indexPath.row];
    [cell loadTableViewCellDataWithModel:childsModel lastCell:(listmodel.childs.count - 1) == indexPath.row?YES:NO];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    RSPercentReportViewHeaderView *headerView = [RSPercentReportViewHeaderView headerViewWithTableView:tableView];
    RSPercentReportListModel *listmodel = _lismodelArray[section];
    NSArray *titleArray = @[ [NSString stringWithFormat:@"%@",listmodel.goodsNo],
                             [NSString stringWithFormat:@"%@",listmodel.goodsName],
                             [NSString stringWithFormat:@"%@",listmodel.sku],
                             [NSString stringWithFormat:@"%@",listmodel.quantity],
                             [NSString stringWithFormat:@"%.2f",[listmodel.logoAmount floatValue]],
                             [NSString stringWithFormat:@"%.2f",[listmodel.settlementAmount floatValue]],
                             [NSString stringWithFormat:@"%.2f",[listmodel.discount floatValue]],
                             [NSString stringWithFormat:@"%@",listmodel.receiptNumber],
                             [NSString stringWithFormat:@"%0.2f",[listmodel.accounting floatValue]]];
    [headerView loadHeaderViewLabelWithTitle:titleArray model:listmodel];
    __weak typeof (self)weakSelf  = self;
    headerView.isOpenSectionBlock = ^(BOOL isOpen){
        listmodel.isOpen = isOpen;
        [weakSelf openSectionWithTag:isOpen lisModel:listmodel index:section];
    };
    return headerView;
}

- (void)openSectionWithTag:(BOOL)isOpen lisModel:(RSPercentReportListModel *)listModel index:(NSInteger)index{
    
    [_tableView beginUpdates];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSInteger i = 0;i < listModel.childs.count; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:index];
        [mutableArray addObject:indexPath];
    }
    if (listModel.childs.count > 0) {
        
        if (isOpen) {
            
            [_tableView insertRowsAtIndexPaths:mutableArray withRowAnimation:UITableViewRowAnimationTop];
        }else{
            
            [_tableView deleteRowsAtIndexPaths:mutableArray withRowAnimation:UITableViewRowAnimationTop];
        }
    }
    [_tableView endUpdates];
}

- (void) setLismodelArray:(NSArray *)lismodelArray{
    
    _lismodelArray = lismodelArray;
    [self.tableView reloadData];
}

- (void)loadFooterViewDataWithModel:(RSPercentReportSumModel *)model{
    
    [_gridFooterView loadFooterViewDataWithModel:model];
}

@end
