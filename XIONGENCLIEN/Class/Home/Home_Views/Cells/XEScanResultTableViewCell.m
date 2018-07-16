//
//  XEScanResultTableViewCell.m
//  XIONGEN
//
//  Created by Ios on 2018/1/22.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XEScanResultTableViewCell.h"

@interface XEScanResultTableViewCell ()

@property (nonatomic,strong) UILabel *lb_name;
@property (nonatomic,strong) UILabel *lb_code;
@property (nonatomic,strong) UILabel *lb_origin;
@property (nonatomic,strong) UILabel *lb_factory_board;
@property (nonatomic,strong) UILabel *lb_model_car;
@property (nonatomic,strong) UILabel *lb_position;
@property (nonatomic,strong) UILabel *lb_inventory;


@end

@implementation XEScanResultTableViewCell


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
        [_lb_name setFont:LSYUIFont(15)];
        [_lb_name setTextColor:UIColorFromRGB(0x333333)];
        [_lb_name setTextAlignment:NSTextAlignmentLeft];
        [_lb_name setText:@"前杠拖车盖"];
        [self.contentView addSubview:_lb_name];
    }
    
    if (!_lb_code) {
        _lb_code = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_code setFont:LSYUIFont(13)];
        [_lb_code setTextColor:UIColorFromRGB(0x666666)];
        [_lb_code setTextAlignment:NSTextAlignmentLeft];
        [_lb_code setText:@"编码:"];
        [self.contentView addSubview:_lb_code];
    }
    
    if (!_lb_position) {
        _lb_position = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_position setFont:LSYUIFont(13)];
        [_lb_position setTextColor:UIColorFromRGB(0x666666)];
        [_lb_position setTextAlignment:NSTextAlignmentLeft];
        [_lb_position setText:@"仓位:"];
        [self.contentView addSubview:_lb_position];
    }
    
    if (!_lb_origin) {
        _lb_origin = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_origin setFont:LSYUIFont(13)];
        [_lb_origin setTextColor:UIColorFromRGB(0x666666)];
        [_lb_origin setTextAlignment:NSTextAlignmentLeft];
        [_lb_origin setText:@"产地:"];
        [self.contentView addSubview:_lb_origin];
    }
    
    if (!_lb_factory_board) {
        _lb_factory_board = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_factory_board setFont:LSYUIFont(13)];
        [_lb_factory_board setTextColor:UIColorFromRGB(0x666666)];
        [_lb_factory_board setTextAlignment:NSTextAlignmentLeft];
        [_lb_factory_board setText:@"厂牌:"];
        [self.contentView addSubview:_lb_factory_board];
    }
    
    if (!_lb_model_car) {
        _lb_model_car = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_model_car setFont:LSYUIFont(13)];
        [_lb_model_car setTextColor:UIColorFromRGB(0x666666)];
        [_lb_model_car setTextAlignment:NSTextAlignmentLeft];
        [_lb_model_car setText:@"车型:"];
        [self.contentView addSubview:_lb_model_car];
    }
    
    if (!_lb_inventory) {
        _lb_inventory = [[UILabel alloc] initWithFrame:CGRectZero];
        [_lb_inventory setFont:LSYUIFont(13)];
        [_lb_inventory setTextColor:UIColorFromRGB(0x666666)];
        [_lb_inventory setTextAlignment:NSTextAlignmentLeft];
        [_lb_inventory setText:@"数量:"];
        [self.contentView addSubview:_lb_inventory];
    }
   
}


-(void)layoutSubviews {
    _lb_name.frame = CGRectMake(mergin_left, 10, self.frame.size.width-2*mergin_left-10, 20);
    
    _lb_code.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_name.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 20);
    _lb_inventory.frame = CGRectMake(CGRectGetMaxX(_lb_code.frame)+10, CGRectGetMaxY(_lb_name.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 20);
    
    _lb_origin.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_code.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 20);
    _lb_factory_board.frame = CGRectMake(CGRectGetMaxX(_lb_origin.frame)+10, CGRectGetMaxY(_lb_code.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 20);
    
    _lb_model_car.frame = CGRectMake(mergin_left, CGRectGetMaxY(_lb_origin.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 20);
    _lb_position.frame = CGRectMake(CGRectGetMaxX(_lb_model_car.frame)+10, CGRectGetMaxY(_lb_origin.frame)+5, (self.frame.size.width-2*mergin_left-10)/2, 20);
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
