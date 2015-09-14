//
//  LLSNetworkClient.h
//  EncapsulateAFNetworking
//
//  Created by 李旭波 on 15/9/14.
//  Copyright (c) 2015年 李旭波. All rights reserved.
//

#define k_NOTI_NETWORK_ERROR @"networkRequestError"

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


//网络请求类型
typedef NS_ENUM(NSInteger, LLSNetworkRequestType) {
    LLSNetworkRequestGet,
    LLSNetworkRequestPost,
};

//请求开始前预处理 block
typedef  void(^PrepareExecuteBlock)(void);

//成功处理 block
typedef void(^SuccessBlock)(id data);


@interface LLSNetworkClient : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManage;

//网络请求单例
+ (LLSNetworkClient *)shareNetworkClient;


/**
 *  网络请求（GET、POST）
 *  @param path        请求路径
 *  @param method      请求类型
 *  @param parameters  请求参数
 *  @param prepare     请求前预处理块
 *  @param success     请求成功处理块
 *  @param failure     请求失败处理块
 */

//NSURLSessoin，iOS 7.0之后
- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
         prepareExecute:(PrepareExecuteBlock)prepare
                success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
                failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;


//NSURLConnection
- (void)connectionRequestWithPath:(NSString *)url
                           method:(NSInteger)method
                       parameters:(id)parameters
                   prepareExecute:(PrepareExecuteBlock)prepare
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//检查网络是否连通
- (BOOL)isConnectionAvailable;

@end
