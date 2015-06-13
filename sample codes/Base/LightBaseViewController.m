//
//  LightBaseViewController.m
//  LightBaseViewController
//
//  Created by light on 15/6/13.
//  Copyright (c) 2015年 light. All rights reserved.
//

#import "LightBaseViewController.h"

#define UIColorFromRGB(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

static const NSUInteger kNavigationBarHeight = 44;

@interface LightBaseViewController ()

@end

@implementation LightBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createNavigationBarTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, kNavigationBarHeight)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.font = [UIFont systemFontOfSize:21];
    label.textColor = UIColorFromRGB(0x111111);
    label.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = label;
}


- (void)createNaviLeftButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                                image:(NSString *)imageName
                               target:(id)target
                               action:(SEL)action {
    UIImage *image = nil;
    if(imageName) {
        image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [button setImage:image forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, frame.size.width-image.size.width)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:UIColorFromRGB(0x848689) forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBackItem;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
