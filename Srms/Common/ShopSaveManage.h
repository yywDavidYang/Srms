//
//  ShopSaveManage.h
//  Srms
//
//  Created by ohm on 16/7/25.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ShopSaveManage : NSManagedObjectContext

+(ShopSaveManage * )shareManager;

//保存进入补货池请求回来的订单的信息
- (void) saveLocaOrderProduct:(NSDictionary *)productDic;
- (void) saveLocaProduct:(NSDictionary *)productDicArray;
//保存订货时所选商品的尺码，数量
-(void) saveSizeDataLocaProduct:(NSMutableDictionary *)productSizeArray;
//保存加入搭配时的数据
- (void) saveLocalMatchedProduct:(NSDictionary *)productDicArray;
//保存加入搭配时的数据
-(void) saveMatchedDataLocaProduct:(NSMutableDictionary *)productSizeArray;
-(NSMutableArray * )getFFetchRequestData:(NSString *)className
                        fieldName:(NSString *)fieldName
                       fieldValue:(NSString *)fieldValue;
- (void)deleteTableDataByFieldNameValue:(NSString *)className
                              fieldName:(NSString *)fieldName
                             fieldValue:(NSString *)fieldValue;


@end
