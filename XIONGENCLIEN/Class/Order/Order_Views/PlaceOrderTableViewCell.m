//
//  PlaceOrderTableViewCell.m
//  XIONGEN
//
//  Created by Ios on 2018/1/24.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "PlaceOrderTableViewCell.h"

@interface PlaceOrderTableViewCell ()

@property (nonatomic,strong) UILabel *lb_name;
@property (nonatomic,strong) UILabel *lb_code;
@property (nonatomic,strong) UILabel *lb_number;
@property (nonatomic,strong) UILabel *lb_price;
@property (nonatomic,strong) UILabel *lb_totalPrice;

@end

@implementation PlaceOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUIView];
    }
    return self;
}

-(void)createUIView {
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 0, kScreenWidth, 1);
    line.backgroundColor = LineColor;
    [self.contentView addSubview:line];
    
    if (!_lb_name) {
        _lb_name = [[UILabel alloc] init];
        _lb_name.textColor = UIColorFromRGB(0x333333);
        _lb_name.textAlignment = NSTextAlignmentLeft;
        _lb_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        _lb_name.text = @"水壶";
        [self.contentView addSubview:_lb_name];
    }
    
    if (!_lb_code) {
        _lb_code = [[UILabel alloc] init];
        _lb_code.textColor = UIColorFromRGB(0x333333);
        _lb_code.textAlignment = NSTextAlignmentRight;
        _lb_code.font = LSYUIFont(15);
        _lb_code.text = @"编码:123456789";
        [self.contentView addSubview:_lb_code];
    }
    
    if (!_lb_number) {
        _lb_number = [[UILabel alloc] init];
        _lb_number.textColor = UIColorFromRGB(0x333333);
        _lb_number.textAlignment = NSTextAlignmentLeft;
        _lb_number.font = LSYUIFont(15);
        _lb_number.text = @"数量:100";
        [self.contentView addSubview:_lb_number];
    }
    
    if (!_lb_price) {
        _lb_price = [[UILabel alloc] init];
        _lb_price.textColor = UIColorFromRGB(0x333333);
        _lb_price.textAlignment = NSTextAlignmentLeft;
        _lb_price.font = LSYUIFont(15);
        _lb_price.text = @"单价:250.00";
        [self.contentView addSubview:_lb_price];
    }
    
    if (!_lb_totalPrice) {
        _lb_totalPrice = [[UILabel alloc] init];
        _lb_totalPrice.textColor = ThemeColor;
        _lb_totalPrice.textAlignment = NSTextAlignmentRight;
        _lb_totalPrice.font = LSYUIFont(15);
        _lb_totalPrice.text = @"金额:25000.00";
        [self.contentView addSubview:_lb_totalPrice];
    }
}

-(void)layoutSubviews {
    _lb_name.frame = CGRectMake(mergin_left, 10, kScreenWidth-2*mergin_left, 20);
    _lb_code.frame = CGRectMake(mergin_left, 10, kScreenWidth-2*mergin_left, 20);
    _lb_number.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_name.frame)+10, (kScreenWidth-2*mergin_left-20)/3, 20);
    _lb_price.frame = CGRectMake(CGRectGetMaxX(_lb_number.frame)+10, CGRectGetMaxY(_lb_name.frame)+10, (kScreenWidth-2*mergin_left-20)/3, 20);
    _lb_totalPrice.frame = CGRectMake(CGRectGetMaxX(_lb_price.frame)+10, CGRectGetMaxY(_lb_name.frame)+10, (kScreenWidth-2*mergin_left-20)/3, 20);
}

-(void)setModel:(GoodsModel *)model {
    _model = model;
    _lb_name.text = model.name;
    _lb_code.text = [NSString stringWithFormat:@"编码:%@",model.code];
    _lb_number.text = [NSString stringWithFormat:@"数量:%d",model.count];;
    _lb_price.text = [NSString stringWithFormat:@"单价:%.2f",model.price];;
    _lb_totalPrice.text = [NSString stringWithFormat:@"总价:%.2f",model.count*model.price];;
}


@end
