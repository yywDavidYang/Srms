//
//  RSClassifyModel.h
//  Srms
//
//  Created by RegentSoft on 16/7/28.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSClassifyModel : NSObject
/**
 *  类别名称
 */
@property (nonatomic, copy) NSString *categoryName;
/**
 *  列别
 */
@property (nonatomic, strong) NSMutableArray *categorys;


@end
