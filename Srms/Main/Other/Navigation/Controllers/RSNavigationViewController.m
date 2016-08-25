//
//  RSNavigationViewController.m
//  Srms
//
//  Created by RegentSoft on 16/7/15.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSNavigationViewController.h"
#import "UIView+SDAutoLayout.H"
#import "Masonry.h"
#import "RSNavigationPopView.h"
#import "ShopContainerViewController.h"
#import "MatchedShopViewController.h"
#define kShoppingCarButtonTag 1201
#define kScreenCarButtonTag 1202
#define kMatchedButtonTag 1203

@interface RSNavigationViewController ()

{
    NSMutableArray *shoppingCarAccountArray;
}

// 导航栏标题
@property (nonatomic, strong) UILabel  *navigaTitle;
// 左侧栏弹出
@property (nonatomic, strong) UIButton *popLeftViewButton;
// 购物车
@property (nonatomic, strong) UIButton *shoppingButton;
// 购物车
@property (nonatomic, strong) UIButton *matchedButton;

// 筛选
@property (nonatomic, strong) UIButton *screenButton;
// 左侧弹窗
@property (nonatomic, strong) RSNavigationPopView *navigationPopView;
// 点击展开和手机
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
// 返回按钮
@property (nonatomic, strong) UIButton *popButton;
//  购物车的商品数量
@property (nonatomic, strong) UILabel *labelGoodsCount;

@end

@implementation RSNavigationViewController

- (void)initData{
    // 获取购物车的
    shoppingCarAccountArray = [[NSMutableArray alloc]initWithArray:[[ShopSaveManage shareManager] getFFetchRequestData:@"ProductData" fieldName:nil fieldValue:nil]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"shoppingCarAccountNoti" object:nil];
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
        [self initData];
        [self createUI];
        [self setAutolayout];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void) createUI{
    [self setNavigationBarHidden:YES];
    _bar = [[UINavigationBar alloc]init];
    _bar.userInteractionEnabled = YES;
    [_bar setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:UIBarMetricsDefault];
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
    [_bar addGestureRecognizer:_tapGesture];
    [self.view addSubview:_bar];
    
    _popLeftViewButton = [[UIButton alloc]init];
    _popLeftViewButton.tag = 10111;
    _popLeftViewButton.selected = NO;
    [_popLeftViewButton setBackgroundImage:[UIImage imageNamed:@"lift26"] forState:UIControlStateNormal];
    [_popLeftViewButton addTarget:self action:@selector(popLeftViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:_popLeftViewButton];
    
    _popButton = [[UIButton alloc]init];
    _popButton.backgroundColor = [UIColor clearColor];
    [_popButton setImage:[UIImage imageNamed:@"navi_popBtn"] forState:UIControlStateNormal];
    [_popButton addTarget:self action:@selector(returnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:_popButton];
    
    _navigaTitle = [[UILabel alloc]init];
    _navigaTitle.text = @"导航栏标题";
    _navigaTitle.font = [UIFont systemFontOfSize:20.0f weight:4];
    _navigaTitle.textAlignment = NSTextAlignmentCenter;
    _navigaTitle.textColor = [UIColor whiteColor];
    [_bar addSubview:_navigaTitle];
    
    _shoppingButton = [[UIButton alloc]init];
    _shoppingButton.tag = kShoppingCarButtonTag;
    [_shoppingButton setImage:[UIImage imageNamed:@"icon2"] forState:UIControlStateNormal];
    [_shoppingButton addTarget:self action:@selector(shoppingScreenButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:_shoppingButton];
    
    
    _matchedButton = [[UIButton alloc]init];
    _matchedButton.tag = kMatchedButtonTag;
    [_matchedButton setImage:[UIImage imageNamed:@"matchedTopShop1"] forState:UIControlStateNormal];
    [_matchedButton addTarget:self action:@selector(shoppingScreenButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:_matchedButton];
    
    
    // 购物车的商品数量
    _labelGoodsCount = [[UILabel alloc]init];
    _labelGoodsCount.textColor = [UIColor whiteColor];
    _labelGoodsCount.textAlignment = NSTextAlignmentCenter;
    _labelGoodsCount.layer.cornerRadius = 7.5f;
    _labelGoodsCount.layer.masksToBounds = YES;
    if (shoppingCarAccountArray.count>0) {
        _labelGoodsCount.text = [NSString stringWithFormat:@"%ld",(unsigned long)shoppingCarAccountArray.count];
    }else{
       _labelGoodsCount.text = @"";
    }
    
    if (shoppingCarAccountArray.count > 0) {
        _labelGoodsCount.backgroundColor = [UIColor redColor];
    }else{
        _labelGoodsCount.backgroundColor = [UIColor clearColor];
    }
    _labelGoodsCount.font = [UIFont systemFontOfSize:13] ;
    [_shoppingButton addSubview:_labelGoodsCount];
    
    _screenButton = [[UIButton alloc]init];
    _screenButton.tag = kScreenCarButtonTag;
//    _screenButton.hidden = YES;
    [_screenButton setImage:[UIImage imageNamed:@"icon1"] forState:UIControlStateNormal];
    [_screenButton addTarget:self action:@selector(shoppingScreenButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bar addSubview:_screenButton];
}

- (void)setAutolayout{
    
    _bar.frame = CGRectMake(0, 0, DeviceWidth - 60, 45);
    
    [_popLeftViewButton mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.top.left.bottom.equalTo(_bar);
        make.width.mas_equalTo(0);
    }];
    
    [_popButton mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.centerY.equalTo(_bar);
        make.left.equalTo(_bar.mas_left).offset(0);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(60);
    }];
    
    [_navigaTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_bar.mas_centerX);
        make.centerY.equalTo(_bar.mas_centerY);
        make.top.bottom.equalTo(_bar);
    }];
    
    [_screenButton mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.right.equalTo(_bar.mas_right).offset(-25);
        make.top.bottom.equalTo(_bar);
        make.width.mas_equalTo(0);
    }];
    
    [_shoppingButton mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.top.bottom.equalTo(_bar);
        make.right.equalTo(_screenButton.mas_left).offset(-10);
        make.width.mas_equalTo(45);
    }];
    
    [_matchedButton mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.bottom.equalTo(_bar);
        make.right.equalTo(_shoppingButton.mas_left).offset(-10);
        make.width.mas_equalTo(45);
    }];

    //计算字符串的大小
    NSString *goodsCount = [NSString stringWithFormat:@"%ld",(unsigned long)shoppingCarAccountArray.count];
    CGSize size = [goodsCount sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0f]}];
    float width = size.width;
    [_labelGoodsCount mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.centerX.equalTo(_shoppingButton.mas_right).offset(-7);
        make.centerY.equalTo(_shoppingButton.mas_top).offset(12);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo( width + 8);
    }];
    
}

