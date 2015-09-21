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

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity {
	float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
	float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
	float blue = ((float)(hexColor & 0xFF))/255.0;
	return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (NSString *)formatTimeWithTimestamp:(NSString *)timestamp {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy MM dd HH:mm:ss"];
	[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"CN"]];
	NSDate *dates = [NSDate dateWithTimeIntervalSince1970:[timestamp floatValue]/1000];

	NSTimeInterval late = [dates timeIntervalSince1970] * 1;

	NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
	NSTimeInterval now = [dat timeIntervalSince1970] * 1;
	NSString *timeString = @"";

	NSTimeInterval timeInterval = now - late;

	if (timeInterval/3600 < 1) {
		timeString = [NSString stringWithFormat:@"%f", timeInterval/60];
		timeString = [timeString substringToIndex:timeString.length-7];
		timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
	} else if (timeInterval/3600>1 && timeInterval/86400<1) {
		NSTimeInterval cha = now - late;
		int hours = ((int)cha) % (3600 * 24) / 3600;
		timeString = [NSString stringWithFormat:@"%d小时前",hours];
	} else if (timeInterval/86400>1) {
		NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
		[dateformatter setDateFormat:@"YY-MM-dd"];
		timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:dates]];
	}

	return timeString;
}

//根据字符串的内容计算 label 的自适应高度
+ (CGFloat)calculateLabelContentHeight:(NSString *)content
                          withFontSize:(CGFloat)fontSize
                        withLabelWidth:(CGFloat)labelWidth {
	//ios 7 later
	NSDictionary *attrs = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};

	CGSize labelSize = [content boundingRectWithSize:CGSizeMake(labelWidth, 1000)
		                                     options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
		                                  attributes:attrs context:nil].size;

	return labelSize.height;
}



@end
