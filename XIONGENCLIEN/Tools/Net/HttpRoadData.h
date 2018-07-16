//
//  HttpRoadData.h
//  TianCi
//
//  Created by Ios on 17/3/30.
//  Copyright © 2017年 Ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRoadData : NSObject


+(void)NetworkMonitoring;

+ (void)postUpdateInfoInViewNo:(UIView *)view
              withVersionCode:(NSString *)path NSMutableDictionary:(id)param successBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))successBlock
                 failureBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))failureBlock;

+ (void)postDataInView:(UIView *)view withCone:(NSString *)path jsonString:(NSString *)jsonString completionBlock:(void(^)(NSURLResponse * response,id responseObject,NSError *error))completionBlock;


+ (void)GetAFNInfoInViewNo:(UIView *)view
           withVersionCode:(NSString *)path NSMutableDictionary:(id)param successBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))successBlock
              failureBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))failureBlock;
+ (NSDictionary *)POSTDictionaryContent:(NSString *)url ByPost:(NSString *)da;
+ (NSString*)UTF8String:(NSDictionary*)dic;

@end
