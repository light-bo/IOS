//
//  NSDictionary+JSONString.h
//  bookshelf
//
//  Created by 李旭波 on 15/10/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONString)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
