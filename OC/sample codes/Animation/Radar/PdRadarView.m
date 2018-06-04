//
//  PdRadarView.m
//  Loopin
//
//  Created by light_bo on 2017/9/21.
//Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "PdRadarView.h"

@interface PdRadarView ()

@property (nonatomic, strong) CAShapeLayer *pulseLayer;
@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;
@property (nonatomic, strong) CAAnimationGroup *animaGroup;

@property (nonatomic, strong) CABasicAnimation *opacityAnima;

@property (nonatomic, strong) CABasicAnimation *middleBtnRotationAnimation;
@property (nonatomic, strong) UIButton *middleRadarBtn;

@property (nonatomic, assign) BOOL isAnimating;

@end


@implementation PdRadarView

- (instancetype)init {
    self = [super init];
    if (self) {
        _isAnimating = NO;
        [self configSubviews];
    }
    
    return self;
}

- (void)configSubviews {
    self.backgroundColor = [UIColor clearColor];
    _instanceCount = 6;
    _instanceDelay = 0.4f;
    _opacityValue = 0.6f;
    _fillColor = [UIColor colorWithHexString:@"FFD4D4"];
    
    _animationDuration = _instanceCount * _instanceDelay;
    
    _middleRadarBtn = [UIButton new];
    [_middleRadarBtn setImage:[UIImage imageNamed:@"fam_home_scene"] forState:UIControlStateNormal];
    [_middleRadarBtn setImage:[UIImage imageNamed:@"fam_home_scene"] forState:UIControlStateHighlighted];
    [self addSubview:_middleRadarBtn];
    [_middleRadarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (void)startAnimation {
    if (_isAnimating) {
        return;
    }
    
    //超时停止动画，4 秒是因为动画先显示 4 秒后才进行数据的请求，数据请求超时时间为 [PdNetworkClient defaultNetworkClient].timeOutInterval
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((4 + [PdNetworkClient defaultNetworkClient].timeOutInterval) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stopAnimation];
    });
    
    [_middleRadarBtn setImage:[UIImage imageNamed:@"fam_home_scene"] forState:UIControlStateNormal];
    [_middleRadarBtn setImage:[UIImage imageNamed:@"fam_home_scene"] forState:UIControlStateHighlighted];
    
    if (![self.layer.sublayers containsObject:self.replicatorLayer]) {
        [self.layer insertSublayer:self.replicatorLayer below:_middleRadarBtn.layer];
    }

    [self.pulseLayer removeAllAnimations];
    [self.pulseLayer addAnimation:self.animaGroup forKey:@"groupAnimation"];
    
    [_middleRadarBtn.layer addAnimation:self.middleBtnRotationAnimation forKey:@"middleRadarRotationAnimation"];
    
    _isAnimating = YES;
}

- (void)stopAnimation {
    if (!_isAnimating) {
        return;
    }
    
    if (_pulseLayer) {
        [_pulseLayer removeAllAnimations];
        [_middleRadarBtn.layer removeAllAnimations];
    }
    
    _isAnimating = NO;
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    self.pulseLayer.fillColor = fillColor.CGColor;
}

- (void)setInstanceCount:(NSInteger)instanceCount {
    _instanceCount = instanceCount;
    self.replicatorLayer.instanceCount = instanceCount;
}

- (void)setInstanceDelay:(CFTimeInterval)instanceDelay {
    _instanceDelay = instanceDelay;
    self.replicatorLayer.instanceDelay = instanceDelay;
}

- (void)setOpacityValue:(CGFloat)opacityValue {
    _opacityValue = opacityValue;
    self.opacityAnima.fromValue = @(opacityValue);
}

- (void)setAnimationDuration:(CFTimeInterval)animationDuration {
    _animationDuration = animationDuration;
    self.animaGroup.duration = animationDuration;
}

- (CAShapeLayer *)pulseLayer {
    if(_pulseLayer == nil) {
        _pulseLayer = [CAShapeLayer layer];
        _pulseLayer.frame = self.layer.bounds;
//        _pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:_pulseLayer.bounds].CGPath;
        _pulseLayer.path = [UIBezierPath bezierPathWithRoundedRect:_pulseLayer.bounds cornerRadius:_pulseLayer.bounds.size.width/2].CGPath;
        _pulseLayer.fillColor = _fillColor.CGColor;
        _pulseLayer.opacity = 0.0;
    }
    
    return _pulseLayer;
}

- (CAReplicatorLayer *)replicatorLayer {
    if(_replicatorLayer == nil) {
        _replicatorLayer = [CAReplicatorLayer layer];
        _replicatorLayer.frame = self.bounds;
        _replicatorLayer.instanceCount = _instanceCount;
        _replicatorLayer.instanceDelay = _instanceDelay;
        [_replicatorLayer addSublayer:self.pulseLayer];
    }
    
    return _replicatorLayer;
}

- (CAAnimationGroup *)animaGroup {
    if(_animaGroup == nil) {
        CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
        
        //根据中间按钮的尺寸，调整中心波纹的起始位置，波纹动画延迟于按钮的旋转动画
        float startValue = (_middleRadarBtn.width / 2) / (self.width / 2);
        scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, startValue, startValue, 0.0)];
        scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
        
        _animaGroup = [CAAnimationGroup animation];
        _animaGroup.animations = @[self.opacityAnima, scaleAnima];
        _animaGroup.duration = _animationDuration;
        _animaGroup.autoreverses = NO;
        _animaGroup.repeatCount = CGFLOAT_MAX;
    }
    
    return _animaGroup;
}

- (CABasicAnimation *)opacityAnima {
    if(_opacityAnima == nil) {
        _opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _opacityAnima.fromValue = @(1.0);
        _opacityAnima.toValue = @(0.0);
    }
    
    return _opacityAnima;
}

- (CABasicAnimation *)middleBtnRotationAnimation {
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1.2f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = ULLONG_MAX;
    
    return rotationAnimation;
}

- (void)setRadarBtnClickedBlock:(PdBtnClickedBlock)radarBtnClickedBlock {
    if (radarBtnClickedBlock) {
        [_middleRadarBtn addBlockForControlEvents:UIControlEventTouchUpInside block:radarBtnClickedBlock];
    }
}

- (void)configRadarIconType:(PdRadarIconType)radarIconType {
    NSString *imageName = nil;
    
    switch (radarIconType) {
        case PdRadarIconTypeRadar:
            imageName = @"fam_home_scene";
            break;
            
        case PdRadarIconTypeScanNoData:
            imageName = @"fam_home_scan_no_data";
            break;
            
        case PdRadarIconTypeNetworkError:
            imageName = @"fam_home_wifi";
            break;
            
        default:
            imageName = @"fam_home_scene";
            break;
    }
    
    [_middleRadarBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_middleRadarBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

@end
