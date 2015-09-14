//
//  BNRItemStore.m
//  TestTableView
//
//  Created by gzyiniu on 15-3-9.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemStore

+ (BNRItemStore*)sharedStore {
    static BNRItemStore* store = nil;
	@synchronized(self) { //线程同步
		if(!store) {
			store = [[super allocWithZone:nil] init];
		}
	} 
    return store;
}


+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedStore];
}


- (id) init {
    self = [super init];
    if(self) {
        allItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray*)allItems {
    return  allItems;
}


- (BNRItem*)createItem {
    BNRItem* bnrItem = [BNRItem randomItem];
    
    [allItems addObject:bnrItem];
    
    return  bnrItem;
}

- (void)removeItem:(BNRItem*)item {
    [allItems removeObjectIdenticalTo:item];
}

- (void)moveObjectfrom:(int)from to:(int)to {
    BNRItem* p = [allItems objectAtIndex:from];
    [allItems removeObject:p];
    
    [allItems insertObject:p atIndex:to];
    
}


@end
