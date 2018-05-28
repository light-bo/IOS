//
//  PdNetworkClient.m
//  Loopin
//
//  Created by light_bo on 2016/11/10.
//  Copyright © 2016年 Paramida-Di. All rights reserved.
//

#import "PdNetworkClient.h"
#import <AFNetworking/AFNetworking.h>
#import "PdNetworkUntlity.h"
#import "PdLoginViewController.h"
#import "PDKit.h"
#import "UIApplication+PDKit.h"
#import "UIView+Toast.h"
#import "PdAppConfigInfoManager.h"
#import "PdHostsInfoModel.h"
#import "PdLogInUserInfoManager.h"
#import "UIImage+Luban_iOS_Extension_h.h"


/**
 * 服务器
 */
//static NSString *kHost = @"http://api.icochat.com"; //正式环境
//static NSString *kHost = @"http://preapi.icochat.com"; //预发环境
//static NSString *kHost = @"http://192.168.1.38"; //测试环境
//static NSString *kHost = @"http://192.168.1.53"; //测试环境
//static NSString *kHost = @"http://im.paramida.net"; //IM 测试环境
 

/**.
 * h5 资源包下载地址
 */
//static NSString* kWebResourceUrl = @"http://static.icochat.com/dist.zip"; //正式环境
//static NSString *kWebResourceUrl = @"http://static.iloopin.com/dist.zip";//已废弃
//static NSString* kWebResourceUrl = @"http://preapi.icochat.com/dist.zip"; //预发环境
//static NSString *kWebResourceUrl  = @"http://192.168.1.38/dist.zip"; //测试环境
//static NSString *kWebResourceUrl  = @"http://im.paramida.net/dist.zip"; //测试环境

//网络分组
#define PD_NETWORK_MODULE_UC @"uc"
#define PD_NETWORK_MODULE_UPLOAD @"upload"
#define PD_NETWORK_MODULE_API @"api"
#define PD_NETWORK_MODULE_IM @"im"
#define PD_NETWORK_MODULE_MSG @"msg"
#define PD_NETWORK_MODULE_WWW @"www"


static NSString *kUploadFilePath = @"/upload/fileUpload/oss"; //上传文件 path

static const NSInteger kTokenInvidStatusCode = 30007;
static const NSInteger kDefaultTimeOutInterval = 25;
static const NSInteger kUploadTimeOutInterval = 25;


@interface PdNetworkClient ()

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@property (nonatomic, strong) NSURLSessionDataTask *lastDataRequestTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadRequestTask;
@property (nonatomic, strong) NSURLSessionDataTask *currentUploadImageTask;

@property (nonatomic, assign) AFNetworkReachabilityStatus lastNetworkType;

/**
 app 配置信息 host
 */
@property (nonatomic, copy) NSString *appConfigurationHost;


@property (nonatomic, strong) NSMutableArray<NSString *> *selectedImagesURL;

@property (nonatomic, strong) NSDictionary *hostsDic;

@property (nonatomic, strong) AFHTTPSessionManager *uploadSessionManager;

@end



@implementation PdNetworkClient


+ (instancetype)defaultNetworkClient {
    static PdNetworkClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PdNetworkClient alloc] init];
    });
    
    
    return instance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        [self configNetworkEnv];
        //data
        _httpSessionManager = [AFHTTPSessionManager manager];
        _httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _httpSessionManager.requestSerializer.timeoutInterval = kDefaultTimeOutInterval;
        _httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
        
        //upload
        _uploadSessionManager = [AFHTTPSessionManager manager];
        _uploadSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _uploadSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _uploadSessionManager.requestSerializer.timeoutInterval = kUploadTimeOutInterval;
        
        [self monitorNetworkStatus];
        
        _filtNetworkErrorBlankList = [NSMutableSet new];
        _shouldCustomHandleTimeOutList = [NSMutableSet new];
    }
    
    return self;
}


/**
 网络模块分组 hosts 表
 */
- (NSDictionary *)hostsDic {
    PdHostsInfoModel *hostsInfoModel = [PdAppConfigInfoManager shareInstance].serverConfigInfo.configHostInfoModel;
    _hostsDic = @{
                  PD_NETWORK_MODULE_UC: hostsInfoModel.userCenter? : _appConfigurationHost,
                  PD_NETWORK_MODULE_UPLOAD: hostsInfoModel.fileUpload? : _appConfigurationHost,
                  PD_NETWORK_MODULE_API: hostsInfoModel.api? : _appConfigurationHost,
                  PD_NETWORK_MODULE_IM: hostsInfoModel.im? : _appConfigurationHost,
                  PD_NETWORK_MODULE_MSG: hostsInfoModel.msg? : _appConfigurationHost,
                  PD_NETWORK_MODULE_WWW: hostsInfoModel.websize? : _appConfigurationHost
                  };

    return _hostsDic;
}

