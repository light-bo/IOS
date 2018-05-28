//
//  PdLabel.m
//  Loopin
//
//  Created by light_bo on 2017/11/28.
//Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "PdLabel.h"

@implementation PdLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect bounds = self.bounds;
    
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    
    //扩大bounds, 上下左右，扩大相应的比例
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    
    //如果点击的点 在新的bounds里，就返回YES
    return CGRectContainsPoint(bounds, point);
}

@end
