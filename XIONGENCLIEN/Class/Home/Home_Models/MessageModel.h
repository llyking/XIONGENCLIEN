//
//  MessageModel.h
//  XIONGEN
//
//  Created by Ios on 2018/1/22.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,assign) int type;

@end
