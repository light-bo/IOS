//
//  PdPermissionManager.m
//  Famlink
//
//  Created by light_bo on 2018/3/21.
//Copyright © 2018年 Paramida. All rights reserved.
//

#import "PdPermissionManager.h"

@implementation PdPermissionManager

+ (void)showHintSettingCameraPermissionAlertViewOnViewController:(UIViewController *)viewController {
    if (!viewController) {
        return;
    }
    
    [self showHintAlertViewWithViewController:viewController msg:LANGUAGE(@"ico_access_camera") withCancelTitle:LANGUAGE(@"ico_later") withConfirmTitle:LANGUAGE(@"setting")];
}


+ (void)showHintSettingPhotoLibraryPermissionAlertViewOnViewController:(UIViewController *)viewController {
    if (!viewController) {
        return;
    }
    
    [self showHintAlertViewWithViewController:viewController msg:LANGUAGE(@"ico_acess_photos")  withCancelTitle:LANGUAGE(@"ico_later") withConfirmTitle:LANGUAGE(@"setting")];
}

+ (void)showHintAlertViewWithViewController:(UIViewController *)viewController msg:(NSString *)msg withCancelTitle:(NSString *)cancelTitle withConfirmTitle:(NSString *)confirmTitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *laterAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:laterAction];
    
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self openSettingPage];
    }];
    
    [alert addAction:settingAction];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}

+ (void)openSettingPage {
    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if (@available(iOS 10,*)) {
        [[UIApplication sharedApplication]openURL:appSettings options:@{} completionHandler:^(BOOL success) {
            
        }];
    } else {
        [[UIApplication sharedApplication]openURL:appSettings];
    }
}

@end
