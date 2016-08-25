//
//  RSClassifyNetwork.m
//  Srms
//
//  Created by RegentSoft on 16/7/28.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSClassifyNetwork.h"
#import "RSClassifyModel.h"

@implementation RSClassifyNetwork

- (void) loadClassifyDataWithCategoryUrl:(NSString *)urlString paramsDic:(NSDictionary *)paramsDic success:(SuccessBlock)success fail:(FailBlock)fail{
    
     [[RSNetworkManager sharedManager] POST:urlString parameters:paramsDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         _classifyModelArray = [NSMutableArray array];
         _tagSelectedArray = [NSMutableArray array];
         NSError *err;
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
         //        NSLog(@"---->%@",dic);
         NSArray *dataDicArray = dic[@"data"];
         
         for (NSDictionary *dic in dataDicArray) {
             
             RSClassifyModel *classifyModel = [[RSClassifyModel alloc]init];
             [classifyModel setValuesForKeysWithDictionary:dic];
             [_classifyModelArray addObject:classifyModel];
         }
         
         for (RSClassifyModel *classifyModel in _classifyModelArray) {
             
             NSMutableArray *mutArray = [NSMutableArray array];
             for (NSInteger i = 0; i < classifyModel.categorys.count; i ++) {
                 
                 [mutArray addObject:@"0"];
             }
             [_tagSelectedArray addObject:mutArray];
         }
         if (_classifyModelArray.count) {
             
             success(nil);
         }else{
             fail(nil);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         fail(nil);
     }];
}

@end
