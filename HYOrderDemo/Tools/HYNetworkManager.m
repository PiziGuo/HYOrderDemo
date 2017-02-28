//
//  HYNetwork.m
//  HYiTong
//
//  Created by David on 2016/12/6.
//  Copyright © 2016年 com.HROCLoud. All rights reserved.
//

#import "HYNetworkManager.h"
#import "AFNetworking.h"
//lib
#import "MBProgressHUD.h"



@implementation HYNetworkManager


NSString * GetSignStringFromSignArray(NSArray *signArray);
NSString * GetTimeStringFromDate(NSDate *date);
NSDictionary *GenerateParamstersDictionaryWithSignArray(NSArray *signArray, NSDictionary *clientDict);


/**
 创建单例
 控制动画显示
 @return 单例
 */
+ (instancetype)shareManager {
    static HYNetworkManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}


#pragma mark - GET
+ (void)GETWithURLString:(NSString *)URLString
              parameters:(id)parameters
               signArray:(NSArray *)signArray
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 可以接受的类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 请求超时时间
//    manager.requestSerializer.timeoutInterval = 30;
    
    
    NSString *interface = [WEB_BASE_URL stringByAppendingString:URLString];
    NSLog(@"请求的最终链接---》%@",interface);
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    NSDictionary *parametersDictionary = GenerateParamstersDictionaryWithSignArray(signArray, parameters);
    [manager GET:interface parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            NSError *error;
            id responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            success(responseDictionary);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            failure(error);
        }
    }];
    
}


- (void)GETWithURLString:(NSString *)URLString
              parameters:(id)parameters
               signArray:(NSArray *)signArray
                 success:(void (^)(id respnse))success
                 failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *interface = [WEB_BASE_URL stringByAppendingString:URLString];
    
    if (self.isShowHUD) {
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    NSDictionary *parametersDictionary = GenerateParamstersDictionaryWithSignArray(signArray, parameters);
    
    [manager GET:interface parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (self.isShowHUD) {
                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            }
            NSError *error;
            id responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            success(responseDictionary);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            failure(error);
        }
    }];
    
}


#pragma mark - POST
+ (void)POSTWithURLString:(NSString *)URLString
               parameters:(id)parameters
                signArray:(NSArray *)signArray
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 完整的URL
    NSString *interface = [WEB_BASE_URL stringByAppendingString:URLString];
    NSDictionary *paramsDict = GenerateParamstersDictionaryWithSignArray(signArray, parameters);
    
