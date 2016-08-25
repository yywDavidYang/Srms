//
//  PublicKit.m
//  Srms
//
//  Created by ohm on 16/6/2.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "PublicKit.h"
#import "ShopingData.h"
#define TIME_MONTHFORMAT @"yyyy-MM-dd" //时间显示格式
#define TIME_FORMAT @"HH:mm:ss" //时间显示格式
@implementation PublicKit{


}


ProductData * shopLocal;


+(NSString*)getPlistParameter:(NSString*)keyString{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:keyString];
}
//设置常用参数保存到plist文件
+(void)setPlistParameter:(NSString*)valueString setKey:(NSString*)keyString{
    [[NSUserDefaults standardUserDefaults]setObject:valueString forKey:keyString];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getDateTimeStringByTime:(NSString *)timeStampString{
    
    
    NSString *strUrl = [timeStampString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSRange range = NSMakeRange(0, 16);
    NSLog(@"rang:%@",NSStringFromRange(range));
    strUrl = [strUrl substringWithRange:range];//截取范围类的字符串
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSDate *date =[dateFormat dateFromString:strUrl];
    
    NSDate * date1 =[NSDate dateWithTimeInterval:60*60*8 sinceDate:date];
    NSDateFormatter* dateFormatUP = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *currentDateStr = [dateFormatUP stringFromDate:date1];
    return currentDateStr;
    
}
//字符串转化数组||字典
+(id)toJsonObject:(NSString *)string error:(NSError **)error
{
    if (string == nil) return nil;
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData
                                           options:NSJSONReadingAllowFragments
                                             error:error];
}

//数组||字典转化为字符串
+(NSString *)toJsonString:(id)object error:(NSError **)error
{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:error];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}



