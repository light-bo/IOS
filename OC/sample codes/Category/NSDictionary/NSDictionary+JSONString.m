//
//  NSDictionary+JSONString.m
//  bookshelf
//
//  Created by 李旭波 on 15/10/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NSDictionary+JSONString.h"

@implementation NSDictionary (JSONString)


/*!
 
 * 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *errorInfo;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&errorInfo];
    
    if(errorInfo) {
        NSLog(@"json解析失败：%@", errorInfo);
        return nil;
    }
    
    return dic;
}


@end
