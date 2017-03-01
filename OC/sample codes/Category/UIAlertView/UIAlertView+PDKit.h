//
//  UIAlertView+NTESBlock.h
//  eim_iphone
//
//  Created by amao on 12-11-7.
//  Copyright (c) 2012年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PdAlertViewBlock)(NSInteger index);

@interface UIAlertView (PDKit)

- (void)showAlertViewWithCompletionHandler:(PdAlertViewBlock)block;
- (void)clearActionBlock;


@end
