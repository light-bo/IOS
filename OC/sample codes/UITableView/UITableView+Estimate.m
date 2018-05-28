//
//  UITableView+Estimate.m
//  Famlink
//
//  Created by light_bo on 2018/4/26.
//  Copyright © 2018年 Paramida. All rights reserved.
//

#import "UITableView+Estimate.h"

@implementation UITableView (Estimate)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel = @selector(initWithFrame:style:);
        SEL estimateSel = @selector(pd_initWithFrame:style:);
        
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method estimateMethod = class_getInstanceMethod([self class], estimateSel);
        
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(estimateMethod), method_getTypeEncoding(estimateMethod));
        if (isAdd) {
            class_replaceMethod(self, estimateSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        } else {
            method_exchangeImplementations(systemMethod, estimateMethod);
        }
    });
}

- (instancetype)pd_initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    id obj = [self pd_initWithFrame:frame style:style];
    
    if (@available(iOS 11.0.0, *)) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    
    return obj;
}


@end
