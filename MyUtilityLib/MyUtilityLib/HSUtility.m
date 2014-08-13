//
//  HSUtility.m
//  HotelSDK
//
//  Created by Dana on 5/10/14.
//
//

#import "HSUtility.h"
#import "HSBusyIndicatorView.h"
#import "UIView+Hotel.h"

static CGFloat KLoadingViewTag = 1010101011010;

@implementation HSUtility


+ (NSString*) appVersion
{
   return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (void)showLoadingViewWithParentView:(UIView*)view {
    UIView *loadingView = [[UIView alloc] initWithFrame:view.bounds];
    loadingView.backgroundColor = [UIColor clearColor];
    loadingView.tag = KLoadingViewTag;
    [view addSubview:loadingView];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:loadingView.bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.1;
    [loadingView addSubview:backgroundView];
    
    HSBusyIndicatorView *indicatorView = [[HSBusyIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [loadingView addSubview:indicatorView];
    indicatorView.innerBackgroundColor = [UIColor clearColor];
    
    [indicatorView centerInFrame:loadingView.bounds axes:HSViewAxisX | HSViewAxisY];
}

+ (void)hideLoadingViewWithParentView:(UIView*)view {
    UIView *loadingView = [view viewWithTag:KLoadingViewTag];
    if (loadingView) {
        [loadingView removeFromSuperview];
    }
}

+ (void)HSAlertViewWithTitle:(NSString*)title message:(NSString*)message confirmButtonTitle:(NSString*)confirmButtonTitle cancelButtonTitle:(NSString*)cancelButtonTitle delegate:(id)delegate {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:confirmButtonTitle otherButtonTitles:cancelButtonTitle, nil];
    [alertView show];
}

+ (long long)timeIntervalWithDate:(NSDate*)date {
    return [date timeIntervalSince1970] * 1000;
}

+ (NSString*)dateStringWithTimeInterval:(long long)interval {
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    dataFormatter.dateFormat = @"yyyy-M-d HH:mm aa";
   return [dataFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:interval / 1000]];
}

//只能由字母和数字组成
+ (BOOL)isNumberAndLetter:(NSString *)str
{
    NSString *numberAndLetterRegex = @"^\\w+$";
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:numberAndLetterRegex options:0 error:nil];
    
    if (regex2)
    {//对象进行匹配
        
        NSTextCheckingResult *result2 = [regex2 firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
        if (result2)
        {
            return YES;
        }
    }
    return NO;
}


@end
