//
//  SizeData.h
//  Srms
//
//  Created by ohm on 16/7/26.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SizeData : NSObject

@property (nonatomic, retain) NSString * goodsNo;//货品编号
@property (nonatomic, retain) NSString * totalQty;//单件货品的数量
@property (nonatomic, retain) NSString * totalAmount;//总价格
@property (nonatomic, retain) NSString * disPrice;//优惠价格
@property (nonatomic, retain) NSString * disRate;//折扣率
@property (nonatomic, retain) NSString * totalA;   // textfiled的i
@property (nonatomic, retain) NSString * totalB;   //textfile的j
@property(nonatomic,  retain) NSString * context;  //text输入的内容

@end
