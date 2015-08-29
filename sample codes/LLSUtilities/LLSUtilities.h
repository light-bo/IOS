//
//  LLSUtilities.h
//  Statistics
//
//  Created by light_bo on 15-4-9.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LLSUtilities : NSObject {
    
}


//判断日期是不是今天
+ (BOOL)isToday:(NSDate *)date;

//将 NSDate 转换为“XXXX年XX月XX日”的格式
+ (NSString *)NSDateToString:(NSDate *)newDate;

//将 NSDate 转换为“XXXX－XX－XX” 的格式
+ (NSString *)NSdateToInterfaceString:(NSDate *)date;


//label
+ (UILabel *)createLabelWithFrame:(CGRect)frame 
                  backgroundColor:(UIColor *)color 
				             text:(NSString *)text 
							 font:(CGFloat)font 
						   textAg:(NSTextAlignment)alignment     
						textColor:(NSInteger)hexValue;

@end
