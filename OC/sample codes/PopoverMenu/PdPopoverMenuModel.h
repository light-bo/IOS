//
//  PdPopoverMenuModel.h
//  Loopin
//
//  Created by light_bo on 2017/2/17.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PdPopoverMenuModel : NSObject

- (instancetype)initWithImageName:(NSString *)imageName withMenuName:(NSString *)menuName;

@property (nonatomic, strong) NSString *iconImageName;
@property (nonatomic, strong) NSString *menuName;

@end
