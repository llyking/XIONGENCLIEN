//
//  UserInfoModel.h
//  XIONGENCLIEN
//
//  Created by Ios on 2018/4/3.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic,copy) NSString *account;//账号
@property (nonatomic,copy) NSString *password;//密码
@property (nonatomic,copy) NSString *username;//用户名称
@property (nonatomic,copy) NSString *deptName;//部门
@property (nonatomic,copy) NSString *phone;//手机号
@property (nonatomic,copy) NSString *userTypeName;//用户类型
@property (nonatomic,copy) NSString *createdate;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *subarea;
@property (nonatomic,assign) int fid;
@property (nonatomic,assign) int type;//权限类型
@property (nonatomic,assign) int status;
@property (nonatomic,assign) int userId;//员工 或客户或。。的fid
@property (nonatomic,assign) int userTypeId;//用户类型id
@property (nonatomic,assign) int deptId;//部门id

@end