- (void)configNetworkEnv {
    PdNetworkEnvType networkEnv = [PdAppConfigInfoManager shareInstance].networkEnvType;
    if (PdNetworkEnvTypeLocal == networkEnv) {
        _appConfigurationHost = @"http://api.fam.co";//uc.fam.co
        _webResourceURL = @"http://api.fam.co/dist.zip";
    } else if (PdNetworkEnvTypePre == networkEnv) {
        _appConfigurationHost = @"http://beta.api.famlink.co";
        _webResourceURL = @"http://preapi.icochat.com/dist.zip";
    } else if(PdNetworkEnvTypePreDev == networkEnv) {
        _appConfigurationHost = @"http://dev.api.famlink.co";
        _webResourceURL = @"http://preapi.icochat.com/dist.zip";
    } else if (PdNetworkEnvTypeAlpha == networkEnv) {
        _appConfigurationHost = @"http://alpha.api.famlink.co";
    } else {
        _appConfigurationHost = @"http://api.famlink.co";
        _webResourceURL = @"http://api.icochat.com/dist.zip";
    }
}

- (void)monitorNetworkStatus {
    _netWorkType = AFNetworkReachabilityStatusReachableViaWiFi;
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        
        _netWorkType = status;
        
        //网络状态改变的时候， AF 会重复回调，这里的目的是去重
        if (_lastNetworkType != status) {
            [[NSNotificationCenter defaultCenter] postNotificationName:Pd_Network_Status_Changed_Notification object:[NSNumber numberWithInteger:status]];
        }
        
        _lastNetworkType = status;
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)executeRequestWithPath:(NSString *)path method:(PdHttpRequestType)method parameters:(id)parameters success:(PdNetworkSuccessBlock)successBlock failure:(PdNetworkFailBlock)failureBlock {
    
    if (![self isParametersValid:parameters]) {
        NSLog(@"parameters is error, please check your parameters!!!");
        return;
    }
    
    [self requestWithPath:path method:method parameters:parameters success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSLog(@"接口 url: %@", [self dispatchURL:path]);
        
        long status = [[responseObject objectForKey:@"status"] integerValue];
        if (0 == status) {
            NSLog(@"%@", [responseObject objectForKey:@"data"]);
            
            _isTokenInvalid = NO;
            successBlock([responseObject objectForKey:@"data"]);
        } else if(kTokenInvidStatusCode == status) {
            //token 失效，重新登录
            _isTokenInvalid = YES;
            [self requireToLogOn];
        } else {
            _isTokenInvalid = NO;
            NSLog(@"%@", [responseObject objectForKey:@"info"]);
            failureBlock(PdNetworkErrorTypeCustom, [responseObject objectForKey:@"info"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        _isTokenInvalid = NO;
        
        [task cancel];
        
        if ([self shouldFiltErrorInfo:path]) {
            return;
        }
        
        switch (error.code) {
            case PdNetworkErrorCodeOffline: {
                if ([self isShouldCustomHandleTimeOut:path]) {
                    failureBlock(PdNetworkErrorTypeTimeOut, nil);
                } else {
                    [self showNetworkUnavailableInfo];
                }
            }
                break;
                
            case PdNetworkErrorCodeTimeOut: {
                if ([self isShouldCustomHandleTimeOut:path]) {
                    //接口调用这个自己处理超时情况
                    failureBlock(PdNetworkErrorTypeTimeOut, nil);
                } else {
                    [self showNetworkTimeOutInfo];
                }
            }
                break;
                
            default: {
                failureBlock(PdNetworkErrorTypeSystem, error.localizedFailureReason);
            }
                break;
        }
    }];
}

- (void)requestWithPath:(NSString *)path method:(PdHttpRequestType)method parameters:(id)parameters success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure {
    NSString *entireUrl = [self dispatchURL:path];
    if (!entireUrl) {
        NSLog(@"url 中的 path 输入有问题!");
        return;
    }
    
    switch (method) {
        case PdHttpRequestTypeGet: {
            _lastDataRequestTask = [_httpSessionManager GET:entireUrl parameters:PARAMS(path, ADDBASE(parameters), @"get") progress:^(NSProgress * _Nonnull downloadProgress) {
                //
            } success:success failure:failure];
        }
            break;
        
        case PdHttpRequestTypePost: {
            _lastDataRequestTask = [_httpSessionManager POST:entireUrl parameters:PARAMS(path, ADDBASE(parameters), @"post") progress:^(NSProgress * _Nonnull uploadProgress) {
                //
            } success:success failure:failure];
        }
            break;
            
        case PdHttpRequestTypePut: {
            _lastDataRequestTask = [_httpSessionManager PUT:entireUrl parameters:PARAMS(path, ADDBASE(parameters), @"put")  success:success failure:failure];
        }
            break;
            
        case PdHttpRequestTypeDelete: {
            _lastDataRequestTask = [_httpSessionManager DELETE:entireUrl parameters:PARAMS(path, ADDBASE(parameters), @"delete")  success:success failure:failure];
        }
            break;
        default:
            break;
    }
}

- (BOOL)isParametersValid:(NSDictionary *)params {
    //如果参数包含 sid，而 sid 为空的话，则视为无效请求，直接丢弃
    if ([params isKindOfClass:[NSDictionary class]]) {
        NSDictionary *paramDic = params;
        if ([paramDic containsObjectForKey:@"sid"]) {
            NSString *sid = paramDic[@"sid"];
            if (sid.length <=0) {
                return NO;
            }
        }
    }
    
    return YES;
}


/**
 根据 path 找到对应 host，然后拼接出完整 url
 @return 完整 url
 */
- (NSString *)dispatchURL:(NSString *)path {
    if ((!path) || (path.length <= 0)) {
        return nil;
    }
    
    NSArray *pathComponents = [path componentsSeparatedByString:@"/"];
    if (pathComponents.count < 2) {
        return nil;
    }
    
    NSString *module = pathComponents[1];
    if (module.length <= 0) {
        return nil;
    }
    
    //app 配置接口，整个 app 第一个请求的接口， host 是固定不变的
    if ([module isEqualToString:@"appConfig"]) {
        return [NSString stringWithFormat:@"%@%@", _appConfigurationHost, path];
    }
    
    if (![[self hostsDic] containsObjectForKey:module]) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"%@%@", [self hostsDic][module], path];
}

- (void)cancelDownloadTask {
    [_downloadRequestTask cancel];
}

- (void)cancelLastRequest {
    [_lastDataRequestTask cancel];
}

- (void)cancelAllUploadTasks {
    for (NSURLSessionDataTask *uploadTask in _uploadSessionManager.uploadTasks) {
        [uploadTask cancel];
    }
}

#pragma mark - 图片上传
- (void)uploadMultipleImagesWithImages:(NSArray<UIImage *> *)images compressionQuality:(float)compressionQuality params:(NSDictionary *)parameters uploadProgressBlock:(PdUploadProgressBlock)uploadProgressBlock successBlock:(PdUploadMultipleImagesSuccessBlock)uploadSuccessBlcok failBlock:(PdNetworkFailBlock)failBlock {
    if ((!images) || (images.count <= 0)) {
        return;
    }
    
    _selectedImagesURL = [NSMutableArray new];

    for (int index = 0; index < images.count; ++index) {
        [_selectedImagesURL addObject:@""];
    }
    
    dispatch_group_t uploadImagesGroup = dispatch_group_create();
    
    for (UIImage *image in images) {
        dispatch_group_enter(uploadImagesGroup);
        dispatch_group_async(uploadImagesGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self uploadImage:image withCompressionQuality:compressionQuality withParams:nil withProgressBlock:^(NSProgress *uploadProgress) {
                if (uploadProgressBlock) {
                    uploadProgressBlock(uploadProgress);
                }
            } withSuccessBlock:^(id responseObject) {
                //保持图片的顺序是用户选择的顺序
                [_selectedImagesURL replaceObjectAtIndex:[images indexOfObject:image] withObject:responseObject];
                
                dispatch_group_leave(uploadImagesGroup);
            } withFailBlock:^(PdNetworkErrorType errorType, NSString *errorMsg) {
                if (failBlock) {
                    failBlock(errorType, errorMsg);
                }
                
                dispatch_group_leave(uploadImagesGroup);
            }];
        });
    }

    dispatch_group_notify(uploadImagesGroup, dispatch_get_main_queue(), ^{
        //图片没有全部上传上去，则图片上传操作失败
        if ([_selectedImagesURL containsObject:@""]) {
            NSLog(@"图片上传失败！！！");
            if (failBlock) {
                failBlock(PdNetworkErrorTypeUploadMultipleImagesFail, nil);
            }
            
            return;
        }
        
        if (uploadSuccessBlcok) {
            NSLog(@"全部图片上传成功");
            uploadSuccessBlcok(_selectedImagesURL);
        }
    });
}

