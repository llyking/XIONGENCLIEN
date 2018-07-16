//
//  XE_HomeMiddleView.h
//  XIONGEN
//
//  Created by Ios on 2018/1/17.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XE_HomeMiddleView : UIView

@property (nonatomic,strong) NSArray *dataArray;

-(void)reloadViewWithData:(NSArray *)array;

@end
