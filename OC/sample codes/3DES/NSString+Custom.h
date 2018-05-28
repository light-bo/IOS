//
//  NSString+Custom.h
//  Loopin
//
//  Created by light_bo on 2016/11/19.
//  Copyright © 2016年 Paramida-Di. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PdPhoneModel;

@interface NSString (Custom)

/**
 时间格式化
 */
- (NSString *)formatTimeStampToHumanReadableString;


- (float)textWidthWithFontSize:(NSInteger)fontSize;

/**
 *  消息小红点显示格式
 */
+ (NSString *)formatBadgeString:(NSInteger)msgAmount;


/**
 对 Apns 返回的 device token 格式处理
 */
- (NSString *)deviceTokenHexString;



/**
 解析后台图片返回的尺寸 
 后台链接格式如下：
 http://loopin.oss-ap-southeast-1.aliyuncs.com/ico/p960x1324/compress_proportion_328aad08e9f4b9cfbbdb58efc6d249ac.jpg

 @return 图片的尺寸
 */
- (CGSize)imageSizeOfURL;




/**
 根据指定的字体和颜色将普通 NSString 转化为 NSMutableAttributedString
 */
- (NSMutableAttributedString *)formatAsAttributeStrinWithFont:(UIFont *)font textColor:(UIColor *)textColor;



/**
 是否只包含数字
 */
- (BOOL)onlyContainNumber;


/**
 3DES 加密

 @return 密文
 */
- (NSString *)tripleDESAlgorithmEncrypt;



/**
 3DES 解密

 @return 明文
 */
- (NSString *)tripleDESAlgorithmDecrypt;


/**
 将 “86-18825182179” 格式的字符串解析出区号和手机号码
 */
- (PdPhoneModel *)resolveEntirePhoneNumber;

- (NSString *)sexString;

- (NSString *)analysisDateFormatString;


@end