- (void)uploadImage:(UIImage *)image withCompressionQuality:(float)compressionQuality withParams:(NSDictionary *)parameters withProgressBlock:(PdUploadProgressBlock)uploadProgressBlock withSuccessBlock:(PdNetworkSuccessBlock)successBlock withFailBlock:(PdNetworkFailBlock)failBlock {
    if (!image) {
        return;
    }

    NSData *imageData = [UIImage lubanCompressImage:image];
    
    NSString *imageMD5String = imageData.md5String;
    
    NSMutableDictionary *extraParameters = nil;
    if (parameters) {
        extraParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    } else {
        extraParameters = [NSMutableDictionary new];
    }
    
    [extraParameters setObject:imageMD5String forKey:@"md5"];
    
    
    NSMutableDictionary *resultParamDic = [PARAMS(kUploadFilePath, ADDBASE(extraParameters), @"post") mutableCopy];
    
    [resultParamDic setObject:imageMD5String forKey:@"md5"];
    
    NSString *uploadHost = [self hostsDic][PD_NETWORK_MODULE_UPLOAD];
    NSLog(@"upload url: %@", [NSString stringWithFormat:@"%@%@", uploadHost, kUploadFilePath]);
    
    _currentUploadImageTask = [_uploadSessionManager POST:[NSString stringWithFormat:@"%@%@", uploadHost, kUploadFilePath] parameters:resultParamDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"上传图片文件名:%@", [NSString stringWithFormat:@"%ficon.png", [[NSDate date] timeIntervalSince1970]] );
        [formData appendPartWithFileData:imageData name:@"ico_upload" fileName:[NSString stringWithFormat:@"%ficon.png", [[NSDate date] timeIntervalSince1970]] mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        uploadProgressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        long status = -1;
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            status = [[responseObject objectForKey:@"status"] integerValue];
            if (0 == status) {
                if ([responseObject containsObjectForKey:@"data"]) {
                    NSDictionary *dataDic = responseObject[@"data"];
                    
                    if ([dataDic containsObjectForKey:@"url"]) {
                        NSLog(@"image network server url: %@", dataDic[@"url"]);
                        successBlock(dataDic[@"url"]);
                        return;
                    }
                }
                
                successBlock(nil);
            } else {
                NSLog(@"upload image error info: %@",  [responseObject objectForKey:@"info"]);
                
                failBlock(PdNetworkErrorTypeCustom, [responseObject objectForKey:@"info"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        
        [task cancel];
        
        if (-1001 == error.code) {
            //网络超时
            failBlock(PdNetworkErrorTypeTimeOut, nil);
        } else {
            failBlock(PdNetworkErrorTypeSystem, error.localizedFailureReason);
        }
    }];
}


- (void)cancelCurrentImageUploadTask {
    [_currentUploadImageTask cancel];
}

#pragma mark - 重新登录
- (void)requireToLogOn {
    [self stopLoadingAnimation];
    PdLogInUserInfoModel *logInUserInfoModel = [[PdLogInUserInfoManager shareManager] logInUserInfoModel];
    if (logInUserInfoModel.sessionId) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIViewController *currentDisplayViewController = [appDelegate currentDisplayViewCcontroller];
        if (![currentDisplayViewController isKindOfClass:[PdLoginViewController class]]) {
            [currentDisplayViewController presentViewController:[PdLoginViewController new] animated:YES completion:^{
                [[UIApplication sharedApplication].keyWindow makeToast:LANGUAGE(@"loopin_login_again")];
                
                [[NIMSDK sharedSDK].loginManager logout:^(NSError * _Nullable error) {
                    if (error) {
                        NSLog(@"云信登出错误: %@", error);
                    }
                }];
            }];
        }
    }
}

- (void)showNetworkUnavailableInfo {
    [self stopLoadingAnimation];
    
    [SAMRateLimit executeBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication].keyWindow makeToast:LANGUAGE(@"network_is_not_available")];
        });
    } name:Pd_Show_Network_Unavailable_Info_Limit limit:2];
}


