//
//  RSLoginModel.h
//  Srms
//
//  Created by RegentSoft on 16/8/10.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSLoginModel : NSObject
/**
 *  通道信息
 */
@property(nonatomic,strong) NSMutableArray *channelInfoList;
/**
 *  是否校验
 */
@property(nonatomic,strong) NSNumber *ischeckstock;
/**
 *  用户名
 */
@property(nonatomic,copy)   NSString *userAccount;
/**
 *  最大库存量
 */
@property(nonatomic,strong) NSNumber *maxstock;
/**
 *  用户密码
 */
@property(nonatomic,copy)   NSString *userPwd;
/**
 *  用户名称
 */
@property(nonatomic,copy)   NSString *userName;
@end
