//
//  OrderDetailModel.h
//  XIONGEN
//
//  Created by Ios on 2018/1/26.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property (nonatomic,copy) NSString *orderNumber;
@property (nonatomic,copy) NSString *logistNumber;
@property (nonatomic,copy) NSString *logisticName;
@property (nonatomic,copy) NSString *contact;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *salesman;
@property (nonatomic,copy) NSString *orderName;
@property (nonatomic,assign) int fid;
@property (nonatomic,strong) NSMutableArray *goods;
@property (nonatomic,strong) NSMutableArray *stutas;

@end
