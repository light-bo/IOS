//
//  CALayer+PDKit.m
//  Loopin
//
//  Created by light_bo on 2017/6/16.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "CALayer+PDKit.h"
#import <objc/runtime.h>



@implementation CALayer (PDKit)


- (void)showSmallLikeScaleAnimatation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];

    animation.duration = 0.3; //动画持续时间
    animation.repeatCount = 1; // 重复次数
    animation.autoreverses = NO; // 动画结束时执行逆动画
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:2]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:1]; // 结束时的倍率
    
    // 添加动画
    [self addAnimation:animation forKey:@"scale-layer"];
}

- (void)showBigLikeScaleAnimationWithCompletedBlock:(PdCALayerAnimatedCompletedBlock)animationCompletedBlock {
    float animatedTime = 0.3;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.duration = animatedTime; //动画持续时间
    animation.repeatCount = 1; //重复次数
    animation.autoreverses = YES; //动画结束时执行逆动画
    
    //缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:0];//开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:1.5];//结束时的倍率
    animation.delegate = self;
    
    //添加动画
    [self addAnimation:animation forKey:@"scale-layer"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((2 * animatedTime - 0.1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (animationCompletedBlock) {
            animationCompletedBlock();
        }
    });
}




@end
