//
//  RSReportNetwork.m
//  Srms
//
//  Created by RegentSoft on 16/7/19.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSReportNetwork.h"

@implementation RSReportNetwork

- (void) postSumStatisticsDataWithUrl:(NSString *)urlString params:(NSDictionary *)paramsDic success:(SuccessBlock)success fail:(FailBlock)fail{
    
    _orderBarGraphArray = [NSMutableArray array];
    _sumReportBrandArray = [NSMutableArray array];
    _sumReportCategoryArray = [NSMutableArray array];
    _sumReportPatternArray = [NSMutableArray array];
    _sumReportRangeArray = [NSMutableArray array];
    _sumReportSeasonArray = [NSMutableArray array];
    _sumReportYearArray = [NSMutableArray array];
    _allCatogeryArray = [NSMutableArray array];
    
    NSLog(@"---->url = %@",urlString);
    [[RSNetworkManager sharedManager] POST:urlString parameters:paramsDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        
        NSArray *arrayorderBarGraph = dic[@"data"][@"orderBarGraph"];
        NSDictionary *dicPieGraph = dic[@"data"][@"pieGraph"];
        //        NSLog(@"获取回来的数据 ＝ %@",dic);
        for (NSDictionary *dic in arrayorderBarGraph) {
            RSOrderBarGraphModel *orderBarGraph = [[RSOrderBarGraphModel alloc]init];
            [orderBarGraph setValuesForKeysWithDictionary:dic];
            [_orderBarGraphArray addObject:orderBarGraph];
        }
        
        
        RSPieGraphModel *pieGraphmodel = [[RSPieGraphModel alloc]init];
        [pieGraphmodel setValuesForKeysWithDictionary:dicPieGraph];
        for (NSDictionary *dic in pieGraphmodel.brand) {
            
            RSSumReportBrandModel *model =  [[RSSumReportBrandModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_sumReportBrandArray addObject:model];
        }
        
        for (NSDictionary *dic in pieGraphmodel.category) {
            
            RSSumReportCategoryModel *model =  [[RSSumReportCategoryModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_sumReportCategoryArray addObject:model];
        }
        
        for (NSDictionary *dic in pieGraphmodel.pattern) {
            
            RSSumReportPatternModel *model =  [[RSSumReportPatternModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_sumReportPatternArray addObject:model];
        }
        
        for (NSDictionary *dic in pieGraphmodel.range) {
            
            RSSumReportRangeModel *model =  [[RSSumReportRangeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_sumReportRangeArray addObject:model];
        }
        
        for (NSDictionary *dic in pieGraphmodel.season) {
            
            RSSumReportSeasonModel *model =  [[RSSumReportSeasonModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_sumReportSeasonArray addObject:model];
        }
        
        for (NSDictionary *dic in pieGraphmodel.year) {
            
            RSSumReportYearModel *model =  [[RSSumReportYearModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_sumReportYearArray addObject:model];
        }
        
        NSMutableArray *modelArray = [NSMutableArray arrayWithObjects:_sumReportRangeArray,_sumReportCategoryArray,_sumReportPatternArray,_sumReportSeasonArray,_sumReportYearArray,_sumReportBrandArray, nil];
        for (NSMutableArray *array in  modelArray) {
            
            if (array.count > 0) {
                
                [_allCatogeryArray addObject:array];
            }
        }
        
        _summarymodel = [[RSSumReportSummarymodel alloc]init];
        [_summarymodel  setValuesForKeysWithDictionary:dic[@"data"][@"summary"]];
        //        NSLog(@"success = %@",dic);
        NSString *successString = [NSString stringWithFormat:@"%@",dic[@"success"] ];
        if ([successString isEqualToString:@"1"] ) {
            success(nil);
        }else{
            fail(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

- (void) postGoodsPercentDataWithUrl:(NSString *)urlString paramsDic:(NSDictionary *)paramsDic succss:(SuccessBlock)success fail:(FailBlock)fail{
    
    [[RSNetworkManager sharedManager] POST:urlString parameters:paramsDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _percentReportListArray = [NSMutableArray array];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        NSArray *listDicArray = dic[@"data"][@"list"];
        NSDictionary *sumDic = dic[@"data"][@"sum"];
        //         NSLog(@"获取回来的数据 ＝＝ %@",dic);
        for (NSDictionary *dic in listDicArray) {
            
            RSPercentReportListModel *listModel = [[RSPercentReportListModel alloc]init];
            [listModel setValuesForKeysWithDictionary:dic];
            [_percentReportListArray addObject:listModel];
        }
        
        _percentReportSumModel = [[RSPercentReportSumModel alloc]init];
        [_percentReportSumModel setValuesForKeysWithDictionary:sumDic];
        
        // 判断获取是否成功
        NSString *successString = [NSString stringWithFormat:@"%@",dic[@"success"] ];
        if ([successString isEqualToString:@"1"] ) {
            success(nil);
        }else{
            fail(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

@end
