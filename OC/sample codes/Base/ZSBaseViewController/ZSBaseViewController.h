//
//  BaseViewController.h
//  YiniuE-Commerce
//
//  Created by 张帅 on 14-10-16.
//  Copyright (c) 2014年 zs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"
#import "PageVisitDataStatistics.h"

@class CustomSearchBar;

@interface BaseViewController : UIViewController

//Navi的title
- (void)createNaviTitle:(NSString *)title;

//Navi的左按钮
- (void)createNaviLeftButtonWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)imageName target:(id)target action:(SEL)action;

//Navi的右按钮
- (void)createNaviRightButtonWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)imageName target:(id)target action:(SEL)action;

- (void)createNaviRightButtonWithTitle:(NSString *)title image:(NSString *)imageName target:(id)target action:(SEL)action;

//button
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)string titleColor:(NSInteger)hexValue font:(CGFloat)font backgroundImage:(UIImage *)bgimage image:(UIImage *)image target:(id)target action:(SEL)action tag:(NSInteger)tag;

//view
+ (UIView *)createViewWithFrame:(CGRect)frame image:(UIImage *)image;

//label
+ (UILabel *)createLabelWithFrame:(CGRect)frame backgroundColor:(UIColor *)color text:(NSString *)text font:(CGFloat)font textAg:(NSTextAlignment)alignment textColor:(NSInteger)hexValue;

//textfield
+ (UITextField *)createTextFieldWithFrame:(CGRect )frame placeholder:(NSString *)string font:(CGFloat )font textAg:(NSTextAlignment )alignment textColor:(NSInteger )hexValue;

//UIControl

//拉伸图片
- (UIImage *)stretchableImage:(UIImage *)image;

//创建个数小图标
+ (UILabel *)smallPicWithFrame:(CGRect)frame withBorder:(BOOL)yesOrNo;

//设置文本
- (NSAttributedString*) getAttributedString:(NSAttributedString*) attributedString withTextColor:(NSInteger)integer withLocation:(NSUInteger)loc withLength:(NSUInteger)len;
- (NSAttributedString*) getAttributedString:(NSAttributedString*) attributedString withUnderlineStyle:(NSUnderlineStyle)underlineStyle withForegroundColor:(NSInteger)integer withLocation:(NSUInteger)loc withLength:(NSUInteger)len;
- (NSAttributedString*) getAttributedString:(NSAttributedString*) attributedString withTextColor:(NSInteger)integer withFont:(CGFloat)font withLocation:(NSUInteger)loc withLength:(NSUInteger)len;

//活动指示器
- (void)showActivityIndicatorView:(UIView *)view withFrame:(CGRect)rect;
- (void)createActivityIndicatorView:(UIView *)view;
- (void)activityIndicatorViewStop;

//NSString去掉最后一个字符
- (NSString*) removeLastOneChar:(NSString*)origin;

#pragma mark -- 自定义搜索框
- (UITextField *)createCustomSearchTF:(CGRect)frame leftImage:(NSString *)imgName placeholder:(NSString *)placeholder;

#pragma mark -- 判断由那个viewController push过来
- (BOOL)parentVC:(NSString *)viewControllerClass;

//自定义alertView
- (void)customAlertViewWithView:(UIView *)view frame:(CGRect)frame message:(NSString *)message leftButtonTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle leftBtnAction:(SEL)leftAction rightBtnAction:(SEL)rightAction;

- (void)hideCustomAlertView;

//自定义网络不给力时提示view
- (UIView *)networkIsNotConnectedTipsView:(UIView *)view prompt:(NSString *)prompt;

- (UIView *)customNoNetworkViewWithView:(UIView *)view promptImg:(NSString *)imgName promptTxt:(NSString *)promptTxt setBtnTitle:(NSString *)title action:(SEL)action;

- (UIView *)customNoNetworkViewNoTabbarViewWithView:(UIView *)view promptImg:(NSString *)imgName promptTxt:(NSString *)promptTxt setBtnTitle:(NSString *)title action:(SEL)action;

-(void)pageVisitDataStatistics;

@end
