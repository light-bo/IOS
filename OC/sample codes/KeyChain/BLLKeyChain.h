//
//  BRKeyChain.h
//  TestKeyChain
//
//  Created by 李旭波 on 16/3/12.
//  Copyright © 2016年 李旭波. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BLLKeyChain : NSObject


+ (instancetype)shareInstance;


- (NSString *)getUserAccessToken;
- (void)saveUserAccessToken:(NSString *)userAccessToken;

- (NSString *)getUserRefreshToken;
- (void)saveUserRefreshToken:(NSString *)userRefreshToken;

- (NSString *)getUserPassword;
- (void)saveUserPassword:(NSString *)password;


- (void)save:(NSString *)service data:(id)data;
- (id)load:(NSString *)service;
- (void)delete:(NSString *)service;


@end
