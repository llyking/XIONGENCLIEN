//
//  OrderStatusModel.h
//  XIONGEN
//
//  Created by Ios on 2018/1/26.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderStatusModel : NSObject

@property (nonatomic,copy) NSString *create_date;
@property (nonatomic,copy) NSString *order_num;
@property (nonatomic,assign) int order_status;//0：待确认 1：已确认 2：待发货 3：已发货 4：确定收货 5：已收货 6：已驳回

@end
