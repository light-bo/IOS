//
//  LLSNetworkClient.m
//  EncapsulateAFNetworking
//
//  Created by 李旭波 on 15/9/14.
//  Copyright (c) 2015年 李旭波. All rights reserved.


#define iOS7_VERTION_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#import "LLSNetworkClient.h"
#import <netinet/in.h>

@implementation LLSNetworkClient

- (instancetype)init {
    self = [super init];
    if(self) {
        self.manager = [AFHTTPSessionManager manager];
        //请求参数序列化
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //响应参数序列化
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //接受内容类型
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"application/json", nil];
        
        self.operationManage = [AFHTTPRequestOperationManager manager];
        self.operationManage.requestSerializer = [AFJSONRequestSerializer serializer];
        self.operationManage.responseSerializer = [AFJSONResponseSerializer serializer];
        self.operationManage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"application/json", nil];
    }
    
    return self;
}


+ (LLSNetworkClient *)shareNetworkClient {
    static LLSNetworkClient *instance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    
    
    return instance;
}


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
                failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure {
    if([self isConnectionAvailable]) {
        if(prepare) prepare();
        switch (method) {
            case LLSNetworkRequestGet:
                [self.manager GET:url parameters:parameters success:success failure:failure];
                break;
                
            case LLSNetworkRequestPost:
                [self.manager GET:url parameters:parameters success:success failure:failure];
                break;
                
            default:
                break;
        }
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:k_NOTI_NETWORK_ERROR object:nil];
    }
}


//NSURLConnection
- (void)connectionRequestWithPath:(NSString *)url
                           method:(NSInteger)method
                       parameters:(id)parameters
                   prepareExecute:(PrepareExecuteBlock)prepare
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if([self isConnectionAvailable]) {
        if(prepare) prepare();
        switch (method) {
            case LLSNetworkRequestGet:
                [self.operationManage GET:url parameters:parameters success:success failure:failure];
                break;
                
                case LLSNetworkRequestPost:
                [self.operationManage POST:url parameters:parameters success:success failure:failure];
                break;
                
            default:
                break;
        }
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:k_NOTI_NETWORK_ERROR object:nil];
    }
}


//看看网络是不是给力
- (BOOL)isConnectionAvailable{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}


@end
