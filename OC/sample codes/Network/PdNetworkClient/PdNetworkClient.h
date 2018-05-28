//
//  PdNetworkClient.h
//  Loopin
//
//  Created by light_bo on 2016/11/10.
//  Copyright © 2016年 Paramida-Di. All rights reserved.
//



#import <Foundation/Foundation.h>

@class UIImage;


typedef NS_ENUM(NSInteger, PdNetworkErrorCode) {
    PdNetworkErrorCodeTimeOut = -1001, //超时状态
    PdNetworkErrorCodeOffline = - 1009 //离线状态
};


typedef NS_ENUM(NSInteger, PdNetworkErrorType) {
    PdNetworkErrorTypeCustom,
    PdNetworkErrorTypeSystem,
    PdNetworkErrorTypeUploadMultipleImagesFail,//上传多张图片失败
    PdNetworkErrorTypeTimeOut //网络超时
};


typedef NS_ENUM(NSInteger, PdHttpRequestType) {
    PdHttpRequestTypeGet,
    PdHttpRequestTypePost,
    PdHttpRequestTypeDelete,
    PdHttpRequestTypePut
};


typedef NS_ENUM(NSInteger, PdNetworkReachabilityStatus) {
    PdNetworkReachabilityStatusUnknown          = -1,
    PdNetworkReachabilityStatusNotReachable     = 0,
    PdNetworkReachabilityStatusReachableViaWWAN = 1,
    PdNetworkReachabilityStatusReachableViaWiFi = 2,
};


typedef void(^PdNetworkSuccessBlock)(id responseObject);
typedef void(^PdNetworkFailBlock)(PdNetworkErrorType errorType, NSString *errorMsg);

typedef void (^AFSuccessBlock)(NSURLSessionTask *task, id responseObject);
typedef void (^AFFailureBlock)(NSURLSessionTask *task, NSError *error);


/**
 * download
 */
typedef void(^PdDownloadProgressBlock)(NSProgress *downloadProgress);
typedef NSURL *(^PdDownloadDestinationBlock)(NSURL *targetPath, NSURLResponse *response);
typedef void(^PdDownloadCompleteBlock)(NSURLResponse *response, NSURL *filePath, NSError *error);

/**
 * upload
 */
typedef void(^PdUploadProgressBlock)(NSProgress *uploadProgress);
typedef void(^PdUploadMultipleImagesSuccessBlock)(NSArray<NSString *> *imageURLs);


@interface PdNetworkClient : NSObject

+ (instancetype)defaultNetworkClient;

/**
 * H5 资源 URL
 */
@property (nonatomic, strong) NSString *webResourceURL;

@property (nonatomic, assign) NSInteger netWorkType;


/**
 *  uri 参数只需传入 path 如： /appConfig/global
 *  断网和网络超时对应的情况已经处理，调用该 api 不需要处理这两种情况
 */
- (void)executeRequestWithPath:(NSString *)path method:(PdHttpRequestType)method parameters:(id)parameters success:(PdNetworkSuccessBlock)successBlock failure:(PdNetworkFailBlock)failureBlock;

/**
 上传一张图片
 compressionQuality 参数已经被弃用，不再作用
 */
- (void)uploadImage:(UIImage *)image withCompressionQuality:(float)compressionQuality withParams:(NSDictionary *)parameters withProgressBlock:(PdUploadProgressBlock)uploadProgressBlock withSuccessBlock:(PdNetworkSuccessBlock)successBlock withFailBlock:(PdNetworkFailBlock)failBlock;


/**
 上传多张图片
 compressionQuality 参数已经被弃用，不再作用
 */
- (void)uploadMultipleImagesWithImages:(NSArray<UIImage *> *)images compressionQuality:(float)compressionQuality params:(NSDictionary *)parameters uploadProgressBlock:(PdUploadProgressBlock)uploadProgressBlock successBlock:(PdUploadMultipleImagesSuccessBlock)uploadSuccessBlcok failBlock:(PdNetworkFailBlock)failBlock;


/**
 * 简单地取消最后一个请求，暂时的解决方案
 */
- (void)cancelLastRequest;
- (void)cancelDownloadTask;
- (void)cancelAllUploadTasks;


/**
 重新登录
 */
- (void)requireToLogOn;
- (void)showNetworkTimeOutInfo;

/*
 上传参数
 */
+(NSURLSessionDownloadTask*)sendDownloadTaskWithRequest:(NSString *)url
                                               progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                            destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destinationBlock
                                      completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandlerBlock;
/**
 用户访问 token 是否失效
 */
@property (nonatomic, assign) BOOL isTokenInvalid;

/**
 如果想要拦截某个接口所有的网络错误信息，则可以将接口的 path 加入这个 list
 */
@property (nonatomic, strong) NSMutableSet<NSString *> *filtNetworkErrorBlankList;

/**
 如果某个接口需要单独处理超时(或者未联网)信息，则可以将这个接口的完整 url  或者 单独的 path 添加进这个 list
 */
@property (nonatomic, strong) NSMutableSet<NSString *> *shouldCustomHandleTimeOutList;




@end
