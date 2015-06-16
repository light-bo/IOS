//
//  main.m
//  TestOC
//
//  Created by gzyiniu on 15-5-18.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

static NSString *const kPath = @"/Users/gzyiniu/dat.plist";

int main(int argc, const char * argv[]) {
    @autoreleasepool {
			
        //归档
        NSArray *array = @[ @"1", @"2", @"3" ];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"one", @"1",
                                                                         @"two", @"2",
                                                                         @"three", @"3", nil];
        
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        
        [archiver encodeObject:array forKey:@"array"];
        [archiver encodeObject:dic forKey:@"dic"];
        
        [archiver finishEncoding];
        
        [data writeToFile:kPath atomically:YES];
       
       
	   //反归档
        NSData *data = [[NSData alloc] initWithContentsOfFile:kPath];
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        NSArray *array = [unarchiver decodeObjectForKey:@"array"];
        NSLog(@"%@", array);
        
        NSDictionary *dic = [unarchiver decodeObjectForKey:@"dic"];
        NSLog(@"%@", dic);
     
		//自定义对象归档和反归档
        Person *person = [[Person alloc] init];
        person.name = @"light";
        person.age = 12;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:person];
        [data writeToFile:kPath atomically:YES];
        
        NSData *data = [NSData dataWithContentsOfFile:kPath];
        Person *person = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    return 0;
}
