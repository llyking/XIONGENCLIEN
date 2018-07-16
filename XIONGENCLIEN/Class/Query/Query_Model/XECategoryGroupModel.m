//
//  XECategoryGroupModel.m
//  XIONGEN
//
//  Created by Ios on 2018/1/19.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XECategoryGroupModel.h"

@implementation XECategoryGroupModel

-(instancetype)init {
    self = [super init];
    if (self) {
        self.category = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
