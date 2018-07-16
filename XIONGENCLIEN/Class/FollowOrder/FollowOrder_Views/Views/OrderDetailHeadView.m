//
//  OrderDetailHeadView.m
//  XIONGEN
//
//  Created by Ios on 2018/1/26.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "OrderDetailHeadView.h"

@interface OrderDetailHeadView ()

{
    UIView *logistView;
}

@end

@implementation OrderDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIView];
    }
    return self;
}

-(void)createUIView {
    if (!_lb_oderNumber) {
        _lb_oderNumber = [[UILabel alloc] init];
        _lb_oderNumber.textColor = UIColorFromRGB(0x333333);
        _lb_oderNumber.textAlignment = NSTextAlignmentLeft;
        _lb_oderNumber.font = LSYUIFont(17);
        [self addSubview:_lb_oderNumber];
    }
    
    UIView *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 40, kScreenWidth, 1);
    line.backgroundColor = LineColor;
    [self addSubview:line];
    
    logistView = [[UIView alloc] init];
    logistView.backgroundColor = WhiteColor;
    logistView.hidden = YES;
    [self addSubview:logistView];
    
    if (!_lb_logisticsCompany) {
        _lb_logisticsCompany = [[UILabel alloc] init];
        _lb_logisticsCompany.frame = CGRectMake(mergin_left, 10, (kScreenWidth-2*mergin_left)/2, 20);
        _lb_logisticsCompany.textColor = UIColorFromRGB(0x333333);
        _lb_logisticsCompany.textAlignment = NSTextAlignmentLeft;
        _lb_logisticsCompany.font = LSYUIFont(15);
        [logistView addSubview:_lb_logisticsCompany];
    }
    
    if (!_lb_logisticsNumber) {
        _lb_logisticsNumber = [[UILabel alloc] init];
        _lb_logisticsNumber.frame = CGRectMake(CGRectGetMaxX(_lb_logisticsCompany.frame), 10, (kScreenWidth-2*mergin_left)/2, 20);
        _lb_logisticsNumber.textColor = UIColorFromRGB(0x333333);
        _lb_logisticsNumber.textAlignment = NSTextAlignmentLeft;
        _lb_logisticsNumber.font = LSYUIFont(15);
        [logistView addSubview:_lb_logisticsNumber];
    }
    
    UIView *line1 = [[UILabel alloc] init];
    line1.frame = CGRectMake(0, CGRectGetMaxY(_lb_logisticsCompany.frame)+10, kScreenWidth, 1);
    line1.backgroundColor = LineColor;
    [logistView addSubview:line1];
    
    if (!_lb_customer) {
        _lb_customer = [[UILabel alloc] init];
        _lb_customer.textColor = UIColorFromRGB(0x333333);
        _lb_customer.textAlignment = NSTextAlignmentLeft;
        _lb_customer.font = LSYUIFont(15);
        [self addSubview:_lb_customer];
    }
    
    if (!_lb_phone) {
        _lb_phone = [[UILabel alloc] init];
        _lb_phone.textColor = UIColorFromRGB(0x333333);
        _lb_phone.textAlignment = NSTextAlignmentLeft;
        _lb_phone.font = LSYUIFont(15);
        [self addSubview:_lb_phone];
    }
    
    if (!_lb_adress) {
        _lb_adress = [[UILabel alloc] init];
        _lb_adress.textColor = UIColorFromRGB(0x333333);
        _lb_adress.textAlignment = NSTextAlignmentLeft;
        _lb_adress.font = LSYUIFont(15);
        _lb_adress.numberOfLines = 2;
        [self addSubview:_lb_adress];
    }
    /*
    if (!_lb_salesmen) {
        _lb_salesmen = [[UILabel alloc] init];
        _lb_salesmen.textColor = UIColorFromRGB(0x333333);
        _lb_salesmen.textAlignment = NSTextAlignmentLeft;
        _lb_salesmen.font = LSYUIFont(15);
        [self addSubview:_lb_salesmen];
    }
    
    if (!_lb_oderMen) {
        _lb_oderMen = [[UILabel alloc] init];
        _lb_oderMen.textColor = UIColorFromRGB(0x333333);
        _lb_oderMen.textAlignment = NSTextAlignmentLeft;
        _lb_oderMen.font = LSYUIFont(15);
        [self addSubview:_lb_oderMen];
    }
    */
}

-(void)setModel:(OrderDetailModel *)model {
    _model = model;
    [_lb_oderNumber setText:[NSString stringWithFormat:@"订单号:%@",_model.orderNumber]];
    [_lb_logisticsCompany setText:[NSString stringWithFormat:@"物流公司:%@",_model.logisticName]];
    [_lb_logisticsNumber setText:[NSString stringWithFormat:@"物流单号:%@",_model.logistNumber]];
    [_lb_customer setText:[NSString stringWithFormat:@"客户:%@",_model.contact]];
    [_lb_phone setText:[NSString stringWithFormat:@"客户电话:%@",_model.phone]];
    [_lb_adress setText:[NSString stringWithFormat:@"客户地址:%@",_model.address]];
//    [_lb_salesmen setText:[NSString stringWithFormat:@"业务员:%@",_model.salesman]];
//    [_lb_oderMen setText:[NSString stringWithFormat:@"下单人:%@",_model.orderName]];
    
    
    _lb_oderNumber.frame = CGRectMake(mergin_left, 10, kScreenWidth, 20);
    if (_model.logistNumber.length!=0||_model.logisticName.length!=0) {
        logistView.hidden = NO;
        logistView.frame = CGRectMake(0, CGRectGetMaxY(_lb_oderNumber.frame)+11, kScreenWidth, 40);
         _lb_customer.frame = CGRectMake(mergin_left, CGRectGetMaxY(logistView.frame)+5, (kScreenWidth-2*mergin_left)/2, 20);
        _lb_phone.frame = CGRectMake(CGRectGetMaxX(_lb_customer.frame), CGRectGetMaxY(logistView.frame)+5, (kScreenWidth-2*mergin_left)/2, 20);
    } else {
        logistView.hidden = YES;
        _lb_customer.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_oderNumber.frame)+11, (kScreenWidth-2*mergin_left)/2, 20);
        _lb_phone.frame = CGRectMake(CGRectGetMaxX(_lb_customer.frame), CGRectGetMaxY(_lb_oderNumber.frame)+11, (kScreenWidth-2*mergin_left)/2, 20);
    }
    _lb_adress.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_customer.frame)+5, kScreenWidth, 20);
//    _lb_salesmen.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_adress.frame)+5, (kScreenWidth-2*mergin_left)/2, 20);
//    _lb_oderMen.frame = CGRectMake(CGRectGetMaxX(_lb_salesmen.frame), CGRectGetMaxY(_lb_adress.frame)+5, (kScreenWidth-2*mergin_left)/2, 20);
}



@end
