//
//  RSClassifyPopView.m
//  Srms
//
//  Created by RegentSoft on 16/7/27.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSClassifyPopView.h"
#import "RSClassifyCollectionViewCell.h"
#import "RSHeaderCollectionReusableView.h"
#import "RSClassifyNetwork.h"
#import "RSClassifyModel.h"

#define kScreenBounds [[UIScreen mainScreen] bounds]

@interface RSClassifyPopView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIButton* backBtn;
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIButton *btnClose;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIButton *btnSure;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) RSClassifyNetwork *network;
@property (nonatomic, strong) NSMutableArray *paramsArray;

@end


@implementation RSClassifyPopView

- (void) initWithData{
    
    _paramsArray = [NSMutableArray array];
}

-(id)initWithFrame:(CGRect)frame{
  
    self = [super initWithFrame:kScreenBounds];
    if(self){
        
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.hidden = YES;
        [self initWithData];
        [self loadDataWithUrl];
        [self createUI];
        [self setAutolayout];
    }
    return self;
}

#pragma mark - UI


NSString *HeaderIdentify = @"headerIdentify";
- (void) createUI{
    
    // 背景按钮
    _backBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    _backBtn.frame=kScreenBounds;
    [_backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _backBtn.backgroundColor=[UIColor clearColor];
    [self addSubview:_backBtn];
    
    // 弹窗
    _frontView = [[UIView alloc]init];
    _frontView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_frontView];
    // 关闭按钮
    _btnClose = [[UIButton alloc]init];
    [_btnClose setBackgroundImage:[UIImage imageNamed:@"popViewCloseBtn"] forState:UIControlStateNormal];
    [_btnClose setBackgroundImage:[UIImage imageNamed:@"popViewCloseBtn2"] forState:UIControlStateSelected];
    _btnClose.selected = NO;
    [_btnClose addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_frontView addSubview:_btnClose];
    
    // 标题背景
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.image = [UIImage imageNamed:@"top"];
    [_frontView addSubview:_headerImageView];
    // 弹出框标题
    _titleLable = [[UILabel alloc]init];
    _titleLable.text = @"筛选";
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.font = [UIFont systemFontOfSize:22 weight:1.0f];
    [self.headerImageView addSubview:_titleLable];
    
    // 确定按钮
    _btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSure setBackgroundImage:[UIImage imageNamed:@"sureBtn1_2"] forState:UIControlStateNormal];
    [_btnSure addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_frontView addSubview:_btnSure];
    
    // 分类列表
    [self.collectionView registerClass:[RSHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentify];
    [self.collectionView registerClass:[RSClassifyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.frontView addSubview:self.collectionView];
}

- (void)setAutolayout{
    
    [_frontView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.width.mas_equalTo(600);
        make.height.mas_equalTo(self.frame.size.height - 80);
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(self.frame.size.height - 80);
    }];
    
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.equalTo(_frontView.mas_top).offset(0);
        make.right.equalTo(_frontView.mas_right).offset(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(44);
    }];
    
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.top.equalTo(_frontView);
        make.height.mas_equalTo(44);
        make.right.equalTo(_btnClose.mas_left).offset(0);
    }];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.equalTo(_headerImageView.mas_top).offset(5);
        make.bottom.equalTo(_headerImageView.mas_bottom).offset(-5);
        make.centerX.equalTo(self.frontView.mas_centerX);
    }];
    
    [_btnSure mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.centerX.equalTo(_frontView.mas_centerX);
        make.bottom.equalTo(_frontView);
        make.height.mas_equalTo(58);
        make.width.mas_equalTo(259);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.right.left.equalTo(_frontView);
        make.top.equalTo(_frontView.mas_top).offset(44);
        make.bottom.equalTo(_btnSure.mas_top).offset(0);
    }];
}

- (void)loadDataWithUrl{
   
    _network = [[RSClassifyNetwork alloc]init];
    __block RSClassifyPopView *popView = self;
    [_network loadClassifyDataWithCategoryUrl:RS_API_CON(RSGoodsCategoryURL, @"") paramsDic:nil success:^(NSMutableArray *array){
        [popView.collectionView reloadData];
    } fail:^(NSError *error){
    }];
    
}
#pragma mark - Delegate&notic
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    RSClassifyModel *classifyModel = _network.classifyModelArray[section];
    return classifyModel.categorys.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _network.classifyModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RSClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    RSClassifyModel *classifyModel = _network.classifyModelArray[indexPath.section];
    cell.cellTitle = classifyModel.categorys[indexPath.item];
    cell.indexPath = indexPath;
    RS_WeakSelf weakSelf = self;
    cell.buttonSelectBlock = ^(UIButton *btn, NSIndexPath *indexPath){
        RS_StrongSelf strongSelf = weakSelf;
        [strongSelf selectBtnClick:btn indexPath:indexPath];
    };
    cell.selectedTag = _network.tagSelectedArray[indexPath.section][indexPath.item];
    return cell;
}

