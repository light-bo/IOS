//
//  CircularTopBtn.h
//  红色悬浮按钮
//
//  Created by 李旭波 on 15/11/8.
//  Copyright © 2015年 李旭波. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CircularTopBtnDelegate <NSObject>

- (void)circularTopBtnDidClicked;

@end




@interface CircularTopBtn : UIWindow

+ (instancetype)shareInstance;
- (void)show;
- (void)hide;

@property (nonatomic, weak) id<CircularTopBtnDelegate> delegate;


@end
