//
//  ReciveAdressModel.h
//  XIONGENCLIEN
//
//  Created by Ios on 2018/3/21.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReciveAdressModel : NSObject

@property (nonatomic,copy) NSString *contact;//名字
@property (nonatomic,copy) NSString *phone;//电话
@property (nonatomic,copy) NSString *address;//地址
@property (nonatomic,copy) NSString *logisForm;//运输方式
@property (nonatomic,copy) NSString *logisCompany;//物流公司
@property (nonatomic,copy) NSString *form;//配送方式
@property (nonatomic,assign) int logisid;//物流公司id
@property (nonatomic,assign) int customerid;//客户id
@property (nonatomic,assign) int fid;//收货地址id


@end
