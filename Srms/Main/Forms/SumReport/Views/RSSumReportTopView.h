//
//  RSSumReportTopView.h
//  Srms
//
//  Created by RegentSoft on 16/7/18.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SumReportButtonBlock)(UIButton *button);

@interface RSSumReportTopView : UIView

@property (nonatomic,copy) SumReportButtonBlock sumReportBtn;

@end
