//
//  UIImage+CircularBorder.m
//  TestIOS
//
//  Created by 李旭波 on 16/5/14.
//  Copyright © 2016年 李旭波. All rights reserved.
//

#import "UIImage+CircularBorder.h"

@implementation UIImage (CircularBorder)

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    //先将图片的大小预处理为正方形，即边长的值为原图片中宽或高较小的正方形
    float sizeLength = (self.size.width>self.size.height)? self.size.height: self.size.width;
    UIImage *resizeImage = [self scaleToSize:self size:CGSizeMake(sizeLength, sizeLength)];
    
    CGRect rect = (CGRect){0.f, 0.f, resizeImage.size};
    
    UIGraphicsBeginImageContextWithOptions(resizeImage.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}


- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    //返回新的改变大小后的图片
    return scaledImage;
}

@end
