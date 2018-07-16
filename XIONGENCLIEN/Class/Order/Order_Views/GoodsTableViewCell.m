//
//  GoodsTableViewCell.m
//  XIONGEN
//
//  Created by Ios on 2018/1/25.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "GoodsTableViewCell.h"

@interface GoodsTableViewCell ()
{
    UIButton *btn1;
    UIButton *btn2;
}

@property (nonatomic,strong) UILabel *lb_name;//名称
@property (nonatomic,strong) UILabel *lb_oecode;//oe
@property (nonatomic,strong) UILabel *lb_code;//编码
@property (nonatomic,strong) UILabel *lb_origin;//产地
@property (nonatomic,strong) UILabel *lb_brand;//品牌
@property (nonatomic,strong) UILabel *lb_model_car;//车型
@property (nonatomic,strong) UILabel *lb_price;//价格
@property (nonatomic,strong) UILabel *lb_count;//数量

@property (nonatomic,strong) UIView *view_number;
@property (nonatomic,strong) UILabel *lb_number;

@end

@implementation GoodsTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUIView];
    }
    return self;
}

-(void)createUIView {
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
        [_lb_oecode setFont:LSYUIFont(13)];
        [_lb_oecode setTextColor:UIColorFromRGB(0x666666)];
        [_lb_oecode setTextAlignment:NSTextAlignmentLeft];
        [_lb_oecode setText:@"OE:"];
        [self.contentView addSubview:_lb_oecode];
    }
    
    if (!_lb_code) {
        _lb_code = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_code setFont:LSYUIFont(13)];
        [_lb_code setTextColor:UIColorFromRGB(0x666666)];
        [_lb_code setTextAlignment:NSTextAlignmentLeft];
        [_lb_code setText:@"编码:"];
        [self.contentView addSubview:_lb_code];
    }
    
    if (!_lb_origin) {
        _lb_origin = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_origin setFont:LSYUIFont(13)];
        [_lb_origin setTextColor:UIColorFromRGB(0x666666)];
        [_lb_origin setTextAlignment:NSTextAlignmentLeft];
        [_lb_origin setText:@"产地:"];
        [self.contentView addSubview:_lb_origin];
    }
    
    if (!_lb_brand) {
        _lb_brand = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_brand setFont:LSYUIFont(13)];
        [_lb_brand setTextColor:UIColorFromRGB(0x666666)];
        [_lb_brand setTextAlignment:NSTextAlignmentLeft];
        [_lb_brand setText:@"品牌:"];
        [self.contentView addSubview:_lb_brand];
    }
    
    if (!_view_number) {
        _view_number = [[UIView alloc] initWithFrame:CGRectZero];
        _view_number.backgroundColor = WhiteColor;
        [self.contentView addSubview:_view_number];
    }
    
    btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn1.layer.cornerRadius = 25/2;
    btn1.titleLabel.font = LSYUIFont(20);
    btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn1.layer.borderWidth = 1.0f;
    btn1.layer.borderColor = ThemeColor.CGColor;
    [btn1 setTitleColor:UIColorFromRGB(0x666666) forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(CountIncreaseToreduce:) forControlEvents:(UIControlEventTouchUpInside)];
    btn1.tag = 1000;
    btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [btn1 setTitle:@"-" forState:(UIControlStateNormal)];
    [_view_number addSubview:btn1];
    
    
    if (!_lb_number) {
        _lb_number = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_number setFont:LSYUIFont(15)];
        [_lb_number setTextColor:UIColorFromRGB(0x666666)];
        [_lb_number setTextAlignment:NSTextAlignmentCenter];
        [_lb_number setText:@"0"];
        _lb_number.layer.borderColor = ThemeColor.CGColor;
        _lb_number.layer.borderWidth = 1.0f;
        [_view_number addSubview:_lb_number];
    }
    
    btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [btn2 setTitleColor:UIColorFromRGB(0x666666) forState:(UIControlStateNormal)];
    btn2.tag = 1001;
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    btn2.layer.cornerRadius = 25/2;
    btn2.titleLabel.font = LSYUIFont(20);
    btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn2.layer.borderWidth = 1.0f;
    btn2.layer.borderColor = ThemeColor.CGColor;
    [btn2 addTarget:self action:@selector(CountIncreaseToreduce:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 setTitle:@"+" forState:(UIControlStateNormal)];
    [_view_number addSubview:btn2];
    
    if (!_lb_model_car) {
        _lb_model_car = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_model_car setFont:LSYUIFont(13)];
        [_lb_model_car setTextColor:UIColorFromRGB(0x666666)];
        [_lb_model_car setTextAlignment:NSTextAlignmentLeft];
        [_lb_model_car setText:@"车型:"];
        _lb_model_car.numberOfLines = 0;
        [self.contentView addSubview:_lb_model_car];
    }
    
    if (!_lb_count) {
        _lb_count = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_count setFont:LSYUIFont(13)];
        [_lb_count setTextColor:UIColorFromRGB(0x666666)];
        [_lb_count setTextAlignment:NSTextAlignmentLeft];
        [_lb_count setText:@"可售数:"];
        [self.contentView addSubview:_lb_count];
    }
    
    if (!_lb_price) {
        _lb_price = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_price setFont:LSYUIFont(13)];
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
    
    _lb_brand.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_origin.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 30);
    
    _view_number.frame = CGRectMake(CGRectGetMaxX(_lb_brand.frame)+10, CGRectGetMaxY(_lb_origin.frame)+5, 110, 30);
    btn1.frame = CGRectMake(0, 2.5 , 25, 25);
    _lb_number.frame = CGRectMake(35, 0, _view_number.frame.size.width - 30*2-10, 30);
    btn2.frame = CGRectMake(_view_number.frame.size.width - 25, 2.5, 25, 25);
    
    NSString *text;
    if (_goods.modelname.length) {
        text = [NSString stringWithFormat:@"车型：%@",_goods.modelname];
    } else if (_goods.engine.length) {
        text = [NSString stringWithFormat:@"车型：%@",_goods.engine];
    } else {
        text = [NSString stringWithFormat:@"车型：%@",_goods.gearbox];
    }
    CGSize size = [self getSizeWithFont:13 andText:text andFload:20];
    
    _lb_model_car.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_brand.frame)+10, self.frame.size.width-2*mergin_left, (size.height<20?20:size.height));
    
    _lb_count.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_model_car.frame)+10, (self.frame.size.width-2*mergin_left-10)/2, 20);
    _lb_price.frame = CGRectMake(CGRectGetMaxX(_lb_count.frame)+10, CGRectGetMaxY(_lb_model_car.frame)+10, (self.frame.size.width-2*mergin_left-10)/2, 20);
}

