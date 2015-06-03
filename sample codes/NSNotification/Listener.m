//
//  Listener.m
//  TestNSNotification
//
//  Created by gzyiniu on 15/6/2.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import "Listener.h"

@implementation Listener

- (void)listenToTheBroadCast {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveMessages:)
                                                 name:@"BJBroadCast"
                                               object:nil];
    
}

- (void)receiveMessages:(NSNotification *)notify {
    NSLog(@"%@", notify.name);
    NSLog(@"%@", [notify.userInfo valueForKey:@"i"]);
}


@end
