//
//  main.m
//  TestNSNotification
//
//  Created by gzyiniu on 15/6/2.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJBroadCast.h"
#import "Listener.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BJBroadCast *bj = [[BJBroadCast alloc] init];
        [bj broadCastLoop];
        
        Listener *lt = [[Listener alloc] init];
        [lt listenToTheBroadCast];
        
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}
