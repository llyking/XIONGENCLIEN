//
//  OrderDetailModel.m
//  XIONGEN
//
//  Created by Ios on 2018/1/26.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel

-(instancetype)init {
    if (self = [super init]) {
        _goods = [[NSMutableArray alloc] init];
        _stutas = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
