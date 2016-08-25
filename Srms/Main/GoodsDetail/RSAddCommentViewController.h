//
//  ClassSingViewController.h
//  Srms
//
//  Created by ohm on 16/7/4.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
//评价
@interface RSAddCommentViewController : UIViewController{
    
}

@property(nonatomic ,copy)NSString * goodNoString;//商品编号

@property(nonatomic ,assign)int starNumber;//评价的星数；
@property(nonatomic ,copy)NSString *commentTypeString;//评价的类别
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *textfiled;

@end
