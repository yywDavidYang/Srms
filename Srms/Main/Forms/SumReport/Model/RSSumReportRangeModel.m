//
//  RSSumReportPatternRangeModel.m
//  Srms
//
//  Created by RegentSoft on 16/7/19.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import "RSSumReportRangeModel.h"

@implementation RSSumReportRangeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}

@end
