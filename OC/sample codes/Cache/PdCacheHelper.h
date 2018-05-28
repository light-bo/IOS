//
//  PdCacheHelper.h
//  Loopin
//
//  Created by light_bo on 2017/3/30.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PdGameModel;


@interface PdCacheHelper : NSObject

+ (instancetype)shareHelper;

- (void)saveModel:(id<NSCoding>)model forKey:(NSString *)key;
- (id<NSCoding>)modelWithKey:(NSString *)key;
- (void)removeModelForKey:(NSString *)key;


@end
