//
//  RSSumReportSummarymodel.m
//  
//
//  Created by RegentSoft on 16/7/19.
//
//

#import "RSSumReportSummarymodel.h"

@implementation RSSumReportSummarymodel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}

@end
