//
//  PdPermissionManager.h
//  Famlink
//
//  Created by light_bo on 2018/3/21.
//Copyright © 2018年 Paramida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LBXPermission/LBXPermission.h>

@interface PdPermissionManager : LBXPermission

+ (void)showHintSettingCameraPermissionAlertViewOnViewController:(UIViewController *)viewController;
+ (void)showHintSettingPhotoLibraryPermissionAlertViewOnViewController:(UIViewController *)viewController;
+ (void)showHintAlertViewWithViewController:(UIViewController *)viewController msg:(NSString *)msg withCancelTitle:(NSString *)cancelTitle withConfirmTitle:(NSString *)confirmTitle;

@end
