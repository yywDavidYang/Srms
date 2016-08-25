//
//  ProductDetailsViewController.h
//  Srms
//
//  Created by ohm on 16/7/18.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
//
@interface ProductDetailsViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,retain)NSDictionary * detailDictionary; // 商品信息返回

@property (nonatomic,strong) RSNavigationViewController *currentNavigationController;
@end
