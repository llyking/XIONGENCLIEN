//
//  HttpRoadData.m
//  TianCi
//
//  Created by Ios on 17/3/30.
//  Copyright © 2017年 Ios. All rights reserved.
//

#import "HttpRoadData.h"

@implementation HttpRoadData


#pragma mark - 网络判断
+(void)NetworkMonitoring
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:WhiteColor]; //字体颜色
    [SVProgressHUD setBackgroundColor:RGBACOLOR(0, 0, 0)];//背景颜色
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case -1:
            {
                NSLog(@"未知网络");
            }
                break;
                
            case 0:
            {
                 [SVProgressHUD showErrorWithStatus:@"断网 无连接"];
                NSLog(@"断网 无连接");
            }
                break;
                
            case 1:
            {
                NSLog(@"3G网络");
            }
                break;
                
            case 2:
            {
                NSLog(@"局域网络");
            }
                break;
                
            default:
                
                break;
        }
        
    }];
}

+ (void)postDataWithVersionCode:(NSString *)path NSMutableDictionary:(NSDictionary*)param successBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))successBlock
                   failureBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))failureBlock {
    
    //网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript",@"application/x-www-form-urlencoded",nil];
    
    [manager POST:path parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task,responseObject);
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(task,error);
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        }];
        
        
    }];
}

#pragma mark - 网络请求 -POST -----------------常用
+ (void)postUpdateInfoInViewNo:(UIView *)view
               withVersionCode:(NSString *)path NSMutableDictionary:(id)param successBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))successBlock
                  failureBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))failureBlock {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:WhiteColor]; //字体颜色
    [SVProgressHUD setBackgroundColor:RGBACOLOR(0, 0, 0)];//背景颜色
    //网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 1;
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"charset=utf-8",@"text/javascript",@"application/x-www-form-urlencoded",nil];
    
    [manager POST:path parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        successBlock(task,responseObject);
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(task,error);
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            if (error.code==-1001) {
                [SVProgressHUD showErrorWithStatus:@"网络请求超时"];
            }
            [SVProgressHUD dismiss];
        }];
        
    }];
}

+ (void)postDataInView:(UIView *)view withCone:(NSString *)path jsonString:(NSString *)jsonString completionBlock:(void(^)(NSURLResponse * response,id responseObject,NSError *error))completionBlock {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:WhiteColor]; //字体颜色
    [SVProgressHUD setBackgroundColor:RGBACOLOR(0, 0, 0)];//背景颜色
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:path parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        completionBlock(response,error,responseObject);
    }]
        resume
    ];
    
}

#pragma mark - 网络请求 -GET ---------------------使用
+ (void)GetAFNInfoInViewNo:(UIView *)view
           withVersionCode:(NSString *)path NSMutableDictionary:(id)param successBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))successBlock
              failureBlock:(void(^)(NSURLSessionDataTask * task, NSError * error))failureBlock
{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:WhiteColor]; //字体颜色
    [SVProgressHUD setBackgroundColor:RGBACOLOR(0, 0, 0)];//背景颜色
    [SVProgressHUD showWithStatus:@"数据加载中"];
    //网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 1;
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript",@"application/x-www-form-urlencoded",nil];
    
    [manager GET:path parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        successBlock(task,responseObject);
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
        
        NSLog(@"error:\n%@",error);
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            if (error.code==-1001) {
                [SVProgressHUD showErrorWithStatus:@"网络请求超时"];
            }
            [SVProgressHUD dismiss];
        }];
    }];
    
}

+ (NSDictionary *)POSTDictionaryContent:(NSString *)url ByPost:(NSString *)da{
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSData *data = [da dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [request setValue:@"Keep-Alive" forHTTPHeaderField:@"connection"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *error;
    NSDictionary *dic;
    if (response != nil) {
        dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    }
    return dic;
}


#pragma mark - 查看data数据
+(NSString*)UTF8String:(NSDictionary*)dic
{
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:nil];
    NSString* str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return str;
}



@end
