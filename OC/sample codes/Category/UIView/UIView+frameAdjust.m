//
//  UIView+frameAdjust.m
//  TextCoreText
//
//  Created by 李旭波 on 15/11/8.
//  Copyright © 2015年 李旭波. All rights reserved.
//

#import "UIView+frameAdjust.h"

@implementation UIView (frameAdjust)


- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height);
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x,
                            y,
                            self.frame.size.width,
                            self.frame.size.height);
}

- (CGFloat)width {
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            width,
                            self.frame.size.height);
}


- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
