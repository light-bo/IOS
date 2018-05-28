//
//  LPAPPInfo.h
//  TRUntility
//
//  Created by Paramida-Di on 16/6/16.
//  Copyright © 2016年 Paramida-Di. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PdAppConfigInfoModel.h"

typedef NS_ENUM(NSInteger, PdNetworkEnvType) {
    PdNetworkEnvTypeLocal, //38 环境
    PdNetworkEnvTypePre, //预发环境（外部测试）
    PdNetworkEnvTypeProduct, //正式环境
    PdNetworkEnvTypePreDev, //开发环境
    PdNetworkEnvTypeAlpha //测试环境（内部测试）
};


@interface PdAppConfigInfoManager : NSObject


+ (instancetype _Nullable )shareInstance;

- (void)configAppInfo;

@property (nonnull, nonatomic, strong, readonly) NSString *appkey; //app id
@property (nonnull, nonatomic, strong, readonly) NSString *appv; //接入 SDK 的 app 版本信息 如：1.0.0
@property (nonnull, nonatomic, strong, readonly) NSString *sdkv; //SDK 或者 Loopin 版本号
@property (nonnull, nonatomic, strong, readonly) NSString *country; //在包里边配置的国家代码
@property (nonnull, nonatomic, strong, readonly) NSString *channelid; //发行渠道 ID 用于统计那个平台帮忙推广到的客户


/**
 服务器配置信息
 */
@property (nullable, nonatomic, strong) PdAppConfigInfoModel *serverConfigInfo;

/**
 Bugly 监控开关
 */
@property (nonatomic, assign, readonly) BOOL shouldOpenBugly;

/**
 appsee 监控开关
 */
@property (nonatomic, assign, readonly)  BOOL shouldOpenAppsee;

/**
 网络环境
 */
@property (nonatomic, assign, readonly) PdNetworkEnvType networkEnvType;

/**
 IM app key
 */
@property (nonatomic, copy, readonly) NSString * _Nonnull imAppKey;


/**
 IM 推送证书
 */
@property (nonatomic, copy, nonnull) NSString *certificateName;

@end
