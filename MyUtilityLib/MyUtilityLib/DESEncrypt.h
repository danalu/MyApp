//
//  DESEncrypt.h
//  PR-QR
//
//  Created by Dana on 14-1-2.
//  Copyright (c) 2014年 yek.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 encrypt text with DES.
 */

@interface DESEncrypt : NSObject

/**
 encrypt the string.
 @param sText the encrypt string.
 @param aKey the key used encrypt.
 */
+ (NSString *)encryptWithText:(NSString *)sText theKey:(NSString *)aKey;

/**
 decrypt the string.
 @param sText the decrypt string.
 @param aKey the key used decrypt.
 */
+ (NSString *)decryptWithText:(NSString *)sText theKey:(NSString *)aKey;

@end
