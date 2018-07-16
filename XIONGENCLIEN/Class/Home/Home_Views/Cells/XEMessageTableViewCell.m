//
//  XEMessageTableViewCell.m
//  XIONGEN
//
//  Created by Ios on 2018/1/22.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XEMessageTableViewCell.h"

@interface XEMessageTableViewCell ()

@property (nonatomic,strong) UILabel *lb_date;
@property (nonatomic,strong) UILabel *lb_conten;
@property (nonatomic,strong) UIImageView *img_conten;
@property (nonatomic,strong) UIView *view_bg;

@end

@implementation XEMessageTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createuiview];
    }
    return self;
}

-(void)createuiview {
    _lb_date = [[UILabel alloc] init];
    _lb_date.textColor = UIColorFromRGB(0x333333);
    _lb_date.textAlignment = NSTextAlignmentCenter;
    _lb_date.font = LSYUIFont(15);
    [self.contentView addSubview:_lb_date];
    
    _view_bg = [[UIView alloc] init];
    _view_bg.backgroundColor = WhiteColor;
    _view_bg.layer.cornerRadius = 4;
    _view_bg.layer.masksToBounds = YES;
    _view_bg.layer.borderColor = LineColor.CGColor;
    _view_bg.layer.borderWidth = 1.0f;
    [self.contentView addSubview:_view_bg];
    
    _lb_conten = [[UILabel alloc] init];
    _lb_conten.textColor = UIColorFromRGB(0x333333);
    _lb_conten.textAlignment = NSTextAlignmentCenter;
    _lb_conten.font = LSYUIFont(15);
    _lb_conten.hidden = YES;
    [_view_bg addSubview:_lb_conten];
    
    _img_conten = [[UIImageView alloc] init];
    _img_conten.hidden = YES;
    _img_conten.backgroundColor = [UIColor redColor];
    [_view_bg addSubview:_img_conten];
}

-(void)setMessageM:(MessageModel *)messageM {
    _messageM = messageM;
    _lb_date.text = messageM.date;
    _lb_date.frame = CGRectMake(0, 10, kScreenWidth, 20);
    if (_messageM.type) {
        _lb_conten.hidden = NO;
        _img_conten.hidden = YES;
        _lb_conten.text = _messageM.message;
        
        CGSize size = [self getSizeHightWithFont:15 andText:_messageM.message andFload:kScreenWidth-4*mergin_left];
        _lb_conten.frame = CGRectMake(mergin_left, 5, kScreenWidth-2*mergin_left-100, size.height<20?20:size.height);
        _view_bg.frame = CGRectMake(50, CGRectGetMaxY(_lb_date.frame)+10, kScreenWidth-100, _lb_conten.frame.size.height+10);
        
    } else {
        _lb_conten.hidden = YES;
        _img_conten.hidden = NO;
        _img_conten.image = [UIImage imageNamed:_messageM.image];
        _img_conten.frame = CGRectMake((kScreenWidth-220)/2, 5, 120, 80);
        _view_bg.frame = CGRectMake(50, CGRectGetMaxY(_lb_date.frame)+10, kScreenWidth-100, _img_conten.frame.size.height+10);
    }
}

#pragma mark -- 根据文字获取宽度（高度度自适应）
-(CGSize)getSizeHightWithFont:(CGFloat)font  andText:(NSString *)tex andFload:(CGFloat)w{
    
    CGSize size = CGSizeMake(w, MAXFLOAT);
    UIFont *fnt = [UIFont systemFontOfSize:font];
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:fnt, NSFontAttributeName,nil];
    size =[tex boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    return size;
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
