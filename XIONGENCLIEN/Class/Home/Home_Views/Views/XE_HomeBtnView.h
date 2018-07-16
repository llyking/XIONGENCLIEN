//
//  XE_HomeBtnView.h
//  XIONGEN
//
//  Created by Ios on 2018/1/18.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XE_HomeBtnView : UIView

/**
 *  按钮事件
 */
@property (nonatomic,copy) void(^xeHomeBtnCallBack)(XEBtnType type);

-(void)reloadViewWithData:(NSArray *)array;

@end
