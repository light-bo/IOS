//
//  BNRItemStore.h
//  TestTableView
//
//  Created by gzyiniu on 15-3-9.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

//class declaration
@class BNRItem;


@interface BNRItemStore : NSObject {
    NSMutableArray *allItems;
}


+ (BNRItemStore*)sharedStore;

- (NSArray*)allItems;
- (BNRItem*)createItem;
- (void)removeItem:(BNRItem*)item;
- (void)moveObjectfrom:(int)from to:(int)to;

@end
