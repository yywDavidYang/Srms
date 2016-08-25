//
//  RSCommentModel.h
//  Srms
//
//  Created by YYW on 16/8/4.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSCommentModel : NSObject

@property (nonatomic, copy)   NSString *commentDate;
@property (nonatomic, strong) NSMutableArray *details;
@property (nonatomic, copy)   NSString *goodsId;
@property (nonatomic, strong) NSNumber *id_con;
@property (nonatomic, strong) NSNumber *star;
@property (nonatomic, copy)   NSString *userName;
@property (nonatomic, copy)   NSString *userNo;
@property (nonatomic, assign) BOOL isOpen;



@end
