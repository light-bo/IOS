//
//  Person.m
//  TestKVO
//
//  Created by gzyiniu on 15/6/2.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import "Person.h"
#import "BankAccount.h"


@interface Person ()

@property (nonatomic, strong) BankAccount *bankAccount;

@end


//取自身的指针，得到一个随机数
static void *Balance = (void *)&Balance;


@implementation Person

- (instancetype)init {
    self = [super init];
    if(self) {
        _bankAccount = [[BankAccount alloc] init];
    }
    
    return self;
}



- (void)registerAsObserver {
    [self.bankAccount addObserver:self
                   forKeyPath:@"balance"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:Balance];
}


//回调函数
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == Balance) {
        NSLog(@"balance value:%@", [change objectForKey:NSKeyValueChangeNewKey]);
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
