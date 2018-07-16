//
//  ReciveAdressCell.m
//  XIONGENCLIEN
//
//  Created by Ios on 2018/3/21.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "ReciveAdressCell.h"



@implementation ReciveAdressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUIView];
    }
    return self;
}

-(void)createUIView {
    
    _line = [[UILabel alloc] init];
    _line.backgroundColor = LineColor;
    [self.contentView addSubview:_line];
    
    if (!_img_select) {
        _img_select = [[UIImageView alloc] init];
        _img_select.image = [UIImage imageWithContentsOfFile:ImagePath(@"choose_nor@2x")];
        [self.contentView addSubview:_img_select];
    }
    
    if (!_lb_name) {
        _lb_name = [[UILabel alloc] init];
        _lb_name.textColor = UIColorFromRGB(0x333333);
        _lb_name.textAlignment = NSTextAlignmentLeft;
        _lb_name.font = LSYUIFont(15);
        [self.contentView addSubview:_lb_name];
    }
    
    if (!_lb_phone) {
        _lb_phone = [[UILabel alloc] init];
        _lb_phone.textColor = UIColorFromRGB(0x333333);
        _lb_phone.textAlignment = NSTextAlignmentLeft;
        _lb_phone.font = LSYUIFont(15);
        [self.contentView addSubview:_lb_phone];
    }
    
    if (!_lb_adress) {
        _lb_adress = [[UILabel alloc] init];
        _lb_adress.textColor = UIColorFromRGB(0x333333);
        _lb_adress.textAlignment = NSTextAlignmentLeft;
        _lb_adress.font = LSYUIFont(15);
        [self.contentView addSubview:_lb_adress];
    }
    
    if (!_lb_form) {
        _lb_form = [[UILabel alloc] init];
        _lb_form.textColor = UIColorFromRGB(0x333333);
        _lb_form.textAlignment = NSTextAlignmentLeft;
        _lb_form.font = LSYUIFont(15);
        [self.contentView addSubview:_lb_form];
    }
    
    if (!_lb_loginform) {
        _lb_loginform = [[UILabel alloc] init];
        _lb_loginform.textColor = UIColorFromRGB(0x333333);
        _lb_loginform.textAlignment = NSTextAlignmentLeft;
        _lb_loginform.font = LSYUIFont(15);
        _lb_loginform.hidden = YES;
        [self.contentView addSubview:_lb_loginform];
    }
    
    if (!_lb_logincompany) {
        _lb_logincompany = [[UILabel alloc] init];
        _lb_logincompany.textColor = UIColorFromRGB(0x333333);
        _lb_logincompany.textAlignment = NSTextAlignmentLeft;
        _lb_logincompany.font = LSYUIFont(15);
        _lb_logincompany.hidden = YES;
        [self.contentView addSubview:_lb_logincompany];
    }
}

-(void)layoutSubviews {
    
    _line.frame = CGRectMake(0, self.frame.size.height-1, kScreenWidth, 1);
    
    _img_select.frame = CGRectMake(mergin_left, self.frame.size.height/2-16, 32, 32);
    _lb_name.frame = CGRectMake(CGRectGetMaxX(_img_select.frame)+10, 5, (self.frame.size.width-2*mergin_left-42)/2, 20);
    _lb_phone.frame = CGRectMake(CGRectGetMaxX(_lb_name.frame), 5, (self.frame.size.width-2*mergin_left-42)/2, 20);
    _lb_adress.frame = CGRectMake(CGRectGetMaxX(_img_select.frame)+10, CGRectGetMaxY(_lb_name.frame)+5, self.frame.size.width-2*mergin_left-42, 20);
    _lb_form.frame = CGRectMake(CGRectGetMaxX(_img_select.frame)+10, CGRectGetMaxY(_lb_adress.frame)+5, (self.frame.size.width-2*mergin_left-42)/2, 20);
    _lb_loginform.frame = CGRectMake(CGRectGetMaxX(_lb_form.frame), CGRectGetMaxY(_lb_adress.frame)+5, (self.frame.size.width-2*mergin_left-42)/2, 20);
    _lb_logincompany.frame = CGRectMake(CGRectGetMaxX(_img_select.frame)+10, CGRectGetMaxY(_lb_form.frame)+5, self.frame.size.width-2*mergin_left-42, 20);
}

-(void)setReAdMo:(ReciveAdressModel *)reAdMo {
    
    _reAdMo = reAdMo;
    _lb_name.text = [NSString stringWithFormat:@"收货人：%@",reAdMo.contact];
    _lb_phone.text = [NSString stringWithFormat:@"电话：%@",reAdMo.phone];
    _lb_adress.text = [NSString stringWithFormat:@"地址：%@",reAdMo.address];
    _lb_form.text = [NSString stringWithFormat:@"配送方式：%@",reAdMo.form];
    
    if (reAdMo.logisCompany) {
        _lb_loginform.hidden = NO;
        _lb_loginform.text = [NSString stringWithFormat:@"运输方式：%@",reAdMo.logisForm];
    } else {
        _lb_loginform.hidden = YES;
    }
    
    if (reAdMo.logisCompany) {
        _lb_logincompany.hidden = NO;
        _lb_logincompany.text = [NSString stringWithFormat:@"物流公司：%@",reAdMo.logisCompany];
    } else {
        _lb_logincompany.hidden = YES;
    }
}


@end
