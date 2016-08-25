//
//  ShoppingCartViewController.h
//  Srms
//
//  Created by ohm on 16/7/11.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
//管理订单列表
@interface ShoppingCartViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,retain)NSString * orderIDString;//订单编号
@property(nonatomic,retain)NSMutableArray * dataArray;
@property (nonatomic,strong) RSNavigationViewController *currentNavigationController;
@end
