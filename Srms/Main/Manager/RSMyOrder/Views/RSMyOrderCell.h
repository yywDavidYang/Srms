//
//  MyOrderCell.h
//  Srms
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 ohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@protocol BtnClickDelegate <NSObject>

- (void)btnClick:(UIButton *)button;

@end

@interface RSMyOrderCell : UITableViewCell
/**
 *  订单号
 */
@property (nonatomic, strong) UILabel *orderLab;
/**
 *  数量
 */
@property (nonatomic, strong) UILabel *countLab;
/**
 *  金额
 */
@property (nonatomic, strong) UILabel *priceLab;
/**
 *  时间
 */
@property (nonatomic, strong) UILabel *dateLab;
/**
 *  订单状态
 */
@property (nonatomic, strong) UILabel *orderState;
/**
 *  确认收货
 */
@property (nonatomic, strong) UIView *viewbtn;
/**
 *  是否收货
 */
@property  BOOL isObtaingoods;

/**
 *  cell的高度
 */
@property CGFloat cellHeight;
/**
 *  确认收货按钮
 */

@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) UILabel *creatTime;

@property (nonatomic, strong) OrderModel *model;

@property (nonatomic, assign) id<BtnClickDelegate>delegate ;

- (void) setCellDataWithArray:(NSArray *)titleArray withCeateDate:(NSString *)dateHour;


@end
