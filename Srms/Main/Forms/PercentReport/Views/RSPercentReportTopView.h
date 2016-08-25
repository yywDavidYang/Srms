//
//  RSPercentReportView.h
//  Srms
//
//  Created by RegentSoft on 16/7/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kStartDateButtonTag  30010
#define kEndDateButtonTag  30011
#define kColorButtonTag  30012
#define kSizeButtonTag  30013
#define kQueryButtonTag  30014

typedef void(^PercentReportButtonBlock)(UIButton *button);

@interface RSPercentReportTopView : UIView

@property (nonatomic,copy) PercentReportButtonBlock percentReportBtn;

@end
