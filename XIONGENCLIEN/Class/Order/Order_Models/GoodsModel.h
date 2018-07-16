//
//  GoodsModel.h
//  XIONGEN
//
//  Created by Ios on 2018/1/25.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property (nonatomic,copy) NSString *car;
@property (nonatomic,copy) NSString *brcode;//编码
@property (nonatomic,copy) NSString *modelname;
@property (nonatomic,copy) NSString *engine;
@property (nonatomic,copy) NSString *gearbox;
@property (nonatomic,copy) NSString *posName;
@property (nonatomic,copy) NSString *wareName;

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *code;//OE
@property (nonatomic,copy) NSString *brandname;
@property (nonatomic,copy) NSString *originname;
@property (nonatomic,assign) int amount;//数量
@property (nonatomic,assign) int count;
@property (nonatomic,assign) int fid;
@property (nonatomic,assign) float price;


@property (nonatomic,copy) NSString *unitname;
@property (nonatomic,assign) int stockId;


@end
