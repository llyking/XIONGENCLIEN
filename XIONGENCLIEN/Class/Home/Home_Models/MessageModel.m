//
//  MessageModel.m
//  XIONGEN
//
//  Created by Ios on 2018/1/22.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

-(instancetype)init {
    self = [super init];
    if (self) {
        self.message = @"";
        self.date = @"";
        self.image =@"";
    }
    return self;
}

@end
