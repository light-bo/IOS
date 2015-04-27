//
//  ZSHttpClient.m
//  YiniuE-Commerce
//
//  Created by 张帅 on 14-10-16.
//  Copyright (c) 2014年 zs. All rights reserved.
//

#import "ZSHttpClient.h"
#import "RTJSONResponseSerializerWithData.h"

@interface ZSHttpClient()<UIAlertViewDelegate>
{
    UIAlertView *_alertView;
}

@property(nonatomic,strong) AFHTTPSessionManager *manager;
@property(nonatomic,strong) AFHTTPRequestOperationManager *operationManager;

@end

@implementation ZSHttpClient

- (id)init{
    if (self = [super init]){
        if (iOS7_VERSIONS_LATTER) {
            self.manager = [AFHTTPSessionManager manager];
            //请求参数序列化类型
            self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
            //响应结果序列化类型
            self.manager.responseSerializer = [RTJSONResponseSerializerWithData serializer];
            //接受内容类型
            self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"application/json", nil];
            
        }
        else{
            self.operationManager = [AFHTTPRequestOperationManager manager];
            self.operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
            self.operationManager.responseSerializer = [RTJSONResponseSerializerWithData serializer];
            self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"application/json", nil];
        }
    }
    return self;
}

+ (ZSHttpClient *)defaultClient
{
    static ZSHttpClient *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

//1.iOS7.0，NSURLSession
- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters prepareExecute:(PrepareExecuteBlock)prepareExecute
                success:(void (^)(NSURLSessionDataTask *, id))success
                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    //请求的URL
//    DLog(@"Request path:%@",url);
    
    //判断网络状况（有链接：执行请求；无链接：弹出提示）
    if ([self isConnectionAvailable]) {
        //预处理（显示加载信息啥的）
        if (prepareExecute) {
            prepareExecute();
        }
        switch (method) {
                
            case ZSHttpRequestGet:
            {
                [self.manager GET:url parameters:parameters success:success failure:failure];
            }
                break;
            case ZSHttpRequestPost:
            {
                [self.manager POST:url parameters:parameters success:success failure:failure];
            }
                break;
            case ZSHttpRequestDelete:
            {
                [self.manager DELETE:url parameters:parameters success:success failure:failure];
            }
                break;
            case ZSHttpRequestPut:
            {
                [self.manager PUT:url parameters:parameters success:success failure:false];
            }
                break;
            default:
                break;
        }
    }else{
        //网络错误
//        [self showExceptionDialog];
        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:@"k_NOTI_NETWORK_ERROR" object:nil];
    }
}

//2.NSURLConnection
- (void)connectionRequestWithPath:(NSString *)url method:(NSInteger)method parameters:(id)parameters prepareExecute:(PrepareExecuteBlock)prepareExecute success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    //判断网络状况（有链接：执行请求；无链接：弹出提示）
    if ([self isConnectionAvailable]) {
        //预处理（显示加载信息啥的）
        if (prepareExecute) {
            prepareExecute();
        }
        switch (method) {
            case ZSHttpRequestGet:
            {
                [self.operationManager GET:url parameters:parameters success:success failure:failure];
            }
                break;
            case ZSHttpRequestPost:
            {
                [self.operationManager POST:url parameters:parameters success:success failure:failure];
            }
                break;
            case ZSHttpRequestDelete:
            {
                [self.operationManager DELETE:url parameters:parameters success:success failure:failure];
            }
                break;
            case ZSHttpRequestPut:
            {
                [self.operationManager PUT:url parameters:parameters success:success failure:failure];
            }
                break;
            default:
                break;
        }
    }else{
        //网络错误咯
//        [self showExceptionDialog];
        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:@"k_NOTI_NETWORK_ERROR" object:nil];
    }
}


- (void)requestWithPathInHEAD:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if ([self isConnectionAvailable]) {
        [self.manager HEAD:url parameters:parameters success:success failure:failure];
    }else{
        [self showExceptionDialog];
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
        DLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

//弹出网络错误提示框
- (void)showExceptionDialog
{
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                           message:@"网络异常，请检查网络连接"
                                          delegate:nil
                                 cancelButtonTitle:@"好的"
                                 otherButtonTitles:nil, nil];
    [_alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
//        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        alertView.hidden = YES;
    }
}

@end
