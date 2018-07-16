//
//  XE_HomeMainView.h
//  XIONGEN
//
//  Created by Ios on 2018/1/17.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XE_HomeMainView : UIView

@property (nonatomic,strong) NSArray *btnTypeArr;
@property (nonatomic,assign) XERoleType type;

/**
 *  按钮事件
 */
@property (nonatomic ,copy) void(^xeHomeHeadViewBtnCallBack)(XEBtnType type);

-(instancetype)initWithFrame:(CGRect)frame; //withType:(NSInteger)type;



@end
