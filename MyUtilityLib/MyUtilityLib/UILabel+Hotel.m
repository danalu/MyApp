//
//  UILabel+Hotel.m
//  CategoriesExtraction
//
//  Created by  on 4/18/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "UILabel+Hotel.h"
#import "UIFont+Hotel.h"
#import "UIColor+Hotel.h"
#import "UIView+Hotel.h"

@implementation UILabel (Hotel)

- (void)setHs_customFontName:(NSString *)hs_customFontName
{
    self.font = [UIFont fontWithName:hs_customFontName size:self.font.pointSize];
}

- (NSString*)hs_customFontName
{
    return self.font.fontName;
}

+ (UILabel*)transparentLabelWithFont:(UIFont*)font textColor:(UIColor*)color
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = nil;
    label.textColor = color;
    label.font = font;
    label.opaque = NO;
    return label;
}

+ (UILabel*)viewControllerTitleLabelWithText:(NSString*)title
{
    UILabel* titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.font = [UIFont htLightCondensedFontOfSize:21.0f];
    titleView.textColor = [UIColor colorWithHex:0x505050];
    titleView.text = title;
    [titleView sizeToFit];
    return titleView;
}

- (CGFloat)baselinePosition
{
    return CGRectGetMinY(self.frame) + (self.font ? self.font.ascender : 0.0f);
}

- (CGFloat)topInsetToCapital
{
    return [self.font topInsetToCapital];
}

- (CGFloat)bottomInsetToBaseline
{
    return [self.font bottomInsetToBaseline];
}

- (void)alignBaselineWithLabel:(UILabel*)label verticalBaselineSeparation:(CGFloat)separation
{
    if(label.font && self.font)
    {
        CGRect offsetFrame = self.frame;
        offsetFrame.origin.y = roundf([label baselinePosition] - self.font.ascender) + separation;
        self.frame = offsetFrame;
    }
}

#pragma mark - Label Height -
+ (CGFloat) heightForText:(NSString*)text withWidth:(CGFloat)pWidth withFont:(UIFont*)pFont lineBreakMode:(UILineBreakMode) pMode {
    if ([text class] == [NSNull class]) {
        return 0;
    }
	if(text == nil || [text length] == 0)
		return 0;
	
	CGSize constraint = CGSizeMake(pWidth, 4000.0f);
	CGSize theSize = [text sizeWithFont:pFont constrainedToSize:constraint lineBreakMode:pMode];
	return theSize.height;
}

+ (CGFloat) widthForText:(NSString*)text withFont:(UIFont*)pFont withHeight:(CGFloat)pHeight lineBreakMode:(UILineBreakMode) pMode {
	if(text == nil || [text length] == 0)
		return 0;
	
	CGSize constraint = CGSizeMake(4000.0f, pHeight);
	CGSize theSize = [text sizeWithFont:pFont constrainedToSize:constraint lineBreakMode:pMode];
	return theSize.width;
}

@end
