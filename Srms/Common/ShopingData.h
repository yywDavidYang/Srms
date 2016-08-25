//
//  ShopingData.h
//  Srms
//
//  Created by ohm on 16/7/12.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ShopingData : NSManagedObject
@property (nonatomic, retain) NSString * goodsName;//货品名称
@property (nonatomic, retain) NSString * goodsNo;//货品编号
@property (nonatomic, retain) NSNumber * disPrice;//价格
@property (nonatomic, retain) NSNumber * dpPrice;//价格
@property (nonatomic, retain) NSNumber * totalQty;//数量
@property (nonatomic, retain) NSString * disRate;//折扣
@property (nonatomic, retain) NSNumber * totalAmount;//总价格
@property (nonatomic, retain) NSString * mainPictureUrl;//图片
@property (nonatomic, retain) NSNumber * isSelected; //是否选择
@property (nonatomic, retain) NSString * goodsInfo;  //商品信息
@property (nonatomic, retain) NSString * goodsCustom;

@end
