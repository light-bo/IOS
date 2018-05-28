//
//  UIApplication+PDKit.h
//  Loopin
//
//  Created by light_bo on 2017/6/23.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIApplication (PDKit)


/**
 全局隐藏导航栏
 */
@property (nonatomic, assign, readonly) BOOL isGlobalHideStatusBar;
@property (nonatomic, copy, readonly) NSString *appDisplayName;


/**
 return： 当前页面键盘的 window，如果没有，则返回 [UIApplication sharedApplication].keyWindow
 */
@property (nonatomic, strong, readonly) UIWindow *currentKeyBoardWindow;


@end
