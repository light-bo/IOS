//
//  Singleton.h
//  TestOC
//
//  Created by 李旭波 on 15/8/25.
//  Copyright (c) 2015年 李旭波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

+ (instancetype)shareInstance;
- (instancetype)initWithTestString:(NSString *)testString;

@property (nonatomic, copy) NSString *testString;

@end