//    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    [manager POST:interface parameters:paramsDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
//            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            NSError *error;
            id responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            success(responseDictionary);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)POSTWithURLString:(NSString *)URLString
               parameters:(id)parameters
                signArray:(NSArray *)signArray
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 完整的URL
    NSString *interface = [WEB_BASE_URL stringByAppendingString:URLString];
    NSDictionary *paramsDict = GenerateParamstersDictionaryWithSignArray(signArray, parameters);
    
    if (self.isShowHUD) {
//        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    [manager POST:interface parameters:paramsDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (self.isShowHUD) {
//               [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            }
            NSError *error;
            id responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            success(responseDictionary);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)RequestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                   signArray:(NSArray *)signArray
                        type:(HYRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    // 完整的URL
    NSString *interface = [WEB_BASE_URL stringByAppendingString:URLString];
    NSDictionary *parametersDictionary = GenerateParamstersDictionaryWithSignArray(signArray, parameters);
    
//    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    switch (type) {
            
        case HYRequestTypeGET:
        {
            [manager GET:interface parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
//                    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
            
        case HYRequestTypePOST:
        {
            [manager POST:interface parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
//                    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            
        }
            break;
    }
    
}


- (void)RequestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                   signArray:(NSArray *)signArray
                        type:(HYRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    // 完整的URL
    NSString *interface = [WEB_BASE_URL stringByAppendingString:URLString];
    NSDictionary *parametersDictionary = GenerateParamstersDictionaryWithSignArray(signArray, parameters);
    
    if (self.isShowHUD) {
//        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    
    
    switch (type) {
            
        case HYRequestTypeGET:
        {
            [manager GET:interface parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    if (self.isShowHUD) {
//                        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                    }
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
            
        case HYRequestTypePOST:
        {
            [manager POST:interface parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    if (self.isShowHUD) {
//                        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                    }
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            
        }
            break;
    }
    
}









#pragma mark - private method
/**
 获取时间戳

 @param date <#date description#>
 @return <#return value description#>
 */
NSString * GetTimeStringFromDate(NSDate *date){
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMdd"];
    NSString * dateString = [format stringFromDate:date];
    
    return dateString;
}

/**
 获取sign值

 @param signArray <#signArray description#>
 @return <#return value description#>
 */
NSString * GetSignStringFromSignArray(NSArray *signArray){
    
    NSString *signStr = [@"kc123456ts" mutableCopy];
    NSDate *date = [NSDate date];
    NSString *timeStr = GetTimeStringFromDate(date);
    signStr = [signStr stringByAppendingString:timeStr];
    // 根据array获取sign
    NSMutableString *signString = [@"" mutableCopy];
    for (int i = 0; i < signArray.count; i++) {
        if (i != 0) {
            [signString appendString:@""];
        }
        NSString *tmpStr = [NSString stringWithFormat:@"%@",signArray[i]];
        [signString appendString:tmpStr];
    }
    signStr = [signStr stringByAppendingString:signString];
    signStr = [signStr stringByAppendingString:@"kc123456"];
    signStr = [signStr AX_md5];
    signStr = [signStr uppercaseString];
    NSLog(@"signStr------>%@",signString);
    return signStr;
    
}

/**
 生成参数字典
 
 @param signArray <#signArray description#>
 @param clientDict <#clientDict description#>
 @return <#return value description#>
 */
+ (NSDictionary *)generateParamstersDictionaryWithSignArray:(NSArray *)signArray andClientDictionary:(NSDictionary *)clientDict{
    
    NSDictionary *parametersDictionary = [NSDictionary dictionary];
    if (clientDict == nil) {
        parametersDictionary = clientDict;
        return parametersDictionary;
    } else {
        // 获取时间戳
        NSDate *date = [NSDate date];
        NSString *timeStr = GetTimeStringFromDate(date);
        // 封装一个方法，获取sign
        NSString *signStr = GetSignStringFromSignArray(signArray);
        NSMutableDictionary *dictParams = [NSMutableDictionary dictionary];
        if (dictParams) {
            [dictParams addEntriesFromDictionary:clientDict];
        }
        [dictParams addEntriesFromDictionary:dictParams];
        [dictParams addEntriesFromDictionary:@{@"sign":signStr}];
        [dictParams addEntriesFromDictionary:@{@"ts":timeStr}];
        parametersDictionary = dictParams;
        return parametersDictionary;
    }
}

NSDictionary *GenerateParamstersDictionaryWithSignArray(NSArray *signArray, NSDictionary *clientDict) {
    
    NSDictionary *parametersDictionary = [NSDictionary dictionary];
    if (clientDict == nil) {
        parametersDictionary = clientDict;
        return parametersDictionary;
    } else {
        // 获取时间戳
        NSDate *date = [NSDate date];
        NSString *timeStr = GetTimeStringFromDate(date);
        // 封装一个方法，获取sign
        NSString *signStr = GetSignStringFromSignArray(signArray);
        NSMutableDictionary *dictParams = [NSMutableDictionary dictionary];
        if (dictParams) {
            [dictParams addEntriesFromDictionary:clientDict];
        }
        [dictParams addEntriesFromDictionary:dictParams];
        [dictParams addEntriesFromDictionary:@{@"sign":signStr}];
        [dictParams addEntriesFromDictionary:@{@"ts":timeStr}];
        parametersDictionary = dictParams;
        return parametersDictionary;
    }
}


@end
