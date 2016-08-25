//
//  RSMatchedViewController.h
//  Srms
//
//  Created by ohm on 16/8/10.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSMatchedViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>
{

    NSMutableArray * _dataArray;

}



@property (nonatomic,strong) RSNavigationViewController *currentNavigationController;
@end
