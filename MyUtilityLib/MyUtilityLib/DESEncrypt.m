//
//  DESEncrypt.m
//  PR-QR
//
//  Created by Dana on 14-1-2.
//  Copyright (c) 2014年 yek.com. All rights reserved.
//

#import "DESEncrypt.h"
#import "GTMBase64.h"

#define KEncryptIV @"pas2Prcd"

@implementation DESEncrypt

#import <CommonCrypto/CommonCryptor.h>

+ (NSString *)encryptWithText:(NSString *)sText theKey:(NSString *)aKey {
    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt key:aKey];
}


+ (NSString *)decryptWithText:(NSString *)sText theKey:(NSString *)aKey {
    return [self encrypt:sText encryptOrDecrypt:kCCDecrypt key:aKey];
}

+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key {
    
    const void *vplainText;
    
    size_t plainTextBufferSize;
    
    if (encryptOperation == kCCDecrypt) {
        
        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];
        
        plainTextBufferSize = [decryptData length];
        
        vplainText = [decryptData bytes];
        
    } else {
        
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        
        plainTextBufferSize = [encryptData length];
        
        vplainText = (const void *)[encryptData bytes];
        
    }
    
    uint8_t *bufferPtr = NULL;
    
    size_t bufferPtrSize = 0;
    
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    NSString *initVec = KEncryptIV;
    
    const void *vkey = (const void *) [key UTF8String];
    
    const void *vinitVec = (const void *) [initVec UTF8String];
        
    CCCryptorStatus ccStatus = CCCrypt(encryptOperation,
                                       
                                       kCCAlgorithmDES,
                                       
                                       kCCOptionPKCS7Padding,
                                       
                                       vkey,
                                       
                                       kCCKeySizeDES,
                                       
                                       vinitVec,
                                       
                                       vplainText,
                                       
                                       plainTextBufferSize,
                                       
                                       (void *)bufferPtr,
                                       
                                       bufferPtrSize,
                                       
                                       &movedBytes);
    
    NSString *result = nil;
    
    if (ccStatus == kCCSuccess) {
        
        if (encryptOperation == kCCDecrypt) {
            
            result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
            
        } else {
            
            NSData *data = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
            
            result = [GTMBase64 stringByEncodingData:data];
        }
    }
    
    return result;
}

@end
