//
//  UserDefaultsUtils.h
//  YiniuE-Commerce
//
//  Created by 李旭波 on 14-10-16.
//  Copyright (c) 2014年 zs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PdUserDefaultsUtils : NSObject

+ (void)setValue:(id)value forKey:(NSString *)key;

+ (void)setObject:(id)value forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key;

+ (void)setBool:(BOOL)value forKey:(NSString *)key;

+ (BOOL)boolForKey:(NSString *)key;

+ (void)removeObjectForKey:(NSString *)key;

+ (void)print;


@end
