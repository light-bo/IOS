//
//  LLSBaseViewController.m
//  视图控制器基类
//
//  Created by 李旭波 on 15/8/26.
//  Copyright (c) 2015年 李旭波. All rights reserved.
//

#import "LLSBaseViewController.h"

//导航栏高度
static const int kNavigationBarHeight = 44;

#define UIColorFromRGB(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define kNavigationBarTitleColor UIColorFromRGB(0x111111)
#define kNavigationBarLeftButtonTitleColor UIColorFromRGB(0x848689)
#define kNavigationBarRightButtonTitleColor UIColorFromRGB(0x666666)


@interface LLSBaseViewController ()

//圆形悬浮按钮
@property (nonatomic, strong) UIWindow *window; //不能声明为局部变量，否则显示不出来，因为函数运行完即释放
@property (nonatomic, strong) UIButton *suspendBtn;



@end

@implementation LLSBaseViewController


#pragma mark -- 导航栏
- (void)customNavigationBarTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, kNavigationBarHeight)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.font = [UIFont systemFontOfSize:21];
    label.textColor = kNavigationBarTitleColor;//字体颜色
    label.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = label;
}

- (void)createNavigationBarLeftButtonWithFrame:(CGRect)frame
                                         title:(NSString *)title
                                         image:(NSString *)imageName
                                        target:(id)target
                                        action:(SEL)action {
    UIImage *image = nil;
    if(imageName) {
        image = [UIImage imageNamed:imageName];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [button setImage:image forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, frame.size.width-image.size.width)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:kNavigationBarLeftButtonTitleColor forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBackItem;
}

- (void)createNavigationBarRightButtonWithFrame:(CGRect)frame
                                         title:(NSString *)title
                                         image:(NSString *)imageName
                                        target:(id)target
                                        action:(SEL)action {
    UIImage *img = nil;
    if(imageName) img = [UIImage imageNamed:imageName];
 
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kNavigationBarRightButtonTitleColor forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
   
    [button setImage:img forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, frame.size.width-img.size.width, 0, 0)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark --创建悬浮按钮
- (void)createCircularSuspendButtonWithFrame:(CGRect)frame
                            withColor:(UIColor *)color
                            withTitle:(NSString *)title
                           withTarget:(id)target
                           withAction:(SEL)selector {
    self.window = [[UIWindow alloc] initWithFrame:frame];
    self.window.windowLevel= UIWindowLevelNormal + 1;
    self.window.backgroundColor = color;
    self.window.layer.cornerRadius = frame.size.width/2;
    self.window.layer.masksToBounds = YES;
    
    self.suspendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.suspendBtn setTitle:title forState:UIControlStateNormal];
    self.suspendBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self.suspendBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [self.window addSubview:_suspendBtn];
    [self.window makeKeyAndVisible];//加载到屏幕并显示出来
}

- (void)resignCircularSuspendBtn {
    [self.window setHidden:YES];
    self.window = nil;
    [self.view.window makeKeyAndVisible];//刷新界面
}


#pragma mark --活动指示符
- (void)activityViewStartAnimating {
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.hidesWhenStopped = YES;
    
    [self.view addSubview:_activityIndicatorView];
    
    [_activityIndicatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSMutableArray *constraints = [NSMutableArray array];
    //水平居中
    [constraints addObjectsFromArray:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"|-[_activityIndicatorView]-|"
                                      options:NSLayoutFormatAlignAllCenterX
                                      metrics:nil
                                      views:NSDictionaryOfVariableBindings(_activityIndicatorView)]];
    
    //垂直居中
    [constraints addObjectsFromArray:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|-[_activityIndicatorView]-|"
                                      options:NSLayoutFormatAlignAllCenterY
                                      metrics:nil
                                      views:NSDictionaryOfVariableBindings(_activityIndicatorView)]];
    
    [self.view addConstraints:constraints];
    
    [_activityIndicatorView startAnimating];
}


- (void)activityViewStopAnimating {
    [_activityIndicatorView stopAnimating];
    [_activityIndicatorView removeFromSuperview];
}



@end
