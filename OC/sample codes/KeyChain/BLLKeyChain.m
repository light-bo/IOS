//
//  BRKeyChain.m
//  TestKeyChain
//
//  Created by 李旭波 on 16/3/12.
//  Copyright © 2016年 李旭波. All rights reserved.
//

#import "BLLKeyChain.h"

static NSString *kSecureInfoKey = @"com.beautifulreading.rio.secureInfo.key";

static NSString *kUserAccessTokenKey = @"com.beautifulreading.rio.userAccessToken.key";
static NSString *kUserRefreshTokenKey = @"com.beautifulreading.rio.userRefreshToken.key";

static NSString *kPasswdKey = @"com.beautifulreading.rio.passwd.key";



@implementation BLLKeyChain


+ (instancetype)shareInstance {
    static BLLKeyChain *shareObj = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObj = [[self alloc] init];
    });
    
    return shareObj;
}


- (NSString *)getUserAccessToken {
    NSMutableDictionary *secureInfoDic = [self load:kSecureInfoKey];
    return [secureInfoDic objectForKey:kUserAccessTokenKey];
}


- (void)saveUserAccessToken:(NSString *)userAccessToken {
    NSMutableDictionary *secureInfoDic = [self load:kSecureInfoKey];
    if(!secureInfoDic) {
        secureInfoDic = [[NSMutableDictionary alloc] init];
    }
    
    [secureInfoDic setObject:userAccessToken forKey:kUserAccessTokenKey];
    
    [self save:kSecureInfoKey data:secureInfoDic];
}


- (NSString *)getUserRefreshToken {
    NSMutableDictionary *secureInfoDic = [self load:kSecureInfoKey];
    return [secureInfoDic objectForKey:kUserRefreshTokenKey];
}


- (void)saveUserRefreshToken:(NSString *)userRefreshToken {
    NSMutableDictionary *secureInfoDic = [self load:kSecureInfoKey];
    if(!secureInfoDic) {
        secureInfoDic = [[NSMutableDictionary alloc] init];
    }
    
    [secureInfoDic setObject:userRefreshToken forKey:kUserRefreshTokenKey];
    
    [self save:kSecureInfoKey data:secureInfoDic];
}


- (NSString *)getUserPassword {
    NSMutableDictionary *secureInfoDic = [self load:kSecureInfoKey];
    return [secureInfoDic objectForKey:kPasswdKey];
}


- (void)saveUserPassword:(NSString *)password {
    NSMutableDictionary *secureInfoDic = [self load:kSecureInfoKey];
    if(!secureInfoDic) {
        secureInfoDic = [[NSMutableDictionary alloc] init];
    }
    
    [secureInfoDic setObject:password forKey:kPasswdKey];
    
    [self save:kSecureInfoKey data:secureInfoDic];
}


- (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}


- (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}


- (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
            
        }
    }
    
    if(keyData) CFRelease(keyData);
    return ret;
}


- (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}


@end
