//
//  RSLoginChannelView.h
//  Srms
//
//  Created by RegentSoft on 16/8/10.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSLoginChannelView : UIView

@property(nonatomic,strong) NSArray *dataArray;
/**
 *  选择店铺名称
 */
@property(nonatomic,copy) void(^channelNemeBlock)(NSString *channelName);
@end
