//
//  UserDefaultsUtils.h
//  YiniuE-Commerce
//
//  Created by 张帅 on 14-10-16.
//  Copyright (c) 2014年 zs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtils : NSObject

+ (void)saveValue:(id)value forKey:(NSString *)key;

+ (id)valueWithKey:(NSString *)key;

+ (BOOL)boolValueWithKey:(NSString *)key;

+ (void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

+ (void)removeValueWithKey:(NSString *)key;

+ (void)print;

@end
