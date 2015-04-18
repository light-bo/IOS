//
//  Man.m
//  L15protocal
//
//  Created by plter on 14-4-22.
//  Copyright (c) 2014年 eoe. All rights reserved.
//

#import "Man.h"

@implementation Man


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = nil;
        _age = 20;
    }
    return self;
}

-(int)getAge{
    return _age;
}

-(void)setAge:(int)age{
    if (age!=_age) {
        if (self.delegate) {
            [self.delegate onAgeChanged:age];
        }
    }
    _age = age;
}

-(NSString*)getName{
    return @"ZhangSan";
}


@end
