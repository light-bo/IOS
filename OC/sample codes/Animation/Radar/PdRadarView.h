//
//  PdRadarView.h
//  Loopin
//
//  Created by light_bo on 2017/9/21.
//Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PdRadarIconType) {
    PdRadarIconTypeRadar,
    PdRadarIconTypeScanNoData,
    PdRadarIconTypeNetworkError,
    PdRadarIconTypeUnknown
};


/**
 为了达到更好的动画效果，PdRadarView 的宽与高的尺寸最好相同
 */
@interface PdRadarView : UIView

/**
 *  start animation
 */
- (void)startAnimation;

/**
 *  stop animation
 */
- (void)stopAnimation;

- (void)configRadarIconType:(PdRadarIconType)radarIconType;


/**
 填充颜色
 */
@property (nonatomic, strong) UIColor *fillColor;


/**
 波纹数量
 */
@property (nonatomic, assign) NSInteger instanceCount;

@property (nonatomic, assign) CFTimeInterval instanceDelay;
@property (nonatomic, assign) CGFloat opacityValue;


/**
 动画时间
 */
@property (nonatomic, assign) CFTimeInterval animationDuration;

@property (nonatomic, copy) PdBtnClickedBlock radarBtnClickedBlock;


@end
