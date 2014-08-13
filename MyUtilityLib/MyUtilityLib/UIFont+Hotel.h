//
//  UIFont+Hotel.h
//  CategoriesExtraction
//
//  Created by  on 4/18/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Hotel)

+ (UIFont*)htFontOfSize:(CGFloat)size;
+ (UIFont*)htLightFontOfSize:(CGFloat)size;
+ (UIFont*)htBoldFontOfSize:(CGFloat)size;
+ (UIFont*)htLightCondensedFontOfSize:(CGFloat)size;
+ (UIFont*)htJhengHeiFontOfSize:(CGFloat)size;

- (CGFloat)topInsetToCapital;           //!< The (positive) distance from the top of the line to the top of the capital letters in the font.

- (CGFloat)bottomInsetToBaseline;       //!< The (positive) distance from the bottom of the line to the baseline of the font.

@end
