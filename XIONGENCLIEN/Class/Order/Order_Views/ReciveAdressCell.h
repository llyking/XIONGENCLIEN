//
//  ReciveAdressCell.h
//  XIONGENCLIEN
//
//  Created by Ios on 2018/3/21.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReciveAdressModel.h"

@interface ReciveAdressCell : UITableViewCell

@property (nonatomic,strong) ReciveAdressModel *reAdMo;
@property (nonatomic,strong) UILabel *line;
@property (nonatomic,strong) UIImageView *img_select;
@property (nonatomic,strong) UILabel *lb_name;
@property (nonatomic,strong) UILabel *lb_phone;
@property (nonatomic,strong) UILabel *lb_adress;
@property (nonatomic,strong) UILabel *lb_form;
@property (nonatomic,strong) UILabel *lb_loginform;
@property (nonatomic,strong) UILabel *lb_logincompany;

@end
