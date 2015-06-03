//
//  BJBroadCast.m
//  TestNSNotification
//
//  Created by gzyiniu on 15/6/2.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import "BJBroadCast.h"

@implementation BJBroadCast

- (void)broadCastLoop {
    [NSTimer scheduledTimerWithTimeInterval:2.0f
                                     target:self
                                   selector:@selector(broadCast)
                                   userInfo:nil
                                    repeats:YES];
}


- (void)broadCast {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    static int i = 0;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithInt:i++], @"i", nil];
    
    [nc postNotificationName:@"BJBroadCast" object:self userInfo:dict];
}


@end
