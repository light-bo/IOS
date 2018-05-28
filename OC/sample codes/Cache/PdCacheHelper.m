//
//  PdCacheHelper.m
//  Loopin
//
//  Created by light_bo on 2017/3/30.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "PdCacheHelper.h"


static NSString *kMainCacheName = @"PdCacheHelper";


@interface PdCacheHelper ()

@property (nonatomic, strong) YYCache *cache;

@end



@implementation PdCacheHelper

+ (instancetype)shareHelper {
    static PdCacheHelper *cacheHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacheHelper = [PdCacheHelper new];
        [cacheHelper initCache];
    });
    
    return cacheHelper;
}

- (void)initCache {
    _cache = [[YYCache alloc] initWithName:kMainCacheName];
}

- (void)saveModel:(id<NSCoding>)model forKey:(NSString *)key {
    [_cache setObject:model forKey:key];
}

- (id<NSCoding>)modelWithKey:(NSString *)key {
    if ([_cache containsObjectForKey:key]) {
        return [_cache objectForKey:key];
    }
    
    return nil;
}

- (void)removeModelForKey:(NSString *)key {
    if ([_cache containsObjectForKey:key]) {
        [_cache removeObjectForKey:key];
    }
}

/**
 清空所有缓存
 */
- (void)clearAllCaches {
    [_cache removeAllObjects];
}

@end
