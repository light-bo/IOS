//
//  BRCommon.h
//  bookshelf
//
//  Created by PointrerTan on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 *  在swift中，作为宏定义的访问入口，也可以用在OC。
 */
@interface BRCommon : NSObject

+ (BRCommon *)sharedInstance;

- (NSString *)usersInfoUrl;

@end
