//
//  FollowOrderTableViewCell.m
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "FollowOrderTableViewCell.h"

@interface FollowOrderTableViewCell ()

@property (nonatomic,strong) UILabel *lb_order;
@property (nonatomic,strong) UILabel *lb_date;

@end

@implementation FollowOrderTableViewCell


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
    
    _lb_order = [[UILabel alloc] init];
    _lb_order.textColor = UIColorFromRGB(0x333333);
    _lb_order.textAlignment = NSTextAlignmentLeft;
    _lb_order.font = LSYUIFont(15);
    [self.contentView addSubview:_lb_order];
    
    _lb_date = [[UILabel alloc] init];
    _lb_date.textColor = UIColorFromRGB(0x999999);
    _lb_date.textAlignment = NSTextAlignmentLeft;
    _lb_date.font = LSYUIFont(13);
    [self.contentView addSubview:_lb_date];
    
    UIImageView *img = [[UIImageView alloc] init];
    img.frame = CGRectMake(kScreenWidth-mergin_right-8, 23, 8, 14);
    img.image = [UIImage imageNamed:@"my_icon_nexts@2x"];
    [self.contentView addSubview:img];
    
    _btn_orderType = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_orderType.frame = CGRectMake(CGRectGetMinX(img.frame)-95, 15, 80, 30);
    _btn_orderType.backgroundColor = ThemeColor;
    _btn_orderType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_btn_orderType setTitleColor:WhiteColor forState:UIControlStateNormal];
    _btn_orderType.titleLabel.font = LSYUIFont(13);
    _btn_orderType.layer.cornerRadius = 6;
    _btn_orderType.layer.masksToBounds = YES;
    [self.contentView addSubview:_btn_orderType];
}

-(void)layoutSubviews {
    
    _lb_order.text = [NSString stringWithFormat:@"订单号：%@",_statuM.order_num];
    _lb_date.text = [NSString stringWithFormat:@"下单日期：%@",_statuM.create_date];
    
    _lb_order.frame = CGRectMake(mergin_left, 10, 300, 20);
    _lb_date.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_order.frame)+5, 300, 15);
}






@end
