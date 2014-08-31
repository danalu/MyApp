//
//  GHInterapp.h
//  MyUtilityLib
//
//  Created by Dana on 8/31/14.
//
//

#import <Foundation/Foundation.h>

@class NIMailAppInvocation;

@interface GHInterapp : NSObject

#pragma mark Safari

+ (BOOL)safariWithURL:(NSURL *)url;
#pragma mark Phone

+ (BOOL)phone;
+ (BOOL)phoneWithNumber:(NSString *)phoneNumber;
#pragma mark SMS

+ (BOOL)sms;
+ (BOOL)smsWithNumber:(NSString *)phoneNumber;
#pragma mark Mail

+ (BOOL)mailWithInvocation:(NIMailAppInvocation *)invocation;
#pragma mark App Store

+ (BOOL)appStoreWithAppId:(NSString *)appId;
+ (BOOL)appStoreGiftWithAppId:(NSString *)appId;
+ (BOOL)appStoreReviewWithAppId:(NSString *)appId;
#pragma mark Custom Application

+ (BOOL)applicationIsInstalledWithScheme:(NSString *)applicationScheme;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme andAppStoreId:(NSString *)appStoreId;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme andPath:(NSString *)path;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme appStoreId:(NSString *)appStoreId andPath:(NSString *)path;

@end

@interface NIMailAppInvocation : NSObject {
@private
    NSString* _recipient;
    NSString* _cc;
    NSString* _bcc;
    NSString* _subject;
    NSString* _body;
}

@property (nonatomic, copy) NSString* recipient;
@property (nonatomic, copy) NSString* cc;
@property (nonatomic, copy) NSString* bcc;
@property (nonatomic, copy) NSString* subject;
@property (nonatomic, copy) NSString* body;

/**
 * Returns an autoreleased invocation object.
 */
+ (id)invocation;

@end

