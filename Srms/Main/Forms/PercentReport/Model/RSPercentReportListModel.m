//
//  RSPercentReportListModel.m
//  Srms
//
//  Created by RegentSoft on 16/7/22.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSPercentReportListModel.h"
#import "RSPercentReportChildsModel.h"

@implementation RSPercentReportListModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        _childs = [NSMutableArray array];
        _isOpen = NO;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"childs"]) {
        
        for (NSDictionary *dic in value) {
            
            RSPercentReportChildsModel *childsModel = [[RSPercentReportChildsModel alloc]init];
            [childsModel setValuesForKeysWithDictionary:dic];
            [_childs addObject:childsModel];
        }
    }else{
        
        [super setValue:value forKey:key];
    }
}

@end
