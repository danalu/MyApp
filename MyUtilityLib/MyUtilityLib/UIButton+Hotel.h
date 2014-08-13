//
//  UIButton+Hotel.h
//  CategoriesExtraction
//
//  Created by  on 4/18/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @enum BIPButtonImageAlignment
 
 Place the button image relative to its title.
 */
typedef enum
{
    BIPButtonImageLeft,             //!< The button image appears to the left of the title.
    BIPButtonImageRight,            //!< The button image appears to the right of the title.
    BIPButtonImageAboveText,        //!< The button image appears above the title.
    BIPButtonImageBelowText,        //!< The button image appears below the title.
    BIPButtonImageCenterAboveText,  //!< The button image appears between the title and the top.
    BIPButtonImageIgnored           //!< The button image and title are not adjusted.
} BIPButtonImageAlignment;

/**
 Some convenience methods for UIButton.
 */
@interface UIButton (Hotel)

@property (nonatomic,copy) NSString* hs_customFontName;

+ (UIButton*)navigationButtonWithTitle:(NSString*)title image:(UIImage*)image target:(id)target action:(SEL)action;

+ (UIButton*)navigationButtonWithTitle:(NSString*)title titleFont:(UIFont*)font titleColor:(UIColor*)color image:(UIImage*)image target:(id)target action:(SEL)action;

+ (UIButton*)bottomBarButtonWithTitle:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectedImage target:(id)target action:(SEL)action;

+ (UIButton*)topicTypeButtonWithTitle:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectedImage backgroundImage:(UIImage*)backgroundImage selectedBackgroundImage:(UIImage*)selectedBackgroundImage target:(id)target action:(SEL)action;

- (void)applyAlignment:(BIPButtonImageAlignment)alignment withMargin:(CGSize)margin;

- (CGSize)sizeForAlignment:(BIPButtonImageAlignment)alignment withMargin:(CGSize)margin;


@end
