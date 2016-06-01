//
//  NSString+CheckPhoneNumber.h
//  书架
//
//  Created by 贺弘博 on 15/6/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CheckPhoneNumber)
-(BOOL)checkPhoneNumInput;
+(NSString *)isMobileNumber:(NSString *)mobileNum;
@end
