//
//  PdPopoverMenuModel.m
//  Loopin
//
//  Created by light_bo on 2017/2/17.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "PdPopoverMenuModel.h"

@implementation PdPopoverMenuModel

- (instancetype)initWithImageName:(NSString *)imageName withMenuName:(NSString *)menuName {
    self = [super init];
    if (self) {
        _iconImageName = imageName;
        _menuName = menuName;
    }
    
    return self;
}

@end
