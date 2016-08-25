//
//  RSNewProductViewController.h
//  Srms
//
//  Created by YYW on 16/7/17.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSNewProductViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    NSArray * titleImageArray;
    NSArray * titleArray;
    NSArray * imageArray;
    NSArray * imageSelectArray;
    UITableView * shopTableView;
    UICollectionView * shopCellView;
    //可以装三个元素  每一个元素默认都是NO 达到传值的目的
    BOOL isFlag[3];
    
    UIButton * buttonDay;
    UIButton * buttonWeek;
    UIButton * buttonMonth;
    
    UITableView * catoaryTableView;
    UIButton * classButton;//品牌；
    NSDictionary * categoryDic;
    NSArray      * categoryArray;
    NSString * sortKeyString ;//选择的日，周，月
    NSString * categoryNameString;//选择的品牌
    NSString * categoryString ;//选择的品牌系列
    UIImageView * categoryBackImage;
}

@property (nonatomic ,retain)NSArray * dataDictionary;
@property (nonatomic ,retain)NSArray * dataArray;
@property (nonatomic ,copy)NSString * catoryString;//补货的类别
@property (nonatomic ,copy)NSString * catoryOtherString;//补货的类别
@property (nonatomic,strong) RSNavigationViewController *currentNavigationController;
@end
