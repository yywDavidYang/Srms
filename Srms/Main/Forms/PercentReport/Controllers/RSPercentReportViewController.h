//
//  ReportViewController.h
//  CloudShoping
//
//  Created by ohm on 16/5/30.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RSPercentReportViewController: UIViewController
{
    UIButton * buttonDay;
    UIButton * buttonWeek;
    UIButton * buttonMonth;
    UIButton * classButton;//品牌；

}

@property (nonatomic,strong) RSNavigationViewController *currentNavigationController;
@end
