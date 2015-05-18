//
//  LightUtilities.m
//  Statistics
//
//  Created by gzyiniu on 15-4-9.
//  Copyright (c) 2015年 gzyiniu. All rights reserved.
//

#import "LightUtilities.h"
#import <UIKit/UIKit.h>


@implementation LightUtilities

+ (void)setCollectionViewCellShadowBound:(UICollectionViewCell*)cell {
    cell.layer.masksToBounds = NO;
    cell.layer.contentsScale = [UIScreen mainScreen].scale;
    cell.layer.shadowOpacity = 0.75f;
    cell.layer.shadowRadius = 4.0f;
    cell.layer.shadowOffset = CGSizeMake(0,0);
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    
    //设置缓存
    cell.layer.shouldRasterize = YES;
    
    //设置抗锯齿边缘
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


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


@end
