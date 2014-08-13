//
//  HSUtility.h
//  HotelSDK
//
//  Created by Dana on 5/10/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HSUtility : NSObject

+ (NSString*) appVersion;

+ (void)showLoadingViewWithParentView:(UIView*)view;

+ (void)hideLoadingViewWithParentView:(UIView*)view;

+ (void)HSAlertViewWithTitle:(NSString*)title message:(NSString*)message confirmButtonTitle:(NSString*)confirmButtonTitle cancelButtonTitle:(NSString*)cancelButtonTitle delegate:(id)delegate;

+ (long long)timeIntervalWithDate:(NSDate*)date;

+ (NSString*)dateStringWithTimeInterval:(long long)interval;

+ (BOOL)isNumberAndLetter:(NSString *)str;

@end
