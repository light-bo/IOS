//
//  UIApplication+PDKit.m
//  Loopin
//
//  Created by light_bo on 2017/6/23.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "UIApplication+PDKit.h"

@implementation UIApplication (PDKit)

- (BOOL)isGlobalHideStatusBar {
    return [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIStatusBarHidden"] boolValue];
}

- (NSString *)appDisplayName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

- (UIWindow *)currentKeyBoardWindow {
    UIWindow *window = [self findKeyboardWindow];
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    return window;
}

/**
 *  获取弹出键盘的 key window，避免提示语被键盘挡住
 *
 */
- (UIWindow *)findKeyboardWindow {
    if (@available(iOS 9.0, *)) {
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            if([window isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")]) {
                return window;
            }
        }
    } else {
        for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
            if ([NSStringFromClass([window class]) isEqualToString:@"UITextEffectsWindow"]) {
                return window;
            }
        }
    }
    
    return nil;
}

@end
