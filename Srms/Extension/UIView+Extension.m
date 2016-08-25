//
//  UIView+Extension.m
//  srms
//
//  Created by Vincent_Guo on 16-6-16.
//  Copyright (c) 2016年 Fung. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(void)setSize:(CGSize)size{
    //self.bounds = CGRectMake(0, 0, size.width, size.height);
    CGRect frm = self.frame;
    frm.size.width = size.width;
    frm.size.height = size.height;
    //CGRectMake(0, 0, size.width, size.height);
    self.frame = frm;
}

-(CGSize)size{
    return self.bounds.size;
}

-(void)setW:(CGFloat)w{
    
    CGRect frm = self.frame;
    frm.size.width = w;
    self.frame = frm;
}

-(CGFloat)w{
    return self.size.width;
}


-(void)setH:(CGFloat)h{
    CGRect frm = self.frame;
    frm.size.height = h;
    self.frame = frm;
}

-(CGFloat)h{
    return self.size.height;
}

-(void)setX:(CGFloat)x{
    CGRect frm = self.frame;
    frm.origin.x = x;
    
    self.frame = frm;
}
-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    CGRect frm = self.frame;
    frm.origin.y = y;
    
    self.frame = frm;
    
}

-(CGFloat)y{
    return self.frame.origin.y;
}
@end
