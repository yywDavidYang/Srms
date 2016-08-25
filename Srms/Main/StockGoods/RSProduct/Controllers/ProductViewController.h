//
//  ProductViewController.h
//  Srms
//
//  Created by ohm on 16/6/7.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopViewCollectionViewCell.h"
#import "SubstitutesCollectionViewCell.h"
@interface ProductViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray * titleImageArray;
    NSArray * titleArray;
    NSArray * imageArray;
    NSArray * imageSelectArray;
    UITableView * shopTableView;
    
    UIView * leftView;
    BOOL isFlag[3];
    
    UIView * rightView;
    
    UITableView * formTableView;          //订货的表
    NSArray * colorArray;                 //商品的颜色
    NSArray * sizeArray;                  //商品的型号
    NSArray* longArray;      
    UICollectionView * shopCellView;      //搭配款的cell
    UICollectionView * substituteCellView;//替代款的cell
    
    UIView * goodsShopview;
    
    UIButton * shopbutton1;              //商品评价按钮
    UIButton * shopbutton2;             //商品详情按钮
    UITableView * evaluTableView;      //商品的评价列表
    NSArray * rowsArray;               //商品的评价返回数据
    UIImageView* evluaImageView;       //评价更多
    UIView * accountView;
    UITableView * accountTableView;
    
    
    UITextField * sizefiled;
    UILabel * numberColorLabel;//共多少件；
    

}

@property(nonatomic, retain)NSString * disPriceString;//优惠价
@property(nonatomic, retain)NSString * mainPictureUrlString;//主图片
@property(nonatomic ,copy)NSString * goodNoString;//商品编号
@property(nonatomic ,copy)NSString * catoryString;//补货的类别
@property (nonatomic,retain)NSDictionary * dataDictionary; // 商品信息返回

@property (nonatomic,retain)NSDictionary * accountDictionary;//商品明细返回
@property (nonatomic,retain)NSMutableArray * accountArray;//商品明细返回

@property (nonatomic,copy)NSString * stockNnm;//商品库存
@property (nonatomic,copy)NSString * replenishedNum;//商品已补
@property (nonatomic,copy)NSString * unDeliveredNum;//商品未发
@property (nonatomic,copy)NSString * deliveredNum;//商品在途
@property (nonatomic,assign)int sizeNnm;//共多少件；
@property (nonatomic,strong) RSNavigationViewController *currentNavigationController;


@end
