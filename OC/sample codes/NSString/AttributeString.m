/*
 *
 * 使字符串分成两段不同的字体（大小和颜色）
 * @param originString 需要显示不同字体的字符串
 * @param firstPartColor 第一段文本的字体颜色
 * @param firstPartFont 第一段文本使用的字体（大小，何种字体）
 * @param length 第一段文本的长度
 * @param secondPartColor 第二段文本的字体颜色
 * @param secondPartFont 第二段文本使用的字体（大小，何种字体）
 * @param lineSpace 行间距
 *
 * @return 采用了相关字体的富文本
 */
+ (NSMutableAttributedString *)generateAttributeStringWithString:(NSString *)originString
                                              withFirstPartColor:(UIColor *)firstPartColor
                                               withFirstPartFont:(UIFont *)firstPartFont
                                             withFristPartLength:(NSInteger)length
                                            nwithSecondPartColor:(UIColor *)secondPartColor
                                              withSecondPartFont:(UIFont *)secondPartFont
                                                   withLineSpace:(float)lineSpace {
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:originString];
    
    [attriStr addAttribute:NSForegroundColorAttributeName
                     value:firstPartColor
                     range:NSMakeRange(0, length)];
    
    [attriStr addAttribute:NSFontAttributeName
                     value:firstPartFont
                     range:NSMakeRange(0, length)];
    
    long redisualLength = originString.length - length;
    [attriStr addAttribute:NSForegroundColorAttributeName
                     value:secondPartColor
                     range:NSMakeRange(length, redisualLength)];
    
    [attriStr addAttribute:NSFontAttributeName
                     value:secondPartFont
                     range:NSMakeRange(length, redisualLength)];
    
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    
    [attriStr addAttribute:NSParagraphStyleAttributeName
                     value:paragraphStyle
                     range:NSMakeRange(0, originString.length)];
    
    
    return attriStr;
}
