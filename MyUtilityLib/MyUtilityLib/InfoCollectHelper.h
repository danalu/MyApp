//
//  InfoCollectHelper.h
//  PR-QR
//
//  Created by Dana on 13-12-27.
//  Copyright (c) 2013年 yek.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 collect log info.
 */

@interface InfoCollectHelper : NSObject

+ (NSString *)sdkVersion;

+ (NSString*)appVersion;

+ (NSString*)appName;

+ (NSString*)iPAddress;

+ (void)recordFirstLaunchTime;

+ (long long)currentSystemTime;

+ (NSString *)systemName;

+ (NSString *)systemVersion;


+ (NSString *)mobileBrand;

+ (NSString *)mobileModel;

+ (NSString *)userAgent;

+ (NSString *)macAdress;

+ (NSString *)timeZone;

+ (long long)activatedTime;

@end
