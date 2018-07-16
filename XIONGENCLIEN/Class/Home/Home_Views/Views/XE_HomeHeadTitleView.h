//
//  XE_HomeHeadTitleView.h
//  XIONGEN
//
//  Created by Ios on 2018/1/17.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XE_HomeHeadTitleView : UIView

@property (nonatomic,strong) UILabel *lb_title;
@property (nonatomic,strong) UIButton *btn_scan;
@property (nonatomic,strong) UIButton *btn_my;

/**
 *  按钮事件
 */
@property (nonatomic,copy) void(^xeHomeHeadViewBtnCallBack)(XEBtnType type);

@end
