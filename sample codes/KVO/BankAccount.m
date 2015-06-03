//
//  BankAccount.m
//  TestKVO
//
//  Created by gzyiniu on 15/6/2.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount

- (instancetype)init {
    self = [super init];
    if(self) {
        [NSTimer scheduledTimerWithTimeInterval:2.0f
                                         target:self
                                       selector:@selector(balanceChanged:)
                                       userInfo:nil
                                        repeats:YES];
        
     }
    
    return self;
}


- (void)balanceChanged:(id *)sender {
    NSLog(@"data changed!");
    
    float f = arc4random() % 100;
    self.balance = f;
}


@end
