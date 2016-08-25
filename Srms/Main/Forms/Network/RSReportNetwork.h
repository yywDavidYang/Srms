//
//  RSReportNetwork.h
//  Srms
//
//  Created by RegentSoft on 16/7/19.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>
// 总结报表model
#import "RSOrderBarGraphModel.h"
#import "RSPieGraphModel.h"
#import "RSSumReportBrandModel.h"
#import "RSSumReportCategoryModel.h"
#import "RSSumReportPatternModel.h"
#import "RSSumReportRangeModel.h"
#import "RSSumReportSeasonModel.h"
#import "RSSumReportYearModel.h"
#import "RSSumReportSummarymodel.h"

// 商品占比
#import "RSPercentReportListModel.h"
#import "RSPercentReportChildsModel.h"
#import "RSPercentReportSumModel.h"

@interface RSReportNetwork : NSObject
// 总结报表
@property (nonatomic,strong) NSMutableArray *orderBarGraphArray;
@property (nonatomic,strong) NSMutableArray *pieGraphArray;
@property (nonatomic,strong) NSMutableArray *sumReportBrandArray;
@property (nonatomic,strong) NSMutableArray *sumReportCategoryArray;
@property (nonatomic,strong) NSMutableArray *sumReportPatternArray;
@property (nonatomic,strong) NSMutableArray *sumReportRangeArray;
@property (nonatomic,strong) NSMutableArray *sumReportSeasonArray;
@property (nonatomic,strong) NSMutableArray *sumReportYearArray;
@property (nonatomic,strong) RSSumReportSummarymodel *summarymodel;
//  保存饼状图数据
@property (nonatomic,strong) NSMutableArray *allCatogeryArray;

// 商品占比
@property (nonatomic,strong) NSMutableArray *percentReportListArray;
@property (nonatomic,strong) RSPercentReportSumModel *percentReportSumModel;

/**
 *  总结报表的数据
 *
 *  @param urlString url
 *  @param paramsDic 请求的参数
 *  @param success   成功的回调
 *  @param fail      失败的回调
 */
- (void) postSumStatisticsDataWithUrl:(NSString *)urlString params:(NSDictionary *)paramsDic success:(SuccessBlock)success fail:(FailBlock)fail;

/**
 *  商品占比
 *
 *  @param urlString url
 *  @param paramsDic 请求参数
 *  @param success   成功回调
 *  @param fail      失败回调
 */
- (void) postGoodsPercentDataWithUrl:(NSString *)urlString paramsDic:(NSDictionary *)paramsDic succss:(SuccessBlock)success fail:(FailBlock)fail;

@end
