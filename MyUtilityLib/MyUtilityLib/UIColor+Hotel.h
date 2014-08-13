//
//  UIColor+Hotel.h
//  CategoriesExtraction
//
//  Created by  on 4/18/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hotel)

/**
 Returns a color from a HTML/CSS style color specification expressed as an integer.
 @param hexColor An integer representing a color. You can use hex format to express web colors, e.g. 0xAABBCC.
 @return A UIColor represented by the color specification or nil if it was invalid.  The alpha value is set to 100%.
 */
+ (UIColor*)colorWithHex:(NSInteger)hexColor;

+ (UIColor*)haLightGray;

+ (UIColor*) bottomBarItemTextColor;

+ (UIColor*)haTableVIewHeaderTitleColor;

+ (UIColor*)haTableViewHeaderBackgroundColor;

+ (UIColor*)haBlueTitle;

+ (UIColor*)topLabelTextColor;

@end
