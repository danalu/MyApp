//
//  UIButton+Hotel.m
//  CategoriesExtraction
//
//  Created by  on 4/18/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "UIButton+Hotel.h"
#import "UIImage+Hotel.h"
#import "UIFont+Hotel.h"

@implementation UIButton (Hotel)

- (void)setHs_customFontName:(NSString *)customFontName
{
    self.titleLabel.font = [UIFont fontWithName:customFontName size:self.titleLabel.font.pointSize];
}

- (NSString*)hs_customFontName
{
    return self.titleLabel.font.fontName;
}

+ (UIButton*)navigationButtonWithTitle:(NSString*)title image:(UIImage*)image target:(id)target action:(SEL)action
{
    return [self navigationButtonWithTitle:title titleFont:[UIFont systemFontOfSize:12.0f] titleColor:[UIColor greenColor] image:image target:target action:action];
}

+ (UIButton*)navigationButtonWithTitle:(NSString*)title titleFont:(UIFont *)font titleColor:(UIColor*)color image:(UIImage*)image target:(id)target action:(SEL)action
{
    UIButton* navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if(target && action)
    {
        [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    navButton.titleLabel.font = font;
    [navButton setBackgroundImage:[UIImage horizontallyStretchingImageWithName:@"Need_img"] forState:UIControlStateNormal];
    [navButton setBackgroundImage:[UIImage horizontallyStretchingImageWithName:@"Need_img"] forState:UIControlStateHighlighted];
    [navButton setTitleColor:color forState:UIControlStateNormal];
    [navButton setTitleColor:[color colorWithAlphaComponent:0.6f] forState:UIControlStateHighlighted];
//    const CGFloat verticalOffset = [NavigationBar verticalContentOffsetForMetrics:UIBarMetricsDefault];
//    [navButton setContentEdgeInsets:UIEdgeInsetsMake(verticalOffset, 0, -verticalOffset, 0)];
    [navButton setTitle:title forState:UIControlStateNormal];
    [navButton setImage:image forState:UIControlStateNormal];
    [navButton sizeToFit];
    if(title.length && image)
    {
        [navButton applyAlignment:BIPButtonImageCenterAboveText withMargin:CGSizeZero];
    }
    return navButton;
}

+ (UIButton*)bottomBarButtonWithTitle:(NSString*)title image:(UIImage*)normalImage selectedImage:(UIImage*)selectedImage target:(id)target action:(SEL)action {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    if(target && action)
    {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    [button setBackgroundImage:[UIImage imageNamed:@"bg_tarbar_item.png"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"bg_tarbar_item.png"] forState:UIControlStateSelected];
    
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateHighlighted];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont htFontOfSize:14.0f];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor colorWithRed:0.463 green:0.718 blue:0.894 alpha:1.000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.714 green:0.855 blue:0.953 alpha:1.000] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithRed:0.714 green:0.855 blue:0.953 alpha:1.000] forState:UIControlStateHighlighted];
    
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.contentEdgeInsets = UIEdgeInsetsMake(2.0f, 5.0f, 2.0f, 5.0f);

    return button;
}

+ (UIButton*)topicTypeButtonWithTitle:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectedImage backgroundImage:(UIImage*)backgroundImage selectedBackgroundImage:(UIImage*)selectedBackgroundImage target:(id)target action:(SEL)action {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    if(target && action)
    {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    [button setBackgroundImage:backgroundImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateHighlighted];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont htFontOfSize:14.0f];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor colorWithRed:0.463 green:0.718 blue:0.894 alpha:1.000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.714 green:0.855 blue:0.953 alpha:1.000] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithRed:0.714 green:0.855 blue:0.953 alpha:1.000] forState:UIControlStateHighlighted];
    
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.contentEdgeInsets = UIEdgeInsetsMake(1.0f, 2.0f, 1.0f, 2.0f);
    
    return button;

}

UIEdgeInsets BIPInvertEdgeInsets(UIEdgeInsets insets)
{
    return UIEdgeInsetsMake(-insets.top, -insets.left, -insets.bottom, -insets.right);
}

