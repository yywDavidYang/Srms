//
//  RSLoginModel.h
//  Srms
//
//  Created by RegentSoft on 16/8/10.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSLoginChannelInfoListModel : NSObject
/**
 *  渠道号
 */
@property(nonatomic,copy) NSString *channelCode;
/**
 *  店铺名称
 */
@property(nonatomic,copy) NSString *channelName;
/**
 *  店铺地址
 */
@property(nonatomic,copy) NSString *channelAddress;

@end
