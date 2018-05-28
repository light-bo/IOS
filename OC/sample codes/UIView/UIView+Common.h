//
//  UIView+Common.h
//  Loopin
//
//  Created by light_bo on 2017/1/20.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (Common)

/**
 *   边框阴影
 *
 */
- (void)configCustomBadgeShadow;

- (void)configShadowWithRadius:(float)radius offset:(CGSize)size;

/**
 添加渐变背景颜色, 渐变方向由左向右
 */
- (void)configGradientBackgroundColor:(CGSize)gradientRegionSize;
- (void)configGradientBackgroundColorFromLeftTopToRightBottom:(CGSize)gradientRegionSize;
- (CAGradientLayer *)configGradientBackgroundColorWithSize:(CGSize)gradientRegionSize startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startColor:(UIColor *)startColor endColor:(UIColor *)endColor;
- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners ;




@end
