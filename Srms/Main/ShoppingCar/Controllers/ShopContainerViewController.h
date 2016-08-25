//
//  ShopContainerViewController.h
//  Srms
//
//  Created by ohm on 16/7/20.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopContainerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    //总金额
    UILabel * allMoney;
    //数量
    UILabel * quantityLabel;


}



@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSDictionary * dictionary;
@property(nonatomic,retain)NSString  * goodsNoString;

@property (nonatomic,strong) RSNavigationViewController *currentNavigationController;
@end
