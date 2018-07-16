//
//  ReciveAdressViewController.h
//  XIONGENCLIEN
//
//  Created by Ios on 2018/3/21.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "PublicViewController.h"
#import "ReciveAdressModel.h"

@interface ReciveAdressViewController : PublicViewController

@property (nonatomic,copy) void (^adressBlock)(ReciveAdressModel *model);

@end
