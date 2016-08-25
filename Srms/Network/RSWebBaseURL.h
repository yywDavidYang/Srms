//
//  RSWebBaseURL.h
//  SDAutoLayoutDemo
//
//  Created by RegentSoft on 16/7/15.
//  Copyright © 2016年 RegentSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  API
 *
 *  @param api    网络接口
 *  @param params 需要存入的请求参数，没有就为@""
 *
 *  @return 完整的链接
 */
#define RS_API_CON(api,params) [NSString stringWithFormat:@"%@%@%@",RSDomainURL,api,params]

/**
 *  域名
 */
#pragma mark - domain
/**
 *  便于域名的更新
 */
#define RSDomainURL [PublicKit getPlistParameter:SERVER_ADDRESS_KEY]

#pragma mark 基本接口
/**
 *  登陆接口
 */
UIKIT_EXTERN NSString *const RSLoginURL;
/**
 *  修改用户密码
 */
UIKIT_EXTERN NSString *const RSModifyPWDURL;
/**
 * 加载货品分类列表
 */
UIKIT_EXTERN NSString *const RSGoodsCategoryURL;
/**
 *  查询APP版本信息
 */
UIKIT_EXTERN NSString *const RSGetAppVersionURL;

#pragma mark 货品接口
/**
 *  加载货品列表接口
 */
UIKIT_EXTERN NSString *const RSGetGoodsByFliterURL;
/**
 *  加载货品详细信息{goodsNo}/{sizeStyle}
 */
UIKIT_EXTERN NSString *const RSGetGoodsInfoURL;
/**
 *  加载物料类型列表{materialType}
 */
UIKIT_EXTERN NSString *const RSGetMaterialURL;
/**
 *  获取货品的评价列表
 */
UIKIT_EXTERN NSString *const RSGetCommentsURL;
/**
 *  保存货品的评价
 */
UIKIT_EXTERN NSString *const RSSaveCommentsURL;
/**
 *  查询处于未发／已发／已补三个阶段的商品数量及库存{渠道代码}/{货号}
 */
UIKIT_EXTERN NSString *const RSGetGoodsDetailNumsURL;

#pragma mark - 订单接口
/**
 *  获取订单列表
 */

UIKIT_EXTERN NSString *const RSGetOrdersURL;
/**
 *  获取订单货品列表{orderId}
 */
UIKIT_EXTERN NSString *const RSGetOrderGoodsURL;
/**
 *  获取订单货品明细信息{orderId}/{goodsNo}/{sizeStyle}
 */
UIKIT_EXTERN NSString *const RSGetOrderDetailsURL;
/**
 *  订单的上传
 */
UIKIT_EXTERN NSString *const RSCreateOrderURL;
/**
 *  确认收货{orderNo}
 */
UIKIT_EXTERN NSString *const RSOrderAcceptURL;
/**
 *  图片上传
 */
UIKIT_EXTERN NSString *const RSFileUploadURL;

#pragma mark - 报表接口
/**
 *  总结报表接口
 */
UIKIT_EXTERN NSString *const RSReportSummaryURL;
/**
 *  商品占比报表
 */
UIKIT_EXTERN NSString *const RSQueryGoodsSettlementURL;












