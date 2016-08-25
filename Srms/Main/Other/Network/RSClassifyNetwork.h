//
//  RSClassifyNetwork.h
//  Srms
//
//  Created by RegentSoft on 16/7/28.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSClassifyNetwork : NSObject

/**
 *   模型数组
 */
@property (nonatomic, strong) NSMutableArray *classifyModelArray;

@property (nonatomic, strong) NSMutableArray *tagSelectedArray;

/**
 *  获取分类列表的数据
 *
 *  @param urlString 网络链接
 *  @param paramsDic 传递参数
 *  @param success   成功回调
 *  @param fail      失败回调
 */
- (void) loadClassifyDataWithCategoryUrl:(NSString *)urlString
                               paramsDic:(NSDictionary *)paramsDic
                                 success:(SuccessBlock)success
                                    fail:(FailBlock)fail;

@end
