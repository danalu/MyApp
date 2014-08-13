//
//  UILabel+Hotel.h
//  CategoriesExtraction
//
//  Created by  on 4/18/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Hotel)

@property (nonatomic,copy) NSString* hs_customFontName;

+ (UILabel*)transparentLabelWithFont:(UIFont*)font textColor:(UIColor*)textColor;

+ (UILabel*)viewControllerTitleLabelWithText:(NSString*)title;

- (void)alignBaselineWithLabel:(UILabel*)label verticalBaselineSeparation:(CGFloat)separation;  

+(CGFloat) heightForText:(NSString*)text withWidth:(CGFloat)pWidth withFont:(UIFont*)pFont lineBreakMode:(UILineBreakMode) pMode;

+(CGFloat) widthForText:(NSString*)text withFont:(UIFont*)pFont withHeight:(CGFloat)pHeight lineBreakMode:(UILineBreakMode) pMode;

@end
