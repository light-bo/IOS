//
//  Man.h
//  L15protocal
//
//  Created by plter on 14-4-22.
//  Copyright (c) 2014年 eoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPeople.h"
#import "ManDelegate.h"

@interface Man : NSObject<IPeople>{
    int _age;
}

-(id)init;

-(void)setAge:(int)age;
-(NSString*)getName;
-(int)getAge;

@property id<ManDelegate> delegate;

@end
