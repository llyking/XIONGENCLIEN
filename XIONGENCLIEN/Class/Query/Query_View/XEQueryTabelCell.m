//
//  XEQueryTabelCell.m
//  XIONGEN
//
//  Created by Ios on 2018/1/18.
//  Copyright © 2018年 Ios. All rights reserved.
//


#define mergin_top 5

#import "XEQueryTabelCell.h"

@interface XEQueryTabelCell ()

@property (nonatomic,strong) UILabel *lb_name;
@property (nonatomic,strong) UILabel *lb_code;
@property (nonatomic,strong) UILabel *lb_oecode;
@property (nonatomic,strong) UILabel *lb_origin;
@property (nonatomic,strong) UILabel *lb_brand;
@property (nonatomic,strong) UILabel *lb_model_car;
@property (nonatomic,strong) UILabel *lb_count;
@property (nonatomic,strong) UILabel *lb_price;

@end

@implementation XEQueryTabelCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI {
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor = LineColor;
    [self.contentView addSubview:line];
    
    if (!_lb_name) {
        _lb_name = [[UILabel alloc] initWithFrame:CGRectZero];
        _lb_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [_lb_name setTextColor:UIColorFromRGB(0x333333)];
        [_lb_name setTextAlignment:NSTextAlignmentLeft];
        [_lb_name setText:@"前杠拖车盖"];
        [self.contentView addSubview:_lb_name];
    }
    
    if (!_lb_oecode) {
        _lb_oecode = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_oecode setFont:LSYUIFont(15)];
        [_lb_oecode setTextColor:UIColorFromRGB(0x666666)];
        [_lb_oecode setTextAlignment:NSTextAlignmentLeft];
        [_lb_oecode setText:@"OE:"];
        [self.contentView addSubview:_lb_oecode];
    }
    
    if (!_lb_code) {
        _lb_code = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_code setFont:LSYUIFont(15)];
        [_lb_code setTextColor:UIColorFromRGB(0x666666)];
        [_lb_code setTextAlignment:NSTextAlignmentLeft];
        [_lb_code setText:@"编码:"];
        [self.contentView addSubview:_lb_code];
    }
    
    if (!_lb_origin) {
        _lb_origin = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_origin setFont:LSYUIFont(15)];
        [_lb_origin setTextColor:UIColorFromRGB(0x666666)];
        [_lb_origin setTextAlignment:NSTextAlignmentLeft];
        [_lb_origin setText:@"产地:"];
        [self.contentView addSubview:_lb_origin];
    }
    
    if (!_lb_brand) {
        _lb_brand = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_brand setFont:LSYUIFont(15)];
        [_lb_brand setTextColor:UIColorFromRGB(0x666666)];
        [_lb_brand setTextAlignment:NSTextAlignmentLeft];
        [_lb_brand setText:@"品牌:"];
        [self.contentView addSubview:_lb_brand];
    }
    
    if (!_lb_model_car) {
        _lb_model_car = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_model_car setFont:LSYUIFont(15)];
        [_lb_model_car setTextColor:UIColorFromRGB(0x666666)];
        [_lb_model_car setTextAlignment:NSTextAlignmentLeft];
        [_lb_model_car setText:@"车型:"];
        _lb_model_car.numberOfLines = 0;
        [self.contentView addSubview:_lb_model_car];
    }
    
    if (!_lb_count) {
        _lb_count = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_count setFont:LSYUIFont(15)];
        [_lb_count setTextColor:UIColorFromRGB(0x666666)];
        [_lb_count setTextAlignment:NSTextAlignmentLeft];
        [_lb_count setText:@"可售数:"];
        [self.contentView addSubview:_lb_count];
    }
    
    if (!_lb_price) {
        _lb_price = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_price setFont:LSYUIFont(15)];
        [_lb_price setTextColor:ThemeColor];
        [_lb_price setTextAlignment:NSTextAlignmentLeft];
        [_lb_price setText:@"单价:"];
        [self.contentView addSubview:_lb_price];
    }
    
}


-(void)layoutSubviews {
    _lb_name.frame = CGRectMake(mergin_left, 10, (self.frame.size.width-2*mergin_left-10)/2, 20);
    _lb_oecode.frame = CGRectMake(CGRectGetMaxX(_lb_name.frame)+10, 10, (self.frame.size.width-2*mergin_left-10)/2, 20);
    
    
    _lb_origin.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_name.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 20);
    _lb_code.frame = CGRectMake(CGRectGetMaxX(_lb_origin.frame)+10, CGRectGetMaxY(_lb_name.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 20);
    
    
    _lb_brand.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_origin.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 20);
    
    
    NSString *text;
    if (_good.modelname.length) {
        text = [NSString stringWithFormat:@"车型：%@",_good.modelname];
    } else if (_good.engine.length) {
        text = [NSString stringWithFormat:@"车型：%@",_good.engine];
    } else {
        text = [NSString stringWithFormat:@"车型：%@",_good.gearbox];
    }
    CGSize size = [self getSizeWithFont:15 andText:text andFload:20];
    
    _lb_model_car.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_brand.frame)+5, self.frame.size.width-2*mergin_left, (size.height<20?20:size.height));
    
    _lb_count.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_model_car.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 20);
    _lb_price.frame = CGRectMake(CGRectGetMaxX(_lb_count.frame)+10, CGRectGetMaxY(_lb_model_car.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 20);
   
}

-(void)setGood:(GoodsModel *)good {
    _good = good;
    _lb_name.text = good.name;
    _lb_oecode.text = [NSString stringWithFormat:@"OE：%@",good.code];
    _lb_code.text = [NSString stringWithFormat:@"编码：%@",good.brcode];
    _lb_origin.text = [NSString stringWithFormat:@"产地：%@",good.originname];
    _lb_brand.text = [NSString stringWithFormat:@"品牌：%@",good.brandname];
    if (good.modelname.length) {
        _lb_model_car.text = [NSString stringWithFormat:@"车型：%@",good.modelname];
    } else if (good.engine.length) {
        _lb_model_car.text = [NSString stringWithFormat:@"车型：%@",good.engine];
    } else {
        _lb_model_car.text = [NSString stringWithFormat:@"车型：%@",good.gearbox];
    }
    _lb_count.text = [NSString stringWithFormat:@"可售数：%d",good.amount];
    _lb_price.text = [NSString stringWithFormat:@"单价：%.1f",good.price];
}

#pragma mark -- 根据文字获取高度（高度自适应）
-(CGSize)getSizeWithFont:(CGFloat)font  andText:(NSString *)tex andFload:(CGFloat)w{
    
    CGSize size = CGSizeMake(kScreenWidth - w, MAXFLOAT);
    UIFont *fnt = [UIFont systemFontOfSize:font];
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:fnt, NSFontAttributeName,nil];
    size =[tex boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    return size;
}


@end
