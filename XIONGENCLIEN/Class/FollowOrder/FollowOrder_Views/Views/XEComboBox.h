//
//  XEComboBox.h
//  XIONGEN
//
//  Created by Ios on 2018/1/20.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XEComboBox : UIView


@property (nonatomic,copy) void(^XEFollowOrderStatusBack)(NSString *type);


+(instancetype)shareXEComboBox;
-(void)initXEComboBoxWithDataArray:(NSArray *)dataArray andFrame:(CGRect)frame isAnimation:(BOOL)isAnimation;

//-(void)show;
//-(void)hide;

@end
