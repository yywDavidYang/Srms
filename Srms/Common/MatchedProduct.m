//
//  MatchedProduct.m
//  Srms
//
//  Created by ohm on 16/8/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "MatchedProduct.h"

@implementation MatchedProduct
@dynamic goodsName;//货品名称
@dynamic goodsNo;//货品编号
@dynamic goodsdesc;//货品的详细名称
@dynamic totalQty;//数量
@dynamic totalAmount;//总价格
@dynamic disPrice;//优惠价格
@dynamic dpPrice;//原价格
@dynamic mainPictureUrl;//主图片
@dynamic pattern;   // 款型
@dynamic stockNnm;//商品库存
@dynamic replenishedNum;//商品已补
@dynamic unDeliveredNum;//商品未发
@dynamic deliveredNum;//商品在途
@dynamic year;   //年份
@dynamic season; // 季节
@dynamic brand;//品牌
@dynamic range; // 系列
@dynamic category;//商品的类别
@dynamic material; // 材料
@dynamic unit;  //“件”
@dynamic comment; // 评价
@dynamic colors;  //颜色
@dynamic arrangeInPairs;  //搭配款
@dynamic substitutes;  //替代款
@dynamic pictures;  //商品的所有图片
@dynamic priceranges;  //关于起批量
@dynamic sizes;  //商品的所有型号大小及颜色
@dynamic sex;    //  true||flase
@dynamic materialType;
@dynamic currentUserHadCommented; // true||flase
@end