//获取当前时间，年月日
+(NSString *)getNowDateMonthTimeString{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:TIME_MONTHFORMAT];
    //用[NSDate date]可以获取系统当前时间
    return  [dateFormatter stringFromDate:[NSDate date]];
}
//获取当前时间，时分秒
+(NSString *)getNowDateTimeString{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:TIME_FORMAT];
    //用[NSDate date]可以获取系统当前时间
    return  [dateFormatter stringFromDate:[NSDate date]];
}
//订货时的数据拼接
+(NSDictionary *) saveLocaDicShop:(ProductData *)productDicArray{

//   NSMutableArray * seartchDataArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"ProductData" fieldName:nil fieldValue:nil];
//    shopLocal = [seartchDataArray objectAtIndex:0];
    
    NSMutableDictionary * shopDic = [[ NSMutableDictionary alloc] init];
    
    [shopDic setObject:productDicArray.category forKey:@"category"];    
    if (productDicArray.brand == nil || productDicArray.brand.length <= 0) {
        [shopDic setObject:productDicArray.brand forKey:@"brand"];
    }
    [shopDic setObject:@(productDicArray.dpPrice .intValue)forKey:@"dpPrice"];
    [shopDic setObject:productDicArray.goodsdesc forKey:@"goodsdesc"];
    [shopDic setObject:productDicArray.goodsName forKey:@"goodsname"];
    [shopDic setObject:productDicArray.goodsNo forKey:@"goodsno"];
    [shopDic setObject:productDicArray.material forKey:@"material"];
    [shopDic setObject:productDicArray.materialType forKey:@"materialType"];
    [shopDic setObject:productDicArray.pattern forKey:@"pattern"];
    [shopDic setObject:productDicArray.range forKey:@"range"];
    [shopDic setObject:productDicArray.season forKey:@"season"];
    [shopDic setObject:productDicArray.sex forKey:@"sex"];
    [shopDic setObject:@(productDicArray.replenishedNum.intValue)forKey:@"replenishedNum"];
    [shopDic setObject:@(productDicArray.deliveredNum.intValue) forKey:@"deliveredNum"];
    [shopDic setObject:@(productDicArray.stockNnm.intValue)forKey:@"stockNum"];
    [shopDic setObject:@(productDicArray.unDeliveredNum.intValue) forKey:@"unDeliveredNum"];
    
    NSString* trueString=nil;
    if ([productDicArray.currentUserHadCommented isEqual:@"1"]) {
        trueString = @"true";
    }else{
        trueString = @"false";
    }
    [shopDic setObject:trueString forKey:@"currentUserHadCommented"];

    NSArray * arrangeInPairsArray = [PublicKit toJsonObject:productDicArray.arrangeInPairs error:nil];
    NSArray * picturesArray = [PublicKit toJsonObject:productDicArray.pictures error:nil];
    NSArray * pricerangesArray = [PublicKit toJsonObject:productDicArray.priceranges error:nil];
    NSArray * substitutesArray = [PublicKit toJsonObject:productDicArray.substitutes error:nil];
    NSArray * sizesArray = [PublicKit toJsonObject:productDicArray.sizes error:nil];
    [shopDic setObject:arrangeInPairsArray forKey:@"arrangeInPairs"];
    [shopDic setObject:picturesArray forKey:@"pictures"];
    [shopDic setObject:pricerangesArray forKey:@"priceranges"];
    [shopDic setObject:substitutesArray forKey:@"substitutes"];
    NSMutableArray * array =[sizesArray mutableCopy];
    NSMutableArray * sizedataArray= [[ShopSaveManage shareManager] getFFetchRequestData:@"SizeData" fieldName:@"goodsNo" fieldValue:productDicArray.goodsNo];
    for (SizeData * sizeLocalcont in sizedataArray) {
        
        NSMutableDictionary * dic = [[array objectAtIndex:sizeLocalcont.totalB.intValue] mutableCopy];
        NSMutableArray * longsArray = [[dic objectForKey:@"longs"] mutableCopy];
        NSMutableDictionary * dicLongs = [[longsArray objectAtIndex:0] mutableCopy];
        NSMutableArray * colorArray = [[dicLongs objectForKey:@"colors"] mutableCopy];
        NSMutableDictionary * colorsDic = [[colorArray objectAtIndex:sizeLocalcont.totalA.intValue] mutableCopy];
        [colorsDic setValue:@(sizeLocalcont.context.intValue) forKey:@"currentqty"];
        
        [colorArray replaceObjectAtIndex:sizeLocalcont.totalA.intValue withObject:colorsDic];
        [dicLongs setValue:colorArray forKey:@"colors"];
        [longsArray replaceObjectAtIndex:0 withObject:dicLongs];
        [dic setValue:longsArray forKey:@"longs"];
        [array replaceObjectAtIndex:sizeLocalcont.totalB.intValue withObject:dic];
        
    }
    
    [shopDic setObject:array forKey:@"sizes"];
    
    return shopDic;
}
//订货时的数据凭借
+(NSMutableDictionary *) saveLocaArrayShop:(ProductData *)productDicArray setDictionary:(NSDictionary * )dictionary {
    
     NSMutableArray * searchArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"SizeData" fieldName:@"goodsNo" fieldValue:productDicArray.goodsNo];
    NSString * disString ;
    NSString * qtyString ;
    NSString * totalString  ;
    NSString * disrateString ;
    if (searchArray.count>0) {
        SizeData * sizeLocal = [searchArray objectAtIndex:0];
        disString = sizeLocal.disPrice;
        qtyString = sizeLocal.totalQty;
        totalString = sizeLocal.totalAmount;
        disrateString = [NSString stringWithFormat:@"%.2f",(sizeLocal.disPrice.floatValue/productDicArray.dpPrice.floatValue)];
    }  
    NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
    NSMutableDictionary * packWayDic =[[NSMutableDictionary alloc] init];
    [packWayDic setObject:@"" forKey:@"goodsName"];
    [dic setObject:dictionary forKey:@"goodsInfo"];
    [dic setObject:packWayDic forKey:@"packWay"];
    [dic setObject:@(disString.intValue) forKey:@"disPrice"];
    [dic setObject:@(disrateString.floatValue) forKey:@"disRate"];
    [dic setObject:@(productDicArray.dpPrice.intValue) forKey:@"dpPrice"];
    [dic setObject:productDicArray.goodsName forKey:@"goodsName"];
    [dic setObject:productDicArray.goodsNo forKey:@"goodsNo"];
    [dic setObject:@"true" forKey:@"isSelected"];
