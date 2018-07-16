//
//  FollowOrderDetailViewC.h
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "PublicViewController.h"

@interface FollowOrderDetailViewC : PublicViewController

@property (nonatomic,copy) NSString *orderNum;

-(void)loadViewWithOrderNum:(NSString *)order;

@end
