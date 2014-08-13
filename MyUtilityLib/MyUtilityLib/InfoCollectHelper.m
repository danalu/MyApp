//
//  InfoCollectHelper.m
//  PR-QR
//
//  Created by Dana on 13-12-27.
//  Copyright (c) 2013年 yek.com. All rights reserved.
//

#import "InfoCollectHelper.h"
#import <UIKit/UIKit.h>


@implementation InfoCollectHelper

+ (NSString *)sdkVersion {
    return  @"1.0";
}

+ (long long)currentSystemTime {
    NSDate *date = [NSDate date];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return (long long)(timeInterval * 1000);
}

+ (void)recordFirstLaunchTime {
    //record the first launch time.
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if(![userDefault boolForKey:@"firstStart"]){
        [userDefault setBool:YES forKey:@"firstStart"];
        
        long long activitedTime = [InfoCollectHelper currentSystemTime];
        [userDefault setObject:[NSNumber numberWithLongLong:activitedTime] forKey:@"FirstLaunchTime"];
    }else{
        
    }
}

+ (long long)activatedTime {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:@"FirstLaunchTime"] longLongValue];
}

+ (NSString *)timeZone {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = dateFormatter.timeZone;
    return timeZone.abbreviation;
}

+ (NSString *)mobileModel {
    return [UIDevice currentDevice].model;
}

+ (NSString *)systemName {
    return [UIDevice currentDevice].systemName;
}


+ (NSString *)systemVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)mobileBrand {
    return @"apple";
}

+ (NSString *)userAgent {
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectZero];
    NSString *secretAgent=[webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    return secretAgent;
}

+ (NSDictionary *)userLocation {
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Country",@"China",@"province",@"ShangHai",@"City",@"ShangHai", nil];
}

+ (NSString*)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}


@end
