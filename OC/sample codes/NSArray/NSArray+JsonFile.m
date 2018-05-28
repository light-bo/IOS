//
//  NSArray+JsonFile.m
//  bookshelf
//
//  Created by 李旭波 on 15/11/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NSArray+JsonFile.h"

@implementation NSArray (JsonFile)

+ (NSArray *)arrayWithJsonFile:(NSString *)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName
                                                         ofType:nil];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSArray *objectArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return objectArray;
}

@end
