//
//  UIImage+Luban_iOS_Extension_h.h
//  Luban-iOS
//
//  Created by guo on 2017/7/20.
//  Copyright © 2017年 guo. All rights reserved.
//
// 鲁班压缩 iOS-OC版本
// https://github.com/GuoZhiQiang/Luban_iOS
// 鲁班压缩 iOS-Swift版本
// https://github.com/iCell/Mozi


#import <UIKit/UIKit.h>

@interface UIImage (Luban_iOS_Extension_h)

+ (NSData *)lubanCompressImage:(UIImage *)image;
+ (NSData *)lubanCompressImage:(UIImage *)image withMask:(NSString *)maskName;
+ (NSData *)lubanCompressImage:(UIImage *)image withCustomImage:(NSString *)imageName;

@end
