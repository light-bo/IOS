//
//  NSString+Custom.m
//  Loopin
//
//  Created by light_bo on 2016/11/19.
//  Copyright © 2016年 Paramida-Di. All rights reserved.
//

#import "NSString+Custom.h"
#import "LanguageControl.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "PdPhoneModel.h"

//密匙 key
#define gkey @"VimZ2kYr48bEiNnyy7DbMX86"

//偏移量
#define gIv @"4lcWDa65"

@implementation NSString (Custom)

- (NSString *)formatTimeStampToHumanReadableString {
    NSDate *dates = [NSDate dateWithTimeIntervalSince1970:[self floatValue]];
    
    NSTimeInterval late = [dates timeIntervalSince1970];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    NSString *timeString = @"";
    
    NSTimeInterval timeInterval = now - late;
    
    if (timeInterval/3600 < 1) {
        timeString = [NSString stringWithFormat:@"%f", timeInterval/60];
        //timeString = [timeString substringToIndex:timeString.length-7];
        NSInteger min = [timeString integerValue];
        if(min <= 0) {
            timeString = LANGUAGE(@"loopin_just_now");
        } else {
            timeString = [NSString stringWithFormat:@"%zd %@", min, LANGUAGE(@"loopin_minute_ago")];
        }
    } else if (timeInterval/3600>1 && timeInterval/86400<1) {
        NSTimeInterval cha = now - late;
        int hours = ((int)cha) % (3600 * 24) / 3600;
        timeString = [NSString stringWithFormat:@"%d %@", hours, LANGUAGE(@"loopin_hour_ago")];
    } else if (timeInterval/86400>1) {
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"MM-dd"];
        timeString = [NSString stringWithFormat:@"%@", [dateformatter stringFromDate:dates]];
    }
    
    return timeString;
}


+ (NSString *)formatBadgeString:(NSInteger)msgAmount {
    if (msgAmount <= 0) {
        return nil;
    } else {
        if (msgAmount > 99) {
            return @"99+";
        } else {
            return [NSString stringWithFormat:@"%zd", msgAmount];
        }
    }
}

- (float)textWidthWithFontSize:(NSInteger)fontSize {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return rect.size.width;
}


- (NSString *)deviceTokenHexString {
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
}


//http://loopin.oss-ap-southeast-1.aliyuncs.com/ico/p960x1324/compress_proportion_328aad08e9f4b9cfbbdb58efc6d249ac.jpg
- (CGSize)imageSizeOfURL {
    NSURL *url = [NSURL URLWithString:self];
    
    NSArray *pathComponentString = url.pathComponents;
    if (pathComponentString.count < 4) {
        return CGSizeMake(0, 0);
    }
    
    NSString *sizeString = [pathComponentString objectAtIndex:2];
    NSArray *sizePartArray = [sizeString componentsSeparatedByString:@"x"];
    if (sizePartArray.count < 2) {
        return CGSizeMake(0, 0);
    }
    
    NSString *leftPartWidthOriginalString = [sizePartArray objectAtIndex:0];
    NSString *rightPartHeightOriginalString = [sizePartArray objectAtIndex:1];
    if ((leftPartWidthOriginalString.length<2) || (rightPartHeightOriginalString.length<=0)) {
        return CGSizeMake(0, 0);
    }
    
    
    NSString *widthString = [leftPartWidthOriginalString substringFromIndex:1];//去掉前面的字母 p
    if ((![widthString onlyContainNumber]) || (![rightPartHeightOriginalString onlyContainNumber])) {
        return CGSizeMake(0, 0);
    }
    
    
    return CGSizeMake([widthString floatValue], rightPartHeightOriginalString.floatValue);
}


- (NSMutableAttributedString *)formatAsAttributeStrinWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    if (self.length <= 0) {
        return nil;
    }
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributeString addAttribute:NSForegroundColorAttributeName
                        value:textColor
                        range:NSMakeRange(0, self.length)];
    [attributeString addAttribute:NSFontAttributeName
                        value:font
                        range:NSMakeRange(0, self.length)];
    
    return attributeString;
}

- (BOOL)onlyContainNumber {
    NSString *regex = @"^[0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:self];
}

- (NSString *)tripleDESAlgorithmEncrypt {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    //length
    size_t plainTextBufferSize = [data length];
    
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    //偏移量
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    //配置CCCrypt
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES, //3DES
                       kCCOptionPKCS7Padding, //设置模式
                       vkey,    //key
                       kCCKeySize3DES,
                       vinitVec,     //偏移量，这里不用，设置为nil;不用的话，必须为nil,不可以为@“”
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [myData base64EncodedStringWithOptions:0];
    
    return result;
}

- (NSString *)tripleDESAlgorithmDecrypt {
    NSData *encryptData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    
    
    return result;
}


- (PdPhoneModel *)resolveEntirePhoneNumber {
    if (self.length <= 0) {
        return nil;
    }
    
    NSArray *phoneNumberComponents = [self componentsSeparatedByString:@"-"];
    if (phoneNumberComponents.count < 2) {
        return nil;
    }
    
    PdPhoneModel *phoneModel = [PdPhoneModel new];
    phoneModel.countryPhoneCode = phoneNumberComponents[0];
    phoneModel.phoneNumber = phoneNumberComponents[1];
    
    return phoneModel;
}

- (NSString *)sexString {
    if ((self.length <= 0) || [self isEqualToString:@"0"]) {
        return LANGUAGE(@"loopin_secrecy");
    } else if ([self isEqualToString:@"1"]) {
        return LANGUAGE(@"loopin_male");
    } else if ([self isEqualToString:@"2"]) {
        return LANGUAGE(@"loopin_female");
    } else {
        return nil;
    }
}

- (NSString *)analysisDateFormatString {
    NSArray<NSString *> *dateComponent = [self componentsSeparatedByString:@"-"];
    if (dateComponent.count < 3) {
        return @"MM-dd-yyyy";
    }
    
    NSString *firstComponent = [dateComponent firstObject];
    if (firstComponent.length >= 4) {
        return @"yyyy-MM-dd";
    } else {
        return @"MM-dd-yyyy";
    }
}


@end

