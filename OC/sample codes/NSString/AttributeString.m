//使字符串分成两段不同的字体（大小和颜色）
- (NSMutableAttributedString *)generateAttributeStringWithString:(NSString *)originString
                                               withStartPosition:(NSInteger)startIndex
                                                      withLength:(NSInteger)length
                                         withHeightlightFontName:(NSString *)fontName {
                                             
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:originString];
    
    [attriStr addAttribute:NSForegroundColorAttributeName
                     value:[UIColor blackColor]
                     range:NSMakeRange(startIndex, length)];
    
    [attriStr addAttribute:NSFontAttributeName
                     value:[UIFont fontWithName:fontName size:14]
                     range:NSMakeRange(startIndex, length)];
    
    long redisualLength = originString.length - length;
    [attriStr addAttribute:NSForegroundColorAttributeName
                     value:ColorFromRGB(0x999999)
                     range:NSMakeRange(length, redisualLength)];
    
    [attriStr addAttribute:NSFontAttributeName
                     value:[UIFont systemFontOfSize:14]
                     range:NSMakeRange(length, redisualLength)];
    
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0f];
    
    [attriStr addAttribute:NSParagraphStyleAttributeName
                     value:paragraphStyle
                     range:NSMakeRange(0, originString.length)];
    
    return attriStr;
}