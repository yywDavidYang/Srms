//
//  ShopSaveManage.m
//  Srms
//
//  Created by ohm on 16/7/25.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "ShopSaveManage.h"
#import "ShopingData.h"
#import "ProductData.h"
#import "MatchedProduct.h"
#import "SizeData.h"
@implementation ShopSaveManage
 ShopSaveManage * _saveMangage = nil;


+(ShopSaveManage * )shareManager{

    if (!_saveMangage) {
        _saveMangage = [[ShopSaveManage alloc] init];
    }
    return _saveMangage;
}
//保存进入补货池请求回来的订单的信息
- (void) saveLocaOrderProduct:(NSDictionary *)productDic{

    CoreDataManager * manager =[CoreDataManager shareManager];
    ProductData *entity = [NSEntityDescription insertNewObjectForEntityForName:@"ProductData"inManagedObjectContext:manager.managedObjectContext];
    
    
    NSDictionary * productDicArray = [productDic objectForKey:@"goodsInfo"];
    
    entity.goodsName = [productDicArray objectForKey:@"goodsname"];
    entity.goodsNo   =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"goodsno"]];
    entity.goodsdesc = [productDicArray objectForKey:@"goodsdesc"];
        entity.dpPrice =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"dpPrice"]];
    
    entity.pattern = [productDicArray objectForKey:@"pattern"];
    entity.stockNnm =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"stockNum"]];
    entity.replenishedNum =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"replenishedNum"]];
    entity.unDeliveredNum = [NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"unDeliveredNum"]];
    entity.deliveredNum = [NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"deliveredNum"]];
    entity.year =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"year"]];
    entity.season = [productDicArray objectForKey:@"season"];
    entity.brand = [NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"brand"]];
    entity.range = [productDicArray objectForKey:@"range"];
    entity.category = [productDicArray objectForKey:@"category"];
    entity.material = [productDicArray objectForKey:@"material"];
    entity.unit = [NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"unit"]];
    entity.comment = [NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"comment"]];

    entity.colors =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"colors"]];
    
    
    NSArray*arrangeInPairsarr = [productDicArray objectForKey:@"arrangeInPairs"];
    NSArray*substitutesarr = [productDicArray objectForKey:@"substitutes"];
    NSArray*picturesarr = [productDicArray objectForKey:@"pictures"];
    NSArray*pricerangesarr = [productDicArray objectForKey:@"priceranges"];
    NSArray*sizesarr= [productDicArray objectForKey:@"sizes"];
    
    NSArray * array = [productDicArray objectForKey:@"pictures"];
    if (array.count>0) {
        NSDictionary * dic =[array objectAtIndex:0];
        entity.mainPictureUrl = [dic objectForKey:@"url"];
    }
    
    if (arrangeInPairsarr.count>0) {
        entity.arrangeInPairs = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"arrangeInPairs"] error:nil]];
    }
    if (substitutesarr.count>0) {
        entity.substitutes = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"substitutes"] error:nil]];

    }
    if (pricerangesarr.count>0) {
        entity.priceranges = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"priceranges"] error:nil]];
    }
    if (picturesarr.count>0) {
         entity.pictures = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"pictures"] error:nil]];
    }
    if (sizesarr.count>0) {
        entity.sizes = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"sizes"] error:nil]];
    }

    
    entity.sex = [productDicArray objectForKey:@"sex"];
    entity.materialType =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"materialType"]];
    entity.currentUserHadCommented =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"currentUserHadCommented"]];
    
    NSError *error = nil;
    BOOL isSave =   [manager.managedObjectContext save:&error];
    if (!isSave) {        NSLog(@"error:%@,%@",error,[error userInfo]);    }    else{        NSLog(@"保存成功");    }
    
}

//保存订货时保存该(单个)商品的信息
- (void) saveLocaProduct:(NSDictionary *)productDicArray{
    
    CoreDataManager * manager =[CoreDataManager shareManager];
    ProductData *entity = [NSEntityDescription insertNewObjectForEntityForName:@"ProductData"inManagedObjectContext:manager.managedObjectContext];
    
    
//    NSDictionary * productDicArray = [productDic objectForKey:@"goodsInfo"];
    
    entity.goodsName = [productDicArray objectForKey:@"goodsname"];
    entity.goodsNo   =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"goodsno"]];
    entity.goodsdesc = [productDicArray objectForKey:@"goodsdesc"];
    entity.dpPrice =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"dpPrice"]];
    
    entity.pattern = [productDicArray objectForKey:@"pattern"];
    entity.stockNnm =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"stockNum"]];
    entity.replenishedNum =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"replenishedNum"]];
    entity.unDeliveredNum = [NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"unDeliveredNum"]];
    entity.deliveredNum = [NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"deliveredNum"]];
    entity.year =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"year"]];
    entity.season = [productDicArray objectForKey:@"season"];
    entity.brand = [productDicArray objectForKey:@"brand"];
    entity.range = [productDicArray objectForKey:@"range"];
    entity.category = [productDicArray objectForKey:@"category"];
    entity.material = [productDicArray objectForKey:@"material"];
    entity.unit = [productDicArray objectForKey:@"unit"];
    entity.comment = [NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"comment"]];
    
    entity.colors =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"colors"]];
    
    NSArray*arrangeInPairsarr = [productDicArray objectForKey:@"arrangeInPairs"];
    NSArray*substitutesarr = [productDicArray objectForKey:@"substitutes"];
    NSArray*picturesarr = [productDicArray objectForKey:@"pictures"];
    NSArray*pricerangesarr = [productDicArray objectForKey:@"priceranges"];
    NSArray*sizesarr= [productDicArray objectForKey:@"sizes"];
    
    NSArray * array = [productDicArray objectForKey:@"pictures"];
    if (array.count>0) {
        NSDictionary * dic =[array objectAtIndex:0];
        entity.mainPictureUrl = [dic objectForKey:@"url"];
    }
    
    if (arrangeInPairsarr.count>0) {
        entity.arrangeInPairs = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"arrangeInPairs"] error:nil]];
    }
    if (substitutesarr.count>0) {
        entity.substitutes = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"substitutes"] error:nil]];
        
    }
    if (pricerangesarr.count>0) {
        entity.priceranges = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"priceranges"] error:nil]];
    }
    if (picturesarr.count>0) {
        entity.pictures = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"pictures"] error:nil]];
    }
    if (sizesarr.count>0) {
        entity.sizes = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"sizes"] error:nil]];
    }
    
    
    entity.sex = [productDicArray objectForKey:@"sex"];
    entity.materialType =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"materialType"]];
    entity.currentUserHadCommented =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"currentUserHadCommented"]];
    
    NSError *error = nil;
    BOOL isSave =   [manager.managedObjectContext save:&error];
    if (!isSave) {        NSLog(@"error:%@,%@",error,[error userInfo]);    }    else{        NSLog(@"保存成功");    }
    
}
//保存订货时所选商品的尺码，数量
-(void) saveSizeDataLocaProduct:(NSMutableDictionary *)productSizeArray{

    CoreDataManager * manager =[CoreDataManager shareManager];
    SizeData *entity = [NSEntityDescription insertNewObjectForEntityForName:@"SizeData"inManagedObjectContext:manager.managedObjectContext];
    
    entity.goodsNo = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"goodsNo"]];
    entity.totalQty = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"totalQty"]];
    entity.totalAmount = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"totalAmount"]];
    entity.disPrice = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"disPrice"]];
    entity.disRate = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"disRate"]];
    entity.totalA =[NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"totalA"]];
    entity.totalB = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"totalB"]];
    entity.context =[NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"context"]];
    
    NSError *error = nil;
    BOOL isSave =   [manager.managedObjectContext save:&error];
    if (!isSave) {        NSLog(@"error:%@,%@",error,[error userInfo]);    }    else{        NSLog(@"保存成功");    }
    
    
}
//保存加入搭配时的数据
- (void) saveLocalMatchedProduct:(NSDictionary *)productDicArray{
    
    CoreDataManager * manager =[CoreDataManager shareManager];
    MatchedProduct *entity = [NSEntityDescription insertNewObjectForEntityForName:@"MatchedProduct"inManagedObjectContext:manager.managedObjectContext];
    
    
    //    NSDictionary * productDicArray = [productDic objectForKey:@"goodsInfo"];
    
    entity.goodsName = [productDicArray objectForKey:@"goodsname"];
    entity.goodsNo   =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"goodsno"]];
    entity.goodsdesc = [productDicArray objectForKey:@"goodsdesc"];
    entity.dpPrice =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"dpPrice"]];
    
    entity.pattern = [productDicArray objectForKey:@"pattern"];
    entity.stockNnm =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"stockNum"]];
    entity.replenishedNum =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"replenishedNum"]];
    entity.unDeliveredNum = [NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"unDeliveredNum"]];
    entity.deliveredNum = [NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"deliveredNum"]];
    entity.year =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"year"]];
    entity.season = [productDicArray objectForKey:@"season"];
    entity.brand = [productDicArray objectForKey:@"brand"];
    entity.range = [productDicArray objectForKey:@"range"];
    entity.category = [productDicArray objectForKey:@"category"];
    entity.material = [productDicArray objectForKey:@"material"];
    entity.unit = [productDicArray objectForKey:@"unit"];
    entity.comment = [NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"comment"]];
    entity.colors =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"colors"]];
    NSArray*arrangeInPairsarr = [productDicArray objectForKey:@"arrangeInPairs"];
    NSArray*substitutesarr = [productDicArray objectForKey:@"substitutes"];
    NSArray*picturesarr = [productDicArray objectForKey:@"pictures"];
    NSArray*pricerangesarr = [productDicArray objectForKey:@"priceranges"];
    NSArray*sizesarr= [productDicArray objectForKey:@"sizes"];
    
    NSArray * array = [productDicArray objectForKey:@"pictures"];
    if (array.count>0) {
        NSDictionary * dic =[array objectAtIndex:0];
        entity.mainPictureUrl = [dic objectForKey:@"url"];
    }
    
    if (arrangeInPairsarr.count>0) {
        entity.arrangeInPairs = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"arrangeInPairs"] error:nil]];
    }
    if (substitutesarr.count>0) {
        entity.substitutes = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"substitutes"] error:nil]];
        
    }
    if (pricerangesarr.count>0) {
        entity.priceranges = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"priceranges"] error:nil]];
    }
    if (picturesarr.count>0) {
        entity.pictures = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"pictures"] error:nil]];
    }
    if (sizesarr.count>0) {
        entity.sizes = [NSString stringWithFormat:@"%@",[PublicKit toJsonString:[productDicArray objectForKey:@"sizes"] error:nil]];
    }
    entity.sex = [productDicArray objectForKey:@"sex"];
    entity.materialType =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"materialType"]];
    entity.currentUserHadCommented =[NSString stringWithFormat:@"%@",[productDicArray objectForKey:@"currentUserHadCommented"]];
    NSError *error = nil;
    BOOL isSave =   [manager.managedObjectContext save:&error];
    if (!isSave) {        NSLog(@"error:%@,%@",error,[error userInfo]);    }    else{        NSLog(@"保存成功");    }
    
}

