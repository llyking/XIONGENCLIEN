//
//  TimeManager.h
//  XIONGEN
//
//  Created by Ios on 2018/1/24.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TimeManager : NSObject

//获取当前的时间:年月日
+(NSString*)getCurrentTimesDate;
//获取当前的时间:年月日 时分
+(NSString*)getCurrentTimesDateHourMinute;
//获取当前的时间:年月日 时分秒
+(NSString*)getCurrentTimesDateHourMinuteSecond;
//比较两个日期大小
+(int)compareDate:(NSString*)startDate withDate:(NSString*)endDate;
//比较两个日期大小
+(NSInteger)compare:(NSDate *)startTime to:(NSDate *)endTime;

@end
