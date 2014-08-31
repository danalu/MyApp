//
//  GHInterapp.m
//  MyUtilityLib
//
//  Created by Dana on 8/31/14.
//
//

#import "GHInterapp.h"
#import <UIKit/UIKit.h>

@implementation GHInterapp

+ (NSString *)sanitizedPhoneNumberFromString:(NSString *)string {
    if (nil == string) {
        return nil;
    }
    
    NSCharacterSet* validCharacters = [NSCharacterSet characterSetWithCharactersInString:@"1234567890-+"];
    return [[string componentsSeparatedByCharactersInSet:[validCharacters invertedSet]]
            componentsJoinedByString:@""];
}

#pragma mark - Safari

+ (BOOL)safariWithURL:(NSURL *)url {
    return [[UIApplication sharedApplication] openURL:url];
}
#pragma mark - Phone

+ (BOOL)phone {
    return [self phoneWithNumber:nil];
}

+ (BOOL)phoneWithNumber:(NSString *)phoneNumber {
    phoneNumber = [self sanitizedPhoneNumberFromString:phoneNumber];
    
    if (nil == phoneNumber) {
        phoneNumber = @"";
    }
    
    NSString* urlPath = [@"tel:" stringByAppendingString:phoneNumber];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

#pragma mark - Texting

+ (BOOL)sms {
    return [self smsWithNumber:nil];
}

+ (BOOL)smsWithNumber:(NSString *)phoneNumber {
    phoneNumber = [self sanitizedPhoneNumberFromString:phoneNumber];
    
    if (nil == phoneNumber) {
        phoneNumber = @"";
    }
    
    NSString* urlPath = [@"sms:" stringByAppendingString:phoneNumber];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

#pragma mark - Mail

static NSString* const sMailScheme = @"mailto:";

+ (BOOL)mailWithInvocation:(NIMailAppInvocation *)invocation {
//    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
//    
//    NSString* urlPath = sMailScheme;
//    
//    if (NIIsStringWithAnyText(invocation.recipient)) {
////        urlPath = [urlPath stringByAppendingString:NIStringByAddingPercentEscapesForURLParameterString(invocation.recipient)];
//    }
//    
//    if (NIIsStringWithAnyText(invocation.cc)) {
//        [parameters setObject:invocation.cc forKey:@"cc"];
//    }
//    if (NIIsStringWithAnyText(invocation.bcc)) {
//        [parameters setObject:invocation.bcc forKey:@"bcc"];
//    }
//    if (NIIsStringWithAnyText(invocation.subject)) {
//        [parameters setObject:invocation.subject forKey:@"subject"];
//    }
//    if (NIIsStringWithAnyText(invocation.body)) {
//        [parameters setObject:invocation.body forKey:@"body"];
//    }
//    
//    urlPath = NIStringByAddingQueryDictionaryToString(urlPath, parameters);
//    
//    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
    
    return NO;
}

#pragma mark - Application

+ (BOOL)applicationIsInstalledWithScheme:(NSString *)applicationScheme {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:applicationScheme]];
}

+ (BOOL)applicationWithScheme:(NSString *)applicationScheme {
    return [self applicationWithScheme:applicationScheme
                            appStoreId:nil
                               andPath:nil];
}

+ (BOOL)applicationWithScheme:(NSString *)applicationScheme
                andAppStoreId:(NSString *)appStoreId {
    return [self applicationWithScheme:applicationScheme
                            appStoreId:appStoreId
                               andPath:nil];
}

+ (BOOL)applicationWithScheme:(NSString *)applicationScheme
                      andPath:(NSString *)path {
    return [self applicationWithScheme:applicationScheme
                            appStoreId:nil
                               andPath:path];
}

+ (BOOL)applicationWithScheme:(NSString *)applicationScheme
                   appStoreId:(NSString *)appStoreId
                      andPath:(NSString *)path {
    BOOL didOpen = false;
    NSString* urlPath = applicationScheme;
    
    // Were we passed a path?
    if (path != nil) {
        // Generate the full application URL
        urlPath = [urlPath stringByAppendingFormat:@"%@", path];
    }
    
    // Try to open the application URL
    didOpen = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
    
    // Didn't open and we have an appStoreId
    if (!didOpen && appStoreId != nil) {
        // Open the app store instead
        didOpen = [self appStoreWithAppId:appStoreId];
    }
    
    return didOpen;
}
#pragma mark - App Store

+ (BOOL)appStoreWithAppId:(NSString *)appId {
    NSString* urlPath = [@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=" stringByAppendingString:appId];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

+ (BOOL)appStoreGiftWithAppId:(NSString *)appId {
    NSString* urlPath = [NSString stringWithFormat:@"itms-appss://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/giftSongsWizard?gift=1&salableAdamId=%@&productType=C&pricingParameter=STDQ&mt=8&ign-mscache=1", appId];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

+ (BOOL)appStoreReviewWithAppId:(NSString *)appId {
    NSString* urlPath = [@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=" stringByAppendingString:appId];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

@end

@implementation NIMailAppInvocation

+ (id)invocation {
    return [[[self class] alloc] init];
}


@end
