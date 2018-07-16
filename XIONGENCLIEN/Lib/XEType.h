//
//  HKType.h
//  HKOnLine
//
//  Created by kermit on 16/8/22.
//  Copyright © 2016年 xuxiaolei. All rights reserved.
//

#ifndef XEType_h
#define XEType_h

typedef void(^HKNoParamsBlock)(void);

#pragma mark - 接口请求状态码定义

#pragma mark - 网络状态
typedef NS_ENUM(NSUInteger, HKNetworkType) {
    HKNetworkTypeNONE = 0,
    HKNetworkType2G   = 1,
    HKNetworkType3G   = 2,
    HKNetworkType4G   = 3,
    HKNetworkTypeWIFI = 5,
};


typedef NS_ENUM(NSUInteger,XERoleType) {
    XE_Role_Manager = 0,//管理
    XE_Role_Salesman = 1,//业务
    XE_Role_Buyer = 2,//采购
    XE_Role_Customer = 3,//客户
    XE_Role_Personnel = 4,//人事
    XE_Role_Stream = 5,//物流
};

//首页
typedef NS_ENUM(NSUInteger,XEBtnType) {
    XEHomeTopScanBtnType = 0,//扫一扫
    XEHomeTopMyBtnType = 1,//我的
    XEHomeMessageBtnType = 2,//消息
    XEHomeAddressBookBtnType = 3,//通讯录
    XEHomePendingBtnType = 4,//待审批
};

//跟单
typedef NS_ENUM(NSUInteger,XEFollowOrderBtnType) {
    XEFOAllType = 0,//全部
    XEFOProcurementType = 1,//采购
    XEFOPickUpType = 2,//提货
    XEOPWarehousingType = 3,//入库
    XEOPOutboundType = 4,//出库
    XEFOPackaging = 5,//打包
    XEFOLogisticsType = 6,//发物流
    XEFOShippingType = 7,//物流发货
    XEFOSignInType = 8,//客户签收
};

#define ImagePath(name) [[NSBundle mainBundle] pathForResource:name ofType:@"png"]
//用户ID
//#define USER_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]






#endif /* XEType_h */
