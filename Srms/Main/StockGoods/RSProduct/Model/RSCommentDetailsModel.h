//
//  RSCommentDetailsModel.h
//  Srms
//
//  Created by YYW on 16/8/4.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSCommentDetailsModel : NSObject

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSNumber *commentId;
@property (nonatomic, strong) NSNumber *commentTypeCode;
@property (nonatomic, copy)   NSString *commentTypeName;
@property (nonatomic, strong)   NSNumber *id_flag;

@end
