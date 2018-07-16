//
//  FollowGoodsTableViewCell.m
//  XIONGEN
//
//  Created by Ios on 2018/1/26.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "FollowGoodsTableViewCell.h"

@interface FollowGoodsTableViewCell ()

@property (nonatomic,strong) UILabel *lb_name;//名称
@property (nonatomic,strong) UILabel *lb_code;//编码
@property (nonatomic,strong) UILabel *lb_origin;//产地
@property (nonatomic,strong) UILabel *lb_brand;//厂牌
@property (nonatomic,strong) UILabel *lb_model_car;//车型
@property (nonatomic,strong) UILabel *lb_count;//数量


@end

@implementation FollowGoodsTableViewCell

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
        _lb_name = [[UILabel alloc] init];
        _lb_name.frame = CGRectMake(mergin_left, 10, (kScreenWidth-2*mergin_left)/2, 20);
        _lb_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];;
        [_lb_name setTextColor:UIColorFromRGB(0x333333)];
        [_lb_name setTextAlignment:NSTextAlignmentLeft];
        [_lb_name setText:@"前杠拖车盖"];
        [self.contentView addSubview:_lb_name];
    }
    
    if (!_lb_code) {
        _lb_code = [[UILabel alloc] init];
        _lb_code.frame = CGRectMake(CGRectGetMaxX(_lb_name.frame), 10, (kScreenWidth-2*mergin_left)/2, 20);
        [_lb_code setFont:LSYUIFont(15)];
        [_lb_code setTextColor:UIColorFromRGB(0x666666)];
        [_lb_code setTextAlignment:NSTextAlignmentLeft];
        [_lb_code setText:@"编码:"];
        [self.contentView addSubview:_lb_code];
    }
    
    if (!_lb_origin) {
        _lb_origin = [[UILabel alloc] init];
        _lb_origin.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_name.frame)+5, (kScreenWidth-2*mergin_left)/2, 20);
        [_lb_origin setFont:LSYUIFont(15)];
        [_lb_origin setTextColor:UIColorFromRGB(0x666666)];
        [_lb_origin setTextAlignment:NSTextAlignmentLeft];
        [_lb_origin setText:@"产地:"];
        [self.contentView addSubview:_lb_origin];
    }
    
    if (!_lb_brand) {
        _lb_brand = [[UILabel alloc] init];
        _lb_brand.frame = CGRectMake(CGRectGetMaxX(_lb_origin.frame), CGRectGetMaxY(_lb_name.frame)+5, (kScreenWidth-2*mergin_left)/2, 20);
        [_lb_brand setFont:LSYUIFont(15)];
        [_lb_brand setTextColor:UIColorFromRGB(0x666666)];
        [_lb_brand setTextAlignment:NSTextAlignmentLeft];
        [_lb_brand setText:@"品牌:"];
        [self.contentView addSubview:_lb_brand];
    }
    
    if (!_lb_model_car) {
        _lb_model_car = [[UILabel alloc] init];
        _lb_model_car.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_origin.frame)+5, kScreenWidth-2*mergin_left, 20);
        [_lb_model_car setFont:LSYUIFont(15)];
        [_lb_model_car setTextColor:UIColorFromRGB(0x666666)];
        [_lb_model_car setTextAlignment:NSTextAlignmentLeft];
        [_lb_model_car setText:@"车型:"];
        [self.contentView addSubview:_lb_model_car];
    }
    if (!_lb_count) {
        _lb_count = [[UILabel alloc] init];
        _lb_count.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_model_car.frame)+5, kScreenWidth-2*mergin_left, 20);
        [_lb_count setFont:LSYUIFont(15)];
        [_lb_count setTextColor:UIColorFromRGB(0x666666)];
        [_lb_count setTextAlignment:NSTextAlignmentLeft];
        [_lb_count setText:@"数量:"];
        [self.contentView addSubview:_lb_count];
    }
    
}


-(void)setGm:(GoodsModel *)gm {
    _gm = gm;
    [_lb_name setText:_gm.name];
    [_lb_code setText:[NSString stringWithFormat:@"编码:%@",_gm.code]];
    [_lb_origin setText:[NSString stringWithFormat:@"产地:%@",_gm.originname]];
    [_lb_brand setText:[NSString stringWithFormat:@"品牌:%@",_gm.brandname]];
    [_lb_model_car setText:[NSString stringWithFormat:@"车型:%@",_gm.modelname]];
    [_lb_count setText:[NSString stringWithFormat:@"数量:%d",_gm.count]];
}


@end
