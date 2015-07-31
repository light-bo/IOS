//
//  LightBaseViewController.h
//  LightBaseViewController
//
//  Created by light on 15/6/13.
//  Copyright (c) 2015年 light. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LightBaseViewController : UIViewController

//创建导航栏中间标题
- (void)createNavigationBarTitle:(NSString *)title;

//创建导航栏左侧返回按钮
- (void)createNaviLeftButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                                image:(NSString *)imageName
                               target:(id)target
                               action:(SEL)action;



@end
