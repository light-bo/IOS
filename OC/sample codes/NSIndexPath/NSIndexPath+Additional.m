//
//  NSIndexPath+Additional.m
//  xbao
//
//  Created by light_bo on 16/8/5.
//  Copyright © 2016年 QuickArrow. All rights reserved.
//

#import "NSIndexPath+Additional.h"

@implementation NSIndexPath (Additional)

+ (NSArray *)generateIndexPathsWithStartRow:(NSUInteger)row
                           withStartSection:(NSUInteger)section
                                  withCount:(NSUInteger)count {
    NSMutableArray *indexPathsArray = [[NSMutableArray alloc] init];
    NSUInteger topExtreme = row + count;
    
    for(NSUInteger index=row; index<topExtreme; ++index) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
        [indexPathsArray addObject:indexPath];
    }
    
    return indexPathsArray;
}

@end
