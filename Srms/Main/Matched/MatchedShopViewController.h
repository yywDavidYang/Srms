//
//  MatchedShopViewController.h
//  Srms
//
//  Created by ohm on 16/8/12.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchedShopViewController : UIViewController<UIWebViewDelegate>{


}

@property (nonatomic,strong) NSString *pidString;
@property (nonatomic,strong) NSString *flagString;
@property (nonatomic,strong) RSNavigationViewController *currentNavigationController;
@end
