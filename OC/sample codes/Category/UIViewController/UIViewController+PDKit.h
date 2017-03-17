//
//  UIViewController.h
//  Loopin
//
//  Created by light_bo on 2016/12/23.
//  Copyright © 2016年 Paramida-Di. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (PDKit)

- (void)configNavigationBarArrowBackBtn:(id)target withAction:(SEL)action;
- (void)configNavigationBarTitle:(NSString *)title;
- (void)configNavigationBarRightBtnWithImageName:(NSString *)imageName withTarget:(id)target withAction:(SEL)action;


@end