- (void)showNetworkTimeOutInfo {
    [self stopLoadingAnimation];
    
    [SAMRateLimit executeBlock:^{
        [[UIApplication sharedApplication].currentKeyBoardWindow makeToast:LANGUAGE(@"ico_network_time_out")];
    } name:Pd_Show_Time_Out_Info_Limit limit:5];
}

- (void)stopLoadingAnimation {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [MBProgressHUD hideAllHUDsForView:appDelegate.currentDisplayViewCcontroller.view animated:YES];
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].currentKeyBoardWindow animated:YES];
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

- (BOOL)shouldFiltErrorInfo:(NSString *)url {
    if ([_filtNetworkErrorBlankList containsObject:url]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isShouldCustomHandleTimeOut:(NSString *)url {
    if ([_shouldCustomHandleTimeOutList containsObject:url]) {
        return YES;
    }
    
    return NO;
}

+ (NSURLSessionDownloadTask*)sendDownloadTaskWithRequest:(NSString *)url
                                               progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                            destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destinationBlock
                                      completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandlerBlock {
    NSURL *URL = [NSURL URLWithString:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    
    
    return  [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        downloadProgressBlock(downloadProgress);
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return destinationBlock(targetPath,response);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        completionHandlerBlock(response,filePath,error);
        
    }];
}

@end
