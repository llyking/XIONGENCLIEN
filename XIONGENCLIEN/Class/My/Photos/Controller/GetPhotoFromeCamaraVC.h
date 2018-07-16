//
//  GetPhotoFromeCamaraVC.h
//  TianCi
//
//  Created by Ios on 2018/1/5.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "PublicViewController.h"

@protocol GetPhotoFromeCamaraVCDelegate <NSObject>

@optional
- (void)getImagesArray:(NSArray<UIImage *>*)imagesArray;

@required

@end

@interface GetPhotoFromeCamaraVC : PublicViewController

@property (nonatomic, assign) id<GetPhotoFromeCamaraVCDelegate>  delegate;
@property (nonatomic, assign) BOOL isSingle;

@end