- (void)applyAlignment:(BIPButtonImageAlignment)alignment withMargin:(CGSize)margin
{
    const CGRect contentFrame = [self contentRectForBounds:self.bounds];
    const CGRect imageFrame = UIEdgeInsetsInsetRect([self imageRectForContentRect:contentFrame], BIPInvertEdgeInsets(self.imageEdgeInsets));
    const CGRect titleFrame = UIEdgeInsetsInsetRect([self titleRectForContentRect:contentFrame], BIPInvertEdgeInsets(self.titleEdgeInsets));
    
    CGPoint titleShift = CGPointZero;
    CGPoint imageShift = CGPointZero;
    switch (alignment)
    {
        case BIPButtonImageLeft:
        {
            titleShift.x = CGRectGetMaxX(contentFrame) - margin.width - CGRectGetMaxX(titleFrame);
            imageShift.x = CGRectGetMinX(contentFrame) + margin.width - CGRectGetMinX(imageFrame);
        }
            break;
            
        case BIPButtonImageRight:
        {
            titleShift.x = CGRectGetMinX(contentFrame) + margin.width - CGRectGetMinX(titleFrame);
            imageShift.x = CGRectGetMaxX(contentFrame) - margin.width - CGRectGetMaxX(imageFrame);
        }
            break;
            
        case BIPButtonImageBelowText:
        {
            titleShift.x = CGRectGetMidX(contentFrame) - CGRectGetMidX(titleFrame);
            titleShift.y = CGRectGetMinY(contentFrame) + margin.height - CGRectGetMinY(titleFrame);
            imageShift.x = CGRectGetMidX(contentFrame) - CGRectGetMidX(imageFrame);
            imageShift.y = CGRectGetMaxY(contentFrame) - margin.height - CGRectGetMaxY(imageFrame);
        }
            break;
            
        case BIPButtonImageAboveText:
        {
            titleShift.x = CGRectGetMidX(contentFrame) - CGRectGetMidX(titleFrame);
            titleShift.y = CGRectGetMaxY(contentFrame) - margin.height - CGRectGetMaxY(titleFrame);
            imageShift.x = CGRectGetMidX(contentFrame) - CGRectGetMidX(imageFrame);
            imageShift.y = CGRectGetMinY(titleFrame) + titleShift.y - margin.height - CGRectGetMaxY(imageFrame);
        }
            break;
            
        case BIPButtonImageCenterAboveText:
        {
            titleShift.x = CGRectGetMidX(contentFrame) - CGRectGetMidX(titleFrame);
            titleShift.y = CGRectGetMaxY(contentFrame) - margin.height - CGRectGetMaxY(titleFrame);
            imageShift.x = CGRectGetMidX(contentFrame) - CGRectGetMidX(imageFrame);
            imageShift.y = 0.5f*(CGRectGetMinY(contentFrame) + margin.height + (CGRectGetMinY(titleFrame) + titleShift.y)) - CGRectGetMidY(imageFrame);
        }
            break;
            
        case BIPButtonImageIgnored:
        {
            return;
        }
            break;
    }
    
    const CGSize titleSize = [self.titleLabel sizeThatFits:contentFrame.size];
    const CGFloat widthCorrection = MAX(0, titleSize.width - titleFrame.size.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(titleShift.y, titleShift.x - widthCorrection*0.5f, -titleShift.y, -titleShift.x - widthCorrection*0.5f);
    self.imageEdgeInsets = UIEdgeInsetsMake(imageShift.y, imageShift.x, -imageShift.y, -imageShift.x);
}

- (BOOL)isVerticalAlignment:(BIPButtonImageAlignment)alignment
{
    return alignment == BIPButtonImageCenterAboveText || alignment == BIPButtonImageAboveText || alignment == BIPButtonImageBelowText;
}

- (CGSize)sizeForAlignment:(BIPButtonImageAlignment)alignment withMargin:(CGSize)margin
{
    CGSize size = [self sizeThatFits:self.bounds.size];
    const CGRect contentFrame = [self contentRectForBounds:self.bounds];
    const CGRect imageFrame = UIEdgeInsetsInsetRect([self imageRectForContentRect:contentFrame], BIPInvertEdgeInsets(self.imageEdgeInsets));
    const CGRect titleFrame = UIEdgeInsetsInsetRect([self titleRectForContentRect:contentFrame], BIPInvertEdgeInsets(self.titleEdgeInsets));
    if([self isVerticalAlignment:alignment])
    {
        size.height = titleFrame.size.height + imageFrame.size.height + 3.0f* margin.height;
    }
    return size;
}

@end
