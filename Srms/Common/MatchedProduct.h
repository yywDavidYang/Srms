//
//  MatchedProduct.h
//  Srms
//
//  Created by ohm on 16/8/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchedProduct : NSObject

@property (nonatomic, retain) NSNumber * isSelected; //是否选择

@property (nonatomic, retain) NSString * goodsCustom;


@property (nonatomic, retain) NSString * goodsName;//货品名称
@property (nonatomic, retain) NSString * goodsNo;//货品编号
@property (nonatomic, retain) NSString * goodsdesc;//货品的详细名称
@property (nonatomic, retain) NSString * totalQty;//数量
@property (nonatomic, retain) NSString * totalAmount;//总价格
@property (nonatomic, retain) NSString * disPrice;//优惠价格
@property (nonatomic, retain) NSString * dpPrice;//原价格
@property (nonatomic, retain) NSString * mainPictureUrl;//主图片
@property (nonatomic, retain) NSString * pattern;   // 款型
@property (nonatomic, retain) NSString * stockNnm;//商品库存
@property (nonatomic, retain) NSString * replenishedNum;//商品已补
@property (nonatomic, retain) NSString * unDeliveredNum;//商品未发
@property (nonatomic, retain) NSString * deliveredNum;//商品在途
@property (nonatomic, retain) NSString * year;   //年份
@property (nonatomic, retain) NSString * season; // 季节
@property (nonatomic, retain) NSString * brand;//品牌
@property (nonatomic, retain) NSString * range; // 系列
@property (nonatomic, retain) NSString * category;//商品的类别
@property (nonatomic, retain) NSString * material; // 材料
@property (nonatomic, retain) NSString * unit;  //“件”
@property (nonatomic, retain) NSString * comment; // 评价
@property (nonatomic, retain) NSString * colors;  //颜色
@property (nonatomic, retain) NSString * arrangeInPairs;  //搭配款
@property (nonatomic, retain) NSString * substitutes;  //替代款
@property (nonatomic, retain) NSString * pictures;  //商品的所有图片
@property (nonatomic, retain) NSString * priceranges;  //关于起批量
@property (nonatomic, retain) NSString * sizes;  //商品的所有型号大小及颜色
@property (nonatomic, retain) NSString * sex;    //  true||flase
@property (nonatomic, retain) NSString * materialType;
@property (nonatomic, retain) NSString * currentUserHadCommented; // true||flase



@end
