//
//  RSNetworkManager.m
//  SDAutoLayoutDemo
//
//  Created by RegentSoft on 16/7/15.
//  Copyright © 2016年 RegentSoft. All rights reserved.
//

#import "RSNetworkManager.h"
#import "AFNetworking.h"
// 设置超时时间
static NSTimeInterval YYW_timeout = 15.0f;
// 设置最大的并发量
static NSInteger YYW_operationCount = 3;

@implementation RSNetworkManager

//获取管理者
+ (AFHTTPSessionManager *)sharedManager{
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[AFHTTPSessionManager alloc] init];
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:AuthoPassString  forHTTPHeaderField:@"Authorization"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
        // 设置超时时间
        manager.requestSerializer.timeoutInterval = YYW_timeout;
        // 设置允许同时最大并发数量，过大容易出问题
        manager.operationQueue.maxConcurrentOperationCount = YYW_operationCount;
    });
    return manager;
}
@end
