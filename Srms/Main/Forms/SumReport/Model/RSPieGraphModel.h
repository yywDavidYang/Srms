//
//  RSSumReportSecondModel.h
//  Srms
//
//  Created by RegentSoft on 16/7/19.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSPieGraphModel : NSObject

@property (nonatomic, strong) NSMutableArray *brand;
@property (nonatomic, strong) NSMutableArray *category;
@property (nonatomic, strong) NSMutableArray *pattern;
@property (nonatomic, strong) NSMutableArray *range;
@property (nonatomic, strong) NSMutableArray *season;
@property (nonatomic, strong) NSMutableArray *year;
@property (nonatomic, strong) NSDictionary *summary;


@end