//    [dic setObject:productDicArray.mainPictureUrl forKey:@"mainPictureUrl"];
    [dic setObject:@(totalString.intValue) forKey:@"totalAmount"];
    [dic setObject:@(qtyString.intValue) forKey:@"totalQty"];
    

    return dic;
    
}
//搭配时的数据拼接
+(NSMutableDictionary *) saveMatchedLocaDicShop:(ProductData *)productDicArray{


    NSMutableDictionary * shopDic = [[ NSMutableDictionary alloc] init];
    
    [shopDic setObject:productDicArray.category forKey:@"category"];
    if (productDicArray.brand == nil || productDicArray.brand.length <= 0) {
        [shopDic setObject:productDicArray.brand forKey:@"brand"];
    }
    [shopDic setObject:@(productDicArray.dpPrice .intValue)forKey:@"dpPrice"];
    [shopDic setObject:productDicArray.goodsdesc forKey:@"goodsdesc"];
    [shopDic setObject:productDicArray.goodsName forKey:@"goodsname"];
    [shopDic setObject:productDicArray.goodsNo forKey:@"goodsno"];
    [shopDic setObject:productDicArray.material forKey:@"material"];
    [shopDic setObject:productDicArray.materialType forKey:@"materialType"];
    [shopDic setObject:productDicArray.pattern forKey:@"pattern"];
    [shopDic setObject:productDicArray.range forKey:@"range"];
    [shopDic setObject:productDicArray.season forKey:@"season"];
    [shopDic setObject:productDicArray.sex forKey:@"sex"];
    [shopDic setObject:@(productDicArray.replenishedNum.intValue)forKey:@"replenishedNum"];
    [shopDic setObject:@(productDicArray.deliveredNum.intValue) forKey:@"deliveredNum"];
    [shopDic setObject:@(productDicArray.stockNnm.intValue)forKey:@"stockNum"];
    [shopDic setObject:@(productDicArray.unDeliveredNum.intValue) forKey:@"unDeliveredNum"];
    
    NSString* trueString=nil;
    if ([productDicArray.currentUserHadCommented isEqual:@"1"]) {
        trueString = @"true";
    }else{
        trueString = @"false";
    }
    [shopDic setObject:trueString forKey:@"currentUserHadCommented"];
    
    NSArray * arrangeInPairsArray = [PublicKit toJsonObject:productDicArray.arrangeInPairs error:nil];
    NSArray * picturesArray = [PublicKit toJsonObject:productDicArray.pictures error:nil];
    NSArray * pricerangesArray = [PublicKit toJsonObject:productDicArray.priceranges error:nil];
    NSArray * substitutesArray = [PublicKit toJsonObject:productDicArray.substitutes error:nil];
    NSArray * sizesArray = [PublicKit toJsonObject:productDicArray.sizes error:nil];
    if (arrangeInPairsArray.count>0) {
        [shopDic setObject:arrangeInPairsArray forKey:@"arrangeInPairs"];
    }
    if (picturesArray.count>0) {
        [shopDic setObject:picturesArray forKey:@"pictures"];
    }
    if (pricerangesArray.count>0) {
        [shopDic setObject:pricerangesArray forKey:@"priceranges"];
    }
    if (substitutesArray.count>0) {
         [shopDic setObject:substitutesArray forKey:@"substitutes"];
    }
    if (sizesArray.count>0) {
        NSMutableArray * array =[sizesArray mutableCopy];
        NSMutableArray * sizedataArray= [[ShopSaveManage shareManager] getFFetchRequestData:@"MatchedData" fieldName:@"goodsNo" fieldValue:productDicArray.goodsNo];
        for (MatchedData * sizeLocalcont in sizedataArray) {
            
            NSMutableDictionary * dic = [[array objectAtIndex:sizeLocalcont.totalB.intValue] mutableCopy];
            NSMutableArray * longsArray = [[dic objectForKey:@"longs"] mutableCopy];
            NSMutableDictionary * dicLongs = [[longsArray objectAtIndex:0] mutableCopy];
            NSMutableArray * colorArray = [[dicLongs objectForKey:@"colors"] mutableCopy];
            NSMutableDictionary * colorsDic = [[colorArray objectAtIndex:sizeLocalcont.totalA.intValue] mutableCopy];
            [colorsDic setValue:@(sizeLocalcont.context.intValue) forKey:@"currentqty"];
            
            [colorArray replaceObjectAtIndex:sizeLocalcont.totalA.intValue withObject:colorsDic];
            [dicLongs setValue:colorArray forKey:@"colors"];
            [longsArray replaceObjectAtIndex:0 withObject:dicLongs];
            [dic setValue:longsArray forKey:@"longs"];
            [array replaceObjectAtIndex:sizeLocalcont.totalB.intValue withObject:dic];
            
        }
        
        [shopDic setObject:array forKey:@"sizes"];
    }
    
     return shopDic;
    
    
}

