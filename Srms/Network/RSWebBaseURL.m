//
//  RSWebBaseURL.m
//  SDAutoLayoutDemo
//
//  Created by RegentSoft on 16/7/15.
//  Copyright © 2016年 RegentSoft. All rights reserved.
//

#import "RSWebBaseURL.h"

#pragma mark - domain

#pragma mark 基本接口
/**
 *  登陆接口
 */
NSString *const RSLoginURL = @"/rs/user/login";
/**
 *  修改用户密码
 */
NSString *const RSModifyPWDURL = @"/rs/user/modifypwd";

/**
 * 加载货品分类列表
 */
NSString *const RSGoodsCategoryURL = @"/rs/common/goodscategory";

/**
 *  查询APP版本信息
 */
NSString *const RSGetAppVersionURL = @"/rs/web/getAppVersion";


#pragma mark 货品接口
/**
 *  加载货品列表接口
 */
NSString *const RSGetGoodsByFliterURL = @"/rs/goods/getGoodsbyfliter";

/**
 *  加载货品详细信息{goodsNo}/{sizeStyle}
 */
NSString *const RSGetGoodsInfoURL = @"/rs/goods/getgoodsinfo/";

/**
 *  加载物料类型列表{materialType}
 */
NSString *const RSGetMaterialURL = @"/rs/goods/getmaterial/";

/**
 *  获取货品的评价列表
 */
NSString *const RSGetCommentsURL = @"/rs/goods/getComments";

/**
 *  保存货品的评价
 */
NSString *const RSSaveCommentsURL = @"/rs/goods/saveComments";

/**
 *  查询处于未发／已发／已补三个阶段的商品数量及库存{渠道代码}/{货号}
 */
NSString *const RSGetGoodsDetailNumsURL = @"/rs/goods/getGoodsDetailNums/";

#pragma mark - 订单接口
/**
 *  获取订单列表
 */
NSString *const RSGetOrdersURL = @"/rs/orders/getorders";

/**
 *  获取订单货品列表{orderId}
 */
NSString *const RSGetOrderGoodsURL = @"/rs/orders/getordergoods/";

/**
 *  获取订单货品明细信息{orderId}/{goodsNo}/{sizeStyle}
 */
NSString *const RSGetOrderDetailsURL = @"/rs/orders/getorderdetails/";

/**
 *  订单的上传
 */
NSString *const RSCreateOrderURL = @"/rs/orders/ceateorder";

/**
 *  确认收货{orderNo}
 */
NSString *const RSOrderAcceptURL = @"/rs/orders/orderaccept/";

/**
 *  图片上传
 */
NSString *const RSFileUploadURL = @"/rs/fileupload/image";


#pragma mark - 报表接口
/**
 *  总结报表接口
 */
NSString *const RSReportSummaryURL = @"/rs/report/summary";

/**
 *  商品占比报表
 */
NSString *const RSQueryGoodsSettlementURL = @"/rs/report/queryGoodsSettlement";








