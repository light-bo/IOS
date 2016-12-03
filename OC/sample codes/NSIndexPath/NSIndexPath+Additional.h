//
//  NSIndexPath+Additional.h
//  xbao
//
//  Created by light_bo on 16/8/5.
//  Copyright © 2016年 QuickArrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (Additional)

/**
 在 (section, row) 插入 count 个 cell 时，创建需要插入的位置的 NSIndexPath 数组
 */
+ (NSArray *)generateIndexPathsWithStartRow:(NSUInteger)row
                           withStartSection:(NSUInteger)section
                                  withCount:(NSUInteger)count;

@end
