//
//  IPeople.h
//  L15protocal
//
//  Created by plter on 14-4-22.
//  Copyright (c) 2014年 eoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IPeople <NSObject>

-(int)getAge;
-(void)setAge:(int)age;
-(NSString*)getName;

@end
