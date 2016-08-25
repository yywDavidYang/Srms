//
//  RSLoginModel.m
//  Srms
//
//  Created by RegentSoft on 16/8/10.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSLoginModel.h"
#import "RSLoginChannelInfoListModel.h"

@implementation RSLoginModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        _channelInfoList = [NSMutableArray array];
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
    
    if ([key isEqualToString:@"channelInfoList"]) {
        
        for (NSDictionary *dic in value) {
            
            RSLoginChannelInfoListModel *InfoListModel = [[RSLoginChannelInfoListModel alloc]init];
            NSLog(@"----->%@",dic);
            [InfoListModel setValuesForKeysWithDictionary:dic];
            [_channelInfoList addObject:InfoListModel];
        }
    }else{
        
        [super setValue:value forKey:key];
    }
}

@end
