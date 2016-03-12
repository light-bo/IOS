//
//  BRKeyChain.h
//  TestKeyChain
//
//  Created by 李旭波 on 16/3/12.
//  Copyright © 2016年 李旭波. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString *kSecureInfoKey = @"com.br.secureInfo.key";
static NSString *kUserTokenKey = @"com.br.userToken.key";
static NSString *kPasswdKey = @"com.br.passwd.key";

@interface BRKeyChain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;


@end
