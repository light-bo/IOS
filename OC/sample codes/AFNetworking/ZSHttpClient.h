//
//  ZSHttpClient.h
//  YiniuE-Commerce
//
//  Created by 张帅 on 14-10-16.
//  Copyright (c) 2014年 zs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//HTTP REQUEST METHOD TYPE
typedef NS_ENUM(NSInteger, ZSHttpRequestType) {
    ZSHttpRequestGet,
    ZSHttpRequestPost,
    ZSHttpRequestDelete,
    ZSHttpRequestPut,
};

/**
 *  请求开始前预处理Block
 */
typedef void(^PrepareExecuteBlock)(void);

/*********** ZSHttpClient ***********/
@interface ZSHttpClient : NSObject

+ (ZSHttpClient *)defaultClient;

/**
 *  HTTP请求（GET、POST、DELETE、PUT）
 *  @param path
 *  @param method      RESTFul请求类型
 *  @param parameters  请求参数
 *  @param prepare     请求前预处理块
 *  @param success     请求成功处理块
 *  @param failure     请求失败处理块
 */

//NSURLSessoin，iOS7.0之后
- (void)requestWithPath:(NSString *)url method:(NSInteger)method parameters:(id)parameters prepareExecute:(PrepareExecuteBlock)prepare success:(void(^)(NSURLSessionDataTask *task,id responseObject))success failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;

//NSURLConnection
- (void)connectionRequestWithPath:(NSString *)url method:(NSInteger)method parameters:(id)parameters prepareExecute:(PrepareExecuteBlock)prepare success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  HTTP请求（HEAD）
 
 *  @param path
 *  @param parameters
 *  @param success
 *  @param failure
 */
- (void)requestWithPathInHEAD:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
