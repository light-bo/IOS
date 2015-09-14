//
//  Singleton.m
//  TestOC
//
//  Created by 李旭波 on 15/8/25.
//  Copyright (c) 2015年 李旭波. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

+ (instancetype)shareInstance {
    static Singleton *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^(){
        instance = [[self alloc] initWithTestString:@"singleton"];
    });
    
    return instance;
}

- (instancetype)initWithTestString:(NSString *)testString {
    self = [super init];
    if(self) self.testString = testString;
    
    return self;
}


@end
