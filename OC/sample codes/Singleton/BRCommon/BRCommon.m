//
//  BRCommon.m
//  bookshelf
//
//  Created by PointrerTan on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BRCommon.h"

@implementation BRCommon

+ (BRCommon *)sharedInstance {
    static BRCommon *common = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        common = [[BRCommon alloc] init];
    });
    return common;
}

- (NSString *)usersInfoUrl {
    return USER_INFO_URL;
}


@end
