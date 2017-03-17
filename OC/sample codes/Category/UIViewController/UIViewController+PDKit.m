//
//  UIViewController.m
//  Loopin
//
//  Created by light_bo on 2016/12/23.
//  Copyright © 2016年 Paramida-Di. All rights reserved.
//

#import "UIViewController+PDKit.h"
#import "UIFont+Custom.h"

@implementation UIViewController (PDKit)

- (void)configNavigationBarArrowBackBtn:(id)target withAction:(SEL)action {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, Pd_NavigationBar_Height)];
    
    [backBtn setImage:[UIImage imageNamed:@"loopin_back"] forState:UIControlStateNormal];
    
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
//    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 20)];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}


- (void)configNavigationBarTitle:(NSString *)title {
    UILabel *titleLabel = [UILabel new];
    titleLabel.height = Pd_NavigationBar_Height;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.font = [UIFont semiBoldSystemFontOfSize:17];
    titleLabel.textColor = Pd_Title_Color_Vc;//字体颜色
    titleLabel.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.titleView = titleLabel;
}


- (void)configNavigationBarRightBtnWithImageName:(NSString *)imageName withTarget:(id)target withAction:(SEL)action {
    if (!imageName) {
        return;
    }
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, Pd_NavigationBar_Height)];
    
    [rightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    //    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 20)];
    
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}




@end
