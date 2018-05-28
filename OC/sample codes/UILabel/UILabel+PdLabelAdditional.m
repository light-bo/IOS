//
//  UILabel+PdLabelAdditional.m
//  iCO
//
//  Created by light_bo on 2017/11/23.
//  Copyright © 2017年 Paramida-Di. All rights reserved.
//

#import "UILabel+PdLabelAdditional.h"

@implementation UILabel (PdLabelAdditional)


- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}

- (void)addShadow {
    self.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 0.8;
}

@end
