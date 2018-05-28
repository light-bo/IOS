//
//  CALayer+PDKit.h
//  Loopin
//
//  Created by light_bo on 2017/6/16.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PdCALayerAnimatedCompletedBlock)(void);

@interface CALayer (PDKit) <CAAnimationDelegate>

- (void)showSmallLikeScaleAnimatation;
- (void)showBigLikeScaleAnimationWithCompletedBlock:(PdCALayerAnimatedCompletedBlock)animationCompletedBlock;


@end