// 组头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        RSHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentify forIndexPath:indexPath];
        RSClassifyModel *classifyModel = _network.classifyModelArray[indexPath.section];
        headerView.sectionTitle = classifyModel.categoryName;
        return headerView;
    }else{
        
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _network.classifyModelArray.count - 1) {
        
        return CGSizeMake(183, 30);
    }
    return CGSizeMake(108, 30);
}

// 最小的行距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    
//    if (<#condition#>) {
//        <#statements#>
//    }
//}

// 最小列距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == _network.classifyModelArray.count - 1) {
        
        return 15;
    }
    return 10;
}

#pragma mark - Responder
#pragma mark - Event
// 收起弹窗
- (void)dismiss{

    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [_frontView mas_updateConstraints:^(MASConstraintMaker *make){
            
            make.bottom.equalTo(self.mas_bottom).offset(self.frame.size.height - 80);
        }];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
    } completion:^(BOOL b){
    
        self.hidden = YES;
    }];
}

- (void) sureBtnClick:(UIButton *)btn {
    NSMutableArray *sendParamsDic = [_paramsArray mutableCopy];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RSClassifyPopView" object:self userInfo:@{@"dic":sendParamsDic}];
    [self dismiss];
}

// 显示弹窗
- (void) show{
    
    self.hidden = NO;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [_frontView mas_updateConstraints:^(MASConstraintMaker *make){
            
            make.bottom.equalTo(self.mas_bottom).offset(-40);
        }];
        [self resetParamsArray];
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
    } completion:^(BOOL b){
        
        
    }];
}

// item按钮的选择
- (void) selectBtnClick:(UIButton *)btn indexPath:(NSIndexPath *)indexPath{
    
    RSClassifyModel *classifyModel = _network.classifyModelArray[indexPath.section];
    NSString *btnString = btn.titleLabel.text;
    NSArray *selectArray = @[btnString];
    NSDictionary *dic = @{@"categoryName":classifyModel.categoryName,@"categorys":selectArray};
    
    if (btn.selected) {
        
        btn.selected = NO;
        [_network.tagSelectedArray[indexPath.section] replaceObjectAtIndex:indexPath.item withObject:@"0"];
        
        for (NSInteger i = 0 ; i < _paramsArray.count ; i ++) {
            
            NSDictionary *dicSelected = _paramsArray[i];
            if ([dic[@"categoryName"] isEqualToString:dicSelected[@"categoryName"]]) {
                
                [_paramsArray removeObjectAtIndex:i];
                break;
            }
        }

    }else{
        
        btn.selected = YES;
        NSMutableArray *array = _network.tagSelectedArray[indexPath.section];
        for (NSInteger i = 0; i < array.count; i ++) {
            [_network.tagSelectedArray[indexPath.section] replaceObjectAtIndex:i withObject:@"0"];
        }
        [_network.tagSelectedArray[indexPath.section] replaceObjectAtIndex:indexPath.item withObject:@"1"];
        
        if (_paramsArray.count > 0) {
            BOOL isInside = NO;
            for (NSInteger i = 0 ; i < _paramsArray.count ; i ++) {
                NSDictionary *dicSelected = _paramsArray[i];
                // 判断是否存在
                if ([dic[@"categoryName"] isEqualToString:dicSelected[@"categoryName"]]) {
                    isInside = YES;
                    [_paramsArray replaceObjectAtIndex:i withObject:dic];
                    break;
                }
            }
            // 不存在就添加到数组内
            if (isInside == NO) {
                
                [_paramsArray addObject:dic];
            }
        }
        else{
            
            [_paramsArray addObject:dic];
        }
    }
     NSLog(@"jjjj = %@",_paramsArray);
    [_collectionView reloadData];
}

#pragma mark - Methon
// 退出以后置位数据
- (void)resetParamsArray{
    
    [_network.tagSelectedArray removeAllObjects];
    for (RSClassifyModel *classifyModel in _network.classifyModelArray) {
        
        NSMutableArray *mutArray = [NSMutableArray array];
        for (NSInteger i = 0; i < classifyModel.categorys.count; i ++) {
            
            [mutArray addObject:@"0"];
        }
        [_network.tagSelectedArray addObject:mutArray];
    }
    [_paramsArray removeAllObjects];
    [_collectionView reloadData];
}
- (UICollectionViewFlowLayout *)flowLayout{
    
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
//        _flowLayout.itemSize = CGSizeMake(108, 30);
        _flowLayout.minimumLineSpacing = 10;
//        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _flowLayout.headerReferenceSize = CGSizeMake(600, 20);// 先要设置组头高度，才会调用协议的方法
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}


@end
















