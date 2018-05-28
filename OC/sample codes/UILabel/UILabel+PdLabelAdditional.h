//
//  UILabel+PdLabelAdditional.h
//  iCO
//
//  Created by light_bo on 2017/11/23.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//



@interface UILabel (PdLabelAdditional)

/**
 设置文本,并指定行间距
 
 @param text 文本内容
 @param lineSpacing 行间距
 */
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

- (void)addShadow;

@end
