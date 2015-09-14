//
//  main.m
//  TestKVO
//
//  Created by gzyiniu on 15/6/2.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        Person *person = [[Person alloc] init];
        [person registerAsObserver];
        
        [[NSRunLoop currentRunLoop] run];
    }
    
    return 0;
}
