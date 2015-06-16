//
//  Person.h
//  TestOC
//
//  Created by gzyiniu on 15/6/16.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

//遵循 NSCoding 归档协议
@interface Person : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end
