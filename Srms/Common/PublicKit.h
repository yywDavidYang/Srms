//
//  PublicKit.h
//  Srms
//
//  Created by ohm on 16/6/2.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ProductData.h"
@interface PublicKit : NSObject

+(NSString*)getPlistParameter:(NSString*)keyString;
//设置常用参数保存到plist文件
+(void)setPlistParameter:(NSString*)valueString setKey:(NSString*)keyString;

//字符串转化数组||字典
+(id)toJsonObject:(NSString *)string error:(NSError **)error;
//数组||字典转化为字符串
+(NSString *)toJsonString:(id)object error:(NSError **)error;

+(NSString *)getDateTimeStringByTime:(NSString *)timeStampString;
+(NSString *)getNowDateMonthTimeString;//年月日
+(NSString *)getNowDateTimeString;//时分秒

//订货时的数据拼接
+(NSDictionary *) saveLocaDicShop:(ProductData *)productDicArray;
+(NSMutableDictionary *) saveLocaArrayShop:(ProductData *)productDicArray setDictionary:(NSDictionary * )dictionary;

//搭配时的数据拼接
+(NSMutableDictionary *) saveMatchedLocaDicShop:(ProductData *)productLocalcont;

//搭配时的数据凭借
+(NSMutableArray *) saveMatchedLocaArrayShop:(ProductData *)productDicArray setDictionary:(NSDictionary * )dictionary setMainPicture:(NSString *)pictureString;



@end
