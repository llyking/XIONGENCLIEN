//
//  ChangePhotoViewController.h
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "PublicViewController.h"

@interface ChangePhotoViewController : PublicViewController

@property (nonatomic,copy) void (^changeImageBlock)(UIImage *img);

@end
