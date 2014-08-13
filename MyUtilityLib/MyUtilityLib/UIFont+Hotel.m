//
//  UIFont+Hotel.m
//  CategoriesExtraction
//
//  Created by  on 4/18/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "UIFont+Hotel.h"

@implementation UIFont (Hotel)

+ (UIFont*)htFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont*)htLightFontOfSize:(CGFloat)size;
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

+ (UIFont*)htBoldFontOfSize:(CGFloat)size;
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

+ (UIFont*)htLightCondensedFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-LightCond" size:size];
}

+ (UIFont*)htJhengHeiFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@" Microsoft JhengHei" size:size];

}

- (CGFloat)topInsetToCapital
{
    return self.ascender - self.capHeight;
}

- (CGFloat)bottomInsetToBaseline
{
    return self.lineHeight - self.ascender;
}

@end
