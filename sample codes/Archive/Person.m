//
//  Person.m
//  TestOC
//
//  Created by gzyiniu on 15/6/16.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import "Person.h"

@implementation Person

//反归档
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age = [aDecoder decodeIntForKey:@"age"];
    }
    
    return  self;
}

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt64:self.age forKey:@"age"];
}



@end
