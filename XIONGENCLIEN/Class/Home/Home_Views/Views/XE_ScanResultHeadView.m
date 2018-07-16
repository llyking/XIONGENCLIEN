//
//  XE_ScanResultHeadView.m
//  XIONGEN
//
//  Created by Ios on 2018/1/22.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XE_ScanResultHeadView.h"

@implementation XE_ScanResultHeadView
{
    UILabel *line;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIView];
    }
    return self;
}

-(void)createUIView {
    if (!_lb_orderNumber) {
        _lb_orderNumber = [[UILabel alloc] init];
        _lb_orderNumber.textColor = UIColorFromRGB(0x333333);
        _lb_orderNumber.textAlignment = NSTextAlignmentLeft;
        _lb_orderNumber.font = LSYUIFont(15);
        [self addSubview:_lb_orderNumber];
    }
    
    if (!_lb_custom) {
        _lb_custom = [[UILabel alloc] init];
        _lb_custom.textColor = UIColorFromRGB(0x333333);
        _lb_custom.textAlignment = NSTextAlignmentLeft;
        _lb_custom.font = LSYUIFont(13);
        [self addSubview:_lb_custom];
    }
    
    if (!_lb_phone) {
        _lb_phone = [[UILabel alloc] init];
        _lb_phone.textColor = UIColorFromRGB(0x333333);
        _lb_phone.textAlignment = NSTextAlignmentLeft;
        _lb_phone.font = LSYUIFont(13);
        [self addSubview:_lb_phone];
    }
    
    if (!_lb_address) {
        _lb_address = [[UILabel alloc] init];
        _lb_address.textColor = UIColorFromRGB(0x333333);
        _lb_address.textAlignment = NSTextAlignmentLeft;
        _lb_address.font = LSYUIFont(13);
        [self addSubview:_lb_address];
    }
    
    if (!_lb_salemen) {
        _lb_salemen = [[UILabel alloc] init];
        _lb_salemen.textColor = UIColorFromRGB(0x333333);
        _lb_salemen.textAlignment = NSTextAlignmentLeft;
        _lb_salemen.font = LSYUIFont(13);
        [self addSubview:_lb_salemen];
    }
    
    if (!_lb_orderMan) {
        _lb_orderMan = [[UILabel alloc] init];
        _lb_orderMan.textColor = UIColorFromRGB(0x333333);
        _lb_orderMan.textAlignment = NSTextAlignmentLeft;
        _lb_orderMan.font = LSYUIFont(13);
        [self addSubview:_lb_orderMan];
    }
    
    line = [[UILabel alloc] init];
    line.backgroundColor = LineColor;
    [self addSubview:line];
}

-(void)layoutSubviews {
    _lb_orderNumber.frame = CGRectMake(mergin_left, 10, self.frame.size.width-2*mergin_left, 20);
    line.frame = CGRectMake(0, CGRectGetMaxY(_lb_orderNumber.frame)+10, self.frame.size.width, 1);
    _lb_custom.frame = CGRectMake(mergin_left, CGRectGetMaxY(line.frame)+5, (self.frame.size.width-2*mergin_left)/2, 20);
    _lb_phone.frame = CGRectMake(CGRectGetMaxX(_lb_custom.frame), CGRectGetMaxY(line.frame)+5, (self.frame.size.width-2*mergin_left)/2, 20);
    _lb_address.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_custom.frame)+5, self.frame.size.width-2*mergin_left, 20);
    _lb_salemen.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_address.frame)+5, (self.frame.size.width-2*mergin_left)/2, 20);
    _lb_orderMan.frame = CGRectMake(CGRectGetMaxX(_lb_salemen.frame), CGRectGetMaxY(_lb_address.frame)+5, (self.frame.size.width-2*mergin_left)/2, 20);
}

@end
