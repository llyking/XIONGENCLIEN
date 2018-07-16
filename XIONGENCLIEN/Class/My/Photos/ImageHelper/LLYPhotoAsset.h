//
//  LLYPhotoAsset.h
//  TianCi
//
//  Created by Ios on 2018/1/5.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface LLYPhotoAsset : NSObject

- (UIImage *)OriginalImage:(PHAsset *)asset;

- (UIImage *)smallImageSize:(CGSize)size asset:(PHAsset *)asset;

@end
