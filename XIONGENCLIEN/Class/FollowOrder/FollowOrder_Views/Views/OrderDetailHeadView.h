//
//  OrderDetailHeadView.h
//  XIONGEN
//
//  Created by Ios on 2018/1/26.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface OrderDetailHeadView : UIView

@property (nonatomic,strong) UILabel *lb_oderNumber;
@property (nonatomic,strong) UILabel *lb_logisticsCompany;
@property (nonatomic,strong) UILabel *lb_logisticsNumber;
@property (nonatomic,strong) UILabel *lb_customer;
@property (nonatomic,strong) UILabel *lb_phone;
@property (nonatomic,strong) UILabel *lb_adress;
//@property (nonatomic,strong) UILabel *lb_salesmen;
//@property (nonatomic,strong) UILabel *lb_oderMen;

@property (nonatomic,strong) OrderDetailModel *model;


@end
