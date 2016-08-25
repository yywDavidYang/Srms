//
//  MyOrderViewController.h
//  CloudShoping
//
//  Created by ohm on 16/5/30.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSMyOrderViewController : UIViewController
{

    
    UIButton * buttonDay;
    UIButton * buttonWeek;
    UIButton * buttonMonth;
    UIButton * classButton;//品牌；
    UIButton * startDateButton;// 起始时间；
    UIButton * endDateButton;// 末时间；
    UILabel *endDateLabel;
    NSMutableArray * dataArray;
    UITextField * searchText;
}

@property (nonatomic,strong) RSNavigationViewController *currentNavigationController;
@end
