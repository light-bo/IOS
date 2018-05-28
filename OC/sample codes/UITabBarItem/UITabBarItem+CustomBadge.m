//
//  UITabBarItem+CustomBadge.m
//  CityGlance
//
//  Created by Enrico Vecchio on 18/05/14.
//  Copyright (c) 2014 Cityglance SRL. All rights reserved.
//

#import "UITabBarItem+CustomBadge.h"
#import "PdColor.h"


#define CUSTOM_BADGE_TAG 99
#define OFFSET 0.6f


@implementation UITabBarItem (CustomBadge)


- (void)setMyAppCustomBadgeValue:(NSString *)value {
    
    UIFont *myAppFont = [UIFont systemFontOfSize:13.0];
    UIColor *myAppFontColor = [UIColor whiteColor];
    UIColor *myAppBackColor = Pd_App_Organge_Theme_Color;
    
    [self setCustomBadgeValue:value withFont:myAppFont andFontColor:myAppFontColor andBackgroundColor:myAppBackColor];
}



- (void)setCustomBadgeValue:(NSString *)value withFont:(UIFont *)font andFontColor:(UIColor *)color andBackgroundColor:(UIColor *)backColor {
    UIView *v = (UIView *)[self performSelector:@selector(view)];
    [self setBadgeValue:value];

    for(UIView *sv in v.subviews) {
        NSString *str = NSStringFromClass([sv class]);
        
        if([str isEqualToString:@"_UIBadgeView"]) {
            for(UIView *ssv in sv.subviews) {
                // REMOVE PREVIOUS IF EXIST
                if(ssv.tag == CUSTOM_BADGE_TAG) {
                    [ssv removeFromSuperview];
                }
            }
            
            UILabel *customLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sv.frame.size.width, sv.frame.size.height)];
            
            
            [customLabel setFont:font];
            [customLabel setText:value];
            [customLabel setBackgroundColor:backColor];
            [customLabel setTextColor:color];
            [customLabel setTextAlignment:NSTextAlignmentCenter];
            
            customLabel.layer.cornerRadius = customLabel.frame.size.height/2;
            customLabel.layer.masksToBounds = YES;
            
            // Fix for border
            sv.layer.borderWidth = 1;
            sv.layer.borderColor = [backColor CGColor];
            sv.layer.cornerRadius = sv.frame.size.height/2;
            sv.layer.masksToBounds = YES;
            
            
            [sv addSubview:customLabel];
            
            customLabel.tag = CUSTOM_BADGE_TAG;
        }
    }
}





@end