//搭配时的数据凭借
+(NSMutableArray *) saveMatchedLocaArrayShop:(ProductData *)productDicArray setDictionary:(NSDictionary * )dictionary setMainPicture:(NSString *)pictureString;{
    
    NSMutableArray * searchArray = [[ShopSaveManage shareManager] getFFetchRequestData:@"MatchedData" fieldName:@"goodsNo" fieldValue:productDicArray.goodsNo];
    NSString * disString ;
    NSString * qtyString ;
    NSString * totalString  ;
    NSString * disrateString ;
    if (searchArray.count>0) {
        MatchedData * sizeLocal = [searchArray objectAtIndex:0];
        disString = sizeLocal.disPrice;
        qtyString = sizeLocal.totalQty;
        totalString = sizeLocal.totalAmount;
        disrateString = [NSString stringWithFormat:@"%.2f",(sizeLocal.disPrice.floatValue/productDicArray.dpPrice.floatValue)];
    }
    NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
    NSMutableDictionary * packWayDic =[[NSMutableDictionary alloc] init];
    [packWayDic setObject:@"" forKey:@"goodsName"];
    [dic setObject:dictionary forKey:@"goodsInfo"];
    [dic setObject:packWayDic forKey:@"packWay"];
    [dic setObject:@(disString.intValue) forKey:@"disPrice"];
    [dic setObject:@(disrateString.floatValue) forKey:@"disRate"];
    [dic setObject:@(productDicArray.dpPrice.intValue) forKey:@"dpPrice"];
    [dic setObject:productDicArray.goodsName forKey:@"goodsName"];
    [dic setObject:productDicArray.goodsNo forKey:@"goodsNo"];
    [dic setObject:@"true" forKey:@"isSelected"];
    [dic setObject:pictureString forKey:@"mainPictureUrl"];
    [dic setObject:@(totalString.intValue) forKey:@"totalAmount"];
    [dic setObject:@(qtyString.intValue) forKey:@"totalQty"];
    NSMutableArray * array = [[NSMutableArray alloc] init];
    NSString * channelCode =[PublicKit getPlistParameter:channelCodeString];
    NSString * userNOString =[PublicKit getPlistParameter:NameTextString];
    [dic setObject:channelCode forKey:@"customer_id"];
    [dic setObject:userNOString forKey:@"userNo"];
    
    [array addObject:dic];
    return array;
    
}


@end
