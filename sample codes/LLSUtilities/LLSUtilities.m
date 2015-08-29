//
//  LLSUtilities.m
//  Statistics
//
//  Created by light_bo on 15-4-9.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import "LLSUtilities.h"
#import <UIKit/UIKit.h>


@implementation LLSUtilities


+ (BOOL)isToday:(NSDate*)date {
    NSDate *today = [NSDate date];
    NSCalendar *todayCalendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *todayComponent = [todayCalendar components:unitFlags fromDate:today];
    
    NSCalendar *dateCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [dateCalendar components:unitFlags fromDate:date];
    
    if( (todayComponent.year==dateComponent.year) &&
        (todayComponent.month==dateComponent.month) &&
        (todayComponent.day==dateComponent.day) ) return YES;
    else return NO;
}


//将 NSDate 转换为“XXXX年XX月XX日”的格式
+ (NSString*)NSDateToString:(NSDate*)newDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日▾"];
    return [dateFormatter stringFromDate:newDate];
}


//将 NSDate 转换为“XXXX－XX－XX” 的格式
+ (NSString*)NSdateToInterfaceString:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    
    return [dateFormatter stringFromDate:date];
}


+ (UILabel *)createLabelWithFrame:(CGRect)frame 
                  backgroundColor:(UIColor *)color 
				             text:(NSString *)text 
							 font:(CGFloat)font 
						   textAg:(NSTextAlignment)alignment     
						textColor:(NSInteger)hexValue {
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.backgroundColor = color;
	label.text = text;
	label.font = [UIFont systemFontOfSize:font];
	label.textAlignment = alignment;
	label.textColor = UIColorFromRGB(hexValue);

	return label;
}

@end
