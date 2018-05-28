//
//  UIView+Common.m
//  Loopin
//
//  Created by light_bo on 2017/1/20.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//


#import "UIView+Common.h"

@implementation UIView (Common)

- (void)configCustomBadgeShadow {
    self.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
    self.layer.shadowRadius = 2;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 0.5;
}

- (void)configShadowWithRadius:(float)radius offset:(CGSize)size {
    self.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = size;
    self.layer.shadowOpacity = 0.5;
}

- (void)configGradientBackgroundColor:(CGSize)gradientRegionSize {
    for (CALayer *subLayer in self.layer.sublayers) {
        if ([subLayer isKindOfClass:[CAGradientLayer class]]) {
            return;
        }
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"0xFF9e56"].CGColor, (__bridge id)[UIColor colorWithHexString:@"0xFFC863"].CGColor];
    gradientLayer.locations = @[@0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, gradientRegionSize.width, gradientRegionSize.height);
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)configGradientBackgroundColorFromLeftTopToRightBottom:(CGSize)gradientRegionSize {
    for (CALayer *subLayer in self.layer.sublayers) {
        if ([subLayer isKindOfClass:[CAGradientLayer class]]) {
            return;
        }
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"0xFF4444"].CGColor, (__bridge id)[UIColor colorWithHexString:@"0xFFF739"].CGColor, (__bridge id)[UIColor colorWithHexString:@"0xF4FF23"].CGColor];
    gradientLayer.locations = @[@0, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, gradientRegionSize.width, gradientRegionSize.height);
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
}


- (CAGradientLayer *)configGradientBackgroundColorWithSize:(CGSize)gradientRegionSize startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    for (CALayer *subLayer in self.layer.sublayers) {
        if ([subLayer isKindOfClass:[CAGradientLayer class]]) {
            [subLayer removeFromSuperlayer];
            break;
        }
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = CGRectMake(0, 0, gradientRegionSize.width, gradientRegionSize.height);
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    return gradientLayer;
}

- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners {
    
    //    UIRectCorner type = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    
    //1. 加一个layer 显示形状
    CGRect rect = CGRectMake(borderWidth/2.0, borderWidth/2.0,
                             CGRectGetWidth(self.frame)-borderWidth, CGRectGetHeight(self.frame)-borderWidth);
    CGSize radii = CGSizeMake(cornerRadius, borderWidth);
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    shapeLayer.lineWidth = borderWidth;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.layer addSublayer:shapeLayer];
    
    
    
    
    //2. 加一个layer 按形状 把外面的减去
    CGRect clipRect = CGRectMake(0, 0,
                                 CGRectGetWidth(self.frame)-1, CGRectGetHeight(self.frame)-1);
    CGSize clipRadii = CGSizeMake(cornerRadius, borderWidth);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:clipRect byRoundingCorners:corners cornerRadii:clipRadii];
    
    CAShapeLayer *clipLayer = [CAShapeLayer layer];
    clipLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    clipLayer.lineWidth = 1;
    clipLayer.lineJoin = kCALineJoinRound;
    clipLayer.lineCap = kCALineCapRound;
    clipLayer.path = clipPath.CGPath;
    
    self.layer.mask = clipLayer;
}

@end
