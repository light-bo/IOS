//
//  LPAPPInfo.m
//  TRUntility
//
//  Created by Paramida-Di on 16/6/16.
//  Copyright © 2016年 Paramida-Di. All rights reserved.
//

#import "PdAppConfigInfoManager.h"
#import "PdNetworkClient.h"

static NSString *kAppConfigInfoPath = @"/appConfig/global";


@interface PdAppConfigInfoManager()

@end


@implementation PdAppConfigInfoManager


+ (instancetype)shareInstance {
    static PdAppConfigInfoManager* appinfo = nil;
    static dispatch_once_t onceQueue;
    dispatch_once(&onceQueue, ^{
        appinfo = [[PdAppConfigInfoManager alloc] init];
    });
    
    return appinfo;
}

- (instancetype)init {
    if (self = [super init]) {
        //
    }
    
    return self;
}

- (void)configAppInfo{
    [self configPlistInfo];
    [self configIMAppKey];
    
    [self retriveServerConfigInfo];
}

- (void)retriveServerConfigInfo {
    [[PdNetworkClient defaultNetworkClient] executeRequestWithPath:kAppConfigInfoPath method:PdHttpRequestTypeGet parameters:nil success:^(id responseObject) {
        _serverConfigInfo = [PdAppConfigInfoModel modelWithJSON:responseObject];
    } failure:^(PdNetworkErrorType errorType, NSString *errorMsg) {
        NSLog(@"App 配置信息获取失败！！！！！");
    }];
}

- (void)configPlistInfo {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"AppConfiguration" ofType:@"plist"];
    
    NSDictionary *infoDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSLog(@"App config info: %@", infoDic);
    
    _appkey = [infoDic objectForKey:@"appkey"]; // 不多说 每个游戏都有appid
    _appv = [infoDic objectForKey:@"appv"];// 接入SDK 的app版本信息 如：1.0.0
    _sdkv = [infoDic objectForKey:@"sdkv"]; //SDK 或者Loopin 版本号
    _country = [infoDic objectForKey:@"country"]; // 在包里边配置的 国家代码
    _channelid = [infoDic objectForKey:@"channelid"]; //发行渠道ID 用于统计那个平台帮忙推广到的客户
    _shouldOpenBugly = [[infoDic objectForKey:@"bugly"] boolValue];
    _shouldOpenAppsee = [[infoDic objectForKey:@"appsee"] boolValue];
    
    //网络环境配置
    [self configNetworkEnvType:infoDic];
}

- (void)configNetworkEnvType:(NSDictionary *)infoDic {
    NSString *networkType = [infoDic objectForKey:@"appenv"];
    if ([networkType isEqualToString:@"local"]) {
        _networkEnvType = PdNetworkEnvTypeLocal;
    } else if ([networkType isEqualToString:@"pre"]) {
        _networkEnvType = PdNetworkEnvTypePre;
    } else if([networkType isEqualToString:@"dev"]) {
        _networkEnvType = PdNetworkEnvTypePreDev;
    } else if([networkType isEqualToString:@"alpha"]) {
        _networkEnvType = PdNetworkEnvTypeAlpha;
    } else {
        _networkEnvType = PdNetworkEnvTypeProduct;
    }
}

- (void)configIMAppKey {
    if (PdNetworkEnvTypeLocal == _networkEnvType) {
        _imAppKey = @"3e6dc9cb56fa513509b1e2d971dca33a";
    } else if (PdNetworkEnvTypePre == _networkEnvType) {
        _imAppKey = @"5ee00bf988c0e214f9b7f30ff23eaaee";
    } else {
        _imAppKey = @"5ee00bf988c0e214f9b7f30ff23eaaee";
    }
}

- (NSString *)certificateName {
    NSString *cerName = nil;
    
#ifdef DEBUG
    cerName = @"famlinkiosdev";
#else
    cerName = @"famlinkiosproduct";
#endif
    
    return cerName;
}

@end