//保存加入搭配时的数据

-(void) saveMatchedDataLocaProduct:(NSMutableDictionary *)productSizeArray{
    
    CoreDataManager * manager =[CoreDataManager shareManager];
    MatchedData *entity = [NSEntityDescription insertNewObjectForEntityForName:@"MatchedData"inManagedObjectContext:manager.managedObjectContext];
    entity.goodsNo = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"goodsNo"]];
    entity.totalQty = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"totalQty"]];
    entity.totalAmount = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"totalAmount"]];
    entity.disPrice = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"disPrice"]];
    entity.disRate = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"disRate"]];
    entity.totalA =[NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"totalA"]];
    entity.totalB = [NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"totalB"]];
    entity.context =[NSString stringWithFormat:@"%@",[productSizeArray objectForKey:@"context"]];
    
    NSError *error = nil;
    BOOL isSave =   [manager.managedObjectContext save:&error];
    if (!isSave) {        NSLog(@"error:%@,%@",error,[error userInfo]);    }    else{        NSLog(@"保存成功");    }
    
    
}



//进入补货池获取数据
-(NSMutableArray * )getFFetchRequestData:(NSString *)className
                        fieldName:(NSString *)fieldName
                        fieldValue:(NSString *)fieldValue {
    CoreDataManager * manager =[CoreDataManager shareManager];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];//命令集
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:manager.managedObjectContext];//表
    [fetchRequest setEntity:entity];//给这个“命令”指定一个目标“表”
    NSPredicate *pred = nil;//查询语句
    if (fieldName == nil || fieldValue==nil) {
        pred = [NSPredicate predicateWithFormat:nil];
    }
    else{
        pred = [NSPredicate predicateWithFormat:@"%K == %@",fieldName,fieldValue];
    }
    [fetchRequest setPredicate:pred];//实现一个查询
    NSError *error = nil;
    NSMutableArray *mutableFetchResult = [[manager.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    return mutableFetchResult;
    

}

#pragma  mark -根据指定对象名称和条件字段删除数据
- (void)deleteTableDataByFieldNameValue:(NSString *)className
                              fieldName:(NSString *)fieldName
                             fieldValue:(NSString *)fieldValue {
    CoreDataManager * manager =[CoreDataManager shareManager];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];//命令集
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:manager.managedObjectContext];//表
    [fetchRequest setEntity:entity];//给这个“命令”指定一个目标“表”
    NSPredicate *pred = nil;//查询语句
    if (fieldName == nil || fieldValue==nil) {
        pred = [NSPredicate predicateWithFormat:nil];
    }else{
        pred = [NSPredicate predicateWithFormat:@"%K == %@",fieldName,fieldValue];
    }
    [fetchRequest setPredicate:pred];//实现一个查询
    NSError *error = nil;
    NSMutableArray *executeResult = [[manager.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];//执行“命令”，获得“结果”objects
    for(id deltetobj in executeResult){
        [manager.managedObjectContext deleteObject:deltetobj];
    }
    if (![manager.managedObjectContext save:&error]) {        NSLog(@"Error:%@,%@",error,[error userInfo]);    }    else{        NSLog(@"删除成功！");    }
}


@end
