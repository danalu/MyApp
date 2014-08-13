//
//  UIColor+Hotel.m
//  CategoriesExtraction
//
//  Created by  on 4/18/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "UIColor+Hotel.h"

@implementation UIColor (Hotel)

+ (UIColor*)colorWithHex:(NSInteger)hexColor
{
    const NSInteger red = (hexColor & 0xFF0000) >> 16;
    const NSInteger green = (hexColor & 0x00FF00) >> 8;
    const NSInteger blue = (hexColor & 0x0000FF);
    return [UIColor colorWithRed:(CGFloat)red/255.0f green:(CGFloat)green/255.0f blue:(CGFloat)blue/255.0f alpha:1.0f];
}

+ (UIColor*)haLightGray
{
    return [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
}

+ (UIColor*) bottomBarItemTextColor
{
    return [UIColor colorWithRed:0.066 green:0.044 blue:0.318 alpha:1.000];
}

+ (UIColor*)haTableViewHeaderBackgroundColor
{
   return [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
}

+ (UIColor*)haTableVIewHeaderTitleColor
{
    return [UIColor colorWithRed:107.0/255.0 green:107.0/255.0 blue:107.0/255.0 alpha:1.0];
}

+ (UIColor*)haBlueTitle
{
    return [UIColor colorWithRed:120.0/255.0 green:180.0/255.0 blue:220.0/255.0 alpha:1.0];
}

+ (UIColor*)topLabelTextColor
{
    return [UIColor colorWithRed:105.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1.0];
}

@end