-(void)setGoods:(GoodsModel *)goods {
    _goods = goods;
    [_lb_name setText:goods.name];
    [_lb_oecode setText:[NSString stringWithFormat:@"OE:%@",goods.code]];
    [_lb_code setText:[NSString stringWithFormat:@"编码:%@",goods.brcode]];
    [_lb_brand setText:[NSString stringWithFormat:@"品牌:%@",goods.brandname]];
    [_lb_origin setText:[NSString stringWithFormat:@"产地:%@",goods.originname]];
    [_lb_number setText:[NSString stringWithFormat:@"%d",goods.count]];
    [_lb_count setText:[NSString stringWithFormat:@"可售数:%d",goods.amount]];
    [_lb_price setText:[NSString stringWithFormat:@"单价:%.2f",goods.price]];
    
    if (goods.modelname.length) {
        _lb_model_car.text = [NSString stringWithFormat:@"车型：%@",goods.modelname];
    } else if (goods.engine.length) {
        _lb_model_car.text = [NSString stringWithFormat:@"车型：%@",goods.engine];
    } else {
        _lb_model_car.text = [NSString stringWithFormat:@"车型：%@",goods.gearbox];
    }
    
}

//数量.增加。减少
-(void)CountIncreaseToreduce:(UIButton *)btn{
    
    if (btn.tag == 1000) {//减少
        
        NSInteger count = [self.lb_number.text integerValue];
        count--;
        if (count < 0) {
            return;
        }
        self.lb_number.text = [NSString stringWithFormat:@"%ld", count];
        if (self.CutBlock) {
            self.CutBlock(self.lb_number);
        }
    }else{//增加
        
        NSInteger count = [self.lb_number.text integerValue];
        count++;
        self.lb_number.text = [NSString stringWithFormat:@"%ld", count];
        if (self.AddBlock) {
            self.AddBlock(self.lb_number);
        }
    }
    
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
