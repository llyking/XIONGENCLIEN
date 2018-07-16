//
//  Drop_downButton.h
//  XIONGEN
//
//  Created by Ios on 2018/1/19.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Drop_downButton : UIButton

@property (nonatomic,strong) UILabel *lb_title;
@property (nonatomic,strong) UIImageView *img_dropdown;

@property (nonatomic,copy) void(^DropDownChooseTitle)(BOOL isSelect);

@end
