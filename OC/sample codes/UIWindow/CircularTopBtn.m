//
//  CircularTopBtn.m
//  TestIOS
//
//  Created by 李旭波 on 15/11/8.
//  Copyright © 2015年 李旭波. All rights reserved.
//

#import "CircularTopBtn.h"

@implementation CircularTopBtn {
    UIButton *_suspendBtn;
}


+ (instancetype)shareInstance {
    static CircularTopBtn *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CircularTopBtn alloc] initWithFrame:CGRectMake(100, 100, 80, 80)
                                               withColor:[UIColor redColor]
                                               withTitle:@"悬浮"];
    });
    
    return instance;
}


- (instancetype)initWithFrame:(CGRect)frame
                    withColor:(UIColor *)color
                    withTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    
    if(self) {
        self.windowLevel= UIWindowLevelNormal + 1;
        self.backgroundColor = color;
        self.layer.cornerRadius = frame.size.width/2;
        self.layer.masksToBounds = YES;
        
        _suspendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_suspendBtn setTitle:title forState:UIControlStateNormal];
        _suspendBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [_suspendBtn addTarget:self
                        action:@selector(circularTopBtnClicked)
              forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_suspendBtn];
    }
    
    return self;
}



- (void)show {
    [self makeKeyAndVisible];//加载到屏幕并显示出来
}

- (void)hide {
    [self resignKeyWindow];
    [self setHidden:YES];
}

- (void)circularTopBtnClicked {
    [self.delegate circularTopBtnDidClicked];
}


@end