// 接收通知
- (void) notificationAction:(NSNotification *)noti{
    
    if ([noti.name isEqualToString:@"shoppingCarAccountNoti"]) {
        
        // 获取购物车的
        shoppingCarAccountArray = [[NSMutableArray alloc]initWithArray:[[ShopSaveManage shareManager] getFFetchRequestData:@"ProductData" fieldName:nil fieldValue:nil]];
        NSString *goodsCount = [NSString stringWithFormat:@"%ld",(unsigned long)shoppingCarAccountArray.count];

        if (shoppingCarAccountArray.count>0) {
            
            _labelGoodsCount.text = goodsCount;
        }else{
            
            _labelGoodsCount.text = @"";
        }
        
        if (shoppingCarAccountArray.count > 0) {
            
            _labelGoodsCount.backgroundColor = [UIColor redColor];
        }else{
            
            _labelGoodsCount.backgroundColor = [UIColor clearColor];
        }
        
        CGSize size = [goodsCount sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0f]}];
        float width = size.width;
        [_labelGoodsCount mas_updateConstraints:^(MASConstraintMaker *make){
        
            make.width.mas_equalTo(width + 8);
        }];
    }
}

// 左边栏弹出
- (void)popLeftViewClick:(UIButton *)popButton{

    NSLog(@"弹出");
    NSString *isOpen;
    if ([popButton isEqual:_popLeftViewButton]) {
        
        if (popButton.selected) {
            
            popButton.selected = NO;
            isOpen = @"0";
        }
        else{
            
            popButton.selected = YES;
            isOpen = @"1";
        }
    }
    //1.0版本不需要左边弹窗
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"popLeftView" object:isOpen];
}
// 返回
- (void)returnButtonClick:(UIButton *)sender{
    
    [self popViewControllerAnimated:YES];
}
// 购物车以及筛选按钮
- (void) shoppingScreenButtonClick:(UIButton *)button{

    switch (button.tag) {
        case kShoppingCarButtonTag:
        {
            ShopContainerViewController * shopingCart =[[ShopContainerViewController alloc] init];
            shopingCart.hidesBottomBarWhenPushed = YES;
            shopingCart.currentNavigationController = self;
            [self pushViewController:shopingCart animated:YES];
        }
            break;
        case kScreenCarButtonTag:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"classifyView" object:nil];
        }
            break;
        case kMatchedButtonTag:{
        
            MatchedShopViewController * matchedShoping =[[MatchedShopViewController alloc] init];
            matchedShoping.hidesBottomBarWhenPushed = YES;
            matchedShoping.currentNavigationController = self;
            [self pushViewController:matchedShoping animated:YES];
        }
            break;
        default:
            break;
    }
}
// 手势点击收起或展开左边了栏
- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tapGesture{
    NSString *isOpen;
    if(_popLeftViewButton.selected == NO){
        
        _popLeftViewButton.selected = YES;
        isOpen = @"1";
    }else if(_popLeftViewButton.selected == YES){
            
        _popLeftViewButton.selected = NO;
         isOpen = @"0";
    }
    //1.0版本不需要左边弹窗
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"popLeftView" object:isOpen];
}
// 隐藏自定义导航栏
- (void)setDIYNavigationBarHidden:(BOOL)isHidden{
    
    _bar.hidden = isHidden;
}

// 显示或者隐藏分类按钮
- (void) setNavigationScreenButtonHidden:(BOOL)isHidden{
    
    if (isHidden) {
        
        [_screenButton mas_updateConstraints:^(MASConstraintMaker *make){
        
            make.width.mas_offset(0);
        }];
    }else{
        
        [_screenButton mas_updateConstraints:^(MASConstraintMaker *make){
            
            make.width.mas_offset(45);
        }];
    }
}

// 设置导航栏的标题
- (void) setTitleText:(NSString *)titleText{
    
    _navigaTitle.text = titleText;
}
// 是否隐藏返回按钮
- (void) setIsHideReturnBtn:(BOOL)isHideReturnBtn{
    
    _isHideReturnBtn = isHideReturnBtn;
    _popButton.hidden = _isHideReturnBtn;
}
// 购物车按钮不可点击
- (void) setShoppingCarButtonInteraction:(BOOL) isCanClick{
    
    [_shoppingButton setUserInteractionEnabled:isCanClick];
}

// 搭配池是否可以点击
- (void) setMatchPoolButtonInteraction:(BOOL) isCanClick{
    
    [_matchedButton setUserInteractionEnabled:isCanClick];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

//把颜色转换成图片
- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
- (void)dealloc{
    
    NSLog(@"已经销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
