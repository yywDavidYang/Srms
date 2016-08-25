//
//  RSCalendarView.h
//  CalendarDemo
//
//  Created by RegentSoft on 16/7/27.
//  Copyright © 2016年 RegentSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSCalendarView : UIView

-(void)dismiss;
-(void)show;
@property (nonatomic, strong) void(^onDateSelectBlk)(NSString *dateString);

@end
