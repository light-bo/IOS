//
//  CRSA.h
//  RSADemo
//
//  Created by light_bo on 15/8/3.
//  Copyright (c) 2015年 com.yiniu.www. All rights reserved.
//	depend on openssl and the Base64 lib

#import <Foundation/Foundation.h>
#include <openssl/rsa.h>
#include <openssl/pem.h>
#include <openssl/err.h>

typedef enum {
    KeyTypePublic,
    KeyTypePrivate
}KeyType;

typedef enum {
    RSA_PADDING_TYPE_NONE       = RSA_NO_PADDING,
    RSA_PADDING_TYPE_PKCS1      = RSA_PKCS1_PADDING,
    RSA_PADDING_TYPE_SSLV23     = RSA_SSLV23_PADDING
}RSA_PADDING_TYPE;

@interface CRSA : NSObject{
    RSA *_rsa;
}
+ (id)shareInstance;

- (BOOL)importRSAKeyWithType:(KeyType)type;

- (int)getBlockSizeWithRSA_PADDING_TYPE:(RSA_PADDING_TYPE)padding_type;

- (NSString *) encryptByRsa:(NSString*)content withKeyType:(KeyType)keyType;

- (NSString *) decryptByRsa:(NSString*)content withKeyType:(KeyType)keyType;
@end
