//
//  RSNetworkManager.h
//  SDAutoLayoutDemo
//
//  Created by RegentSoft on 16/7/15.
//  Copyright © 2016年 RegentSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface RSNetworkManager : UIView

//获取管理者
+ (AFHTTPSessionManager *)sharedManager;

@end
