//
//  LLSBaseViewController.h
//  视图控制器基类
//
//  Created by 李旭波 on 15/8/26.
//  Copyright (c) 2015年 李旭波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLSBaseViewController : UIViewController

//设置导航栏标题
- (void)customNavigationBarTitle:(NSString *)title;

//创建导航栏左边按钮
- (void)createNavigationBarLeftButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                                image:(NSString *)imageName
                               target:(id)target
                               action:(SEL)action;

//创建导航栏右边按钮
- (void)createNavigationBarRightButtonWithFrame:(CGRect)frame
                                         title:(NSString *)title
                                         image:(NSString *)imageName
                                        target:(id)target
                                        action:(SEL)action;


//创建圆形悬浮按钮
- (void)createCircularSuspendButtonWithFrame:(CGRect)frame
                            withColor:(UIColor *)color
                            withTitle:(NSString *)title
                           withTarget:(id)target
                           withAction:(SEL)selector;
//取消悬浮按钮
- (void)resignCircularSuspendBtn;



@end
