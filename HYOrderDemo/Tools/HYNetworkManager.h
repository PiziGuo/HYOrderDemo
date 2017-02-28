//
//  HYNetwork.h
//  HYiTong
//
//  Created by David on 2016/12/6.
//  Copyright © 2016年 com.HROCLoud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+AXNetworkingMethods.h"


typedef NS_ENUM(NSUInteger, HYRequestType) {
    HYRequestTypeGET = 0,
    HYRequestTypePOST
};


#define WEB_BASE_URL @"https://www.hyitong.com:554/api/"



@interface HYNetworkManager : NSObject

+ (instancetype)shareManager;

/**
 判断显示网络加载框
 */
@property (nonatomic, assign, getter=isShowHUD) BOOL showHUD;

#pragma mark - webAPI方式创建网络请求
/**
 发送get请求 - webAPI方式创建网络请求

 @param URLString 请求的网址字符串
 @param parameters 请求的参数
 @param signArray 生成sign的数组
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)GETWithURLString:(NSString *)URLString
              parameters:(id)parameters
               signArray:(NSArray *)signArray
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;

- (void)GETWithURLString:(NSString *)URLString
              parameters:(id)parameters
               signArray:(NSArray *)signArray
                 success:(void (^)(id response))success
                 failure:(void (^)(NSError *error))failure;


/**
 发送post请求 - webAPI方式创建网络请求
 
 @param URLString 请求的网址字符串
 @param parameters 请求的参数
 @param signArray 生成sign的数组
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POSTWithURLString:(NSString *)URLString
               parameters:(id)parameters
                signArray:(NSArray *)signArray
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

- (void)POSTWithURLString:(NSString *)URLString
               parameters:(id)parameters
                signArray:(NSArray *)signArray
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure;

/**
 发送网络请求
 
 @param URLString 请求的网址字符串
 @param parameters 请求的参数
 @param signArray 生成sign的数组
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)RequestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                   signArray:(NSArray *)signArray
                        type:(HYRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

- (void)RequestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                   signArray:(NSArray *)signArray
                        type:(HYRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure;


@end
