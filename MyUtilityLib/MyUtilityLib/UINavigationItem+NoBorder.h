//
//  UINavigationItem+NoBorder.h
//  HotelApp
//
//  Created by xwzhou on 14-6-16.
//
//

//remove button border at ios6

#import <UIKit/UIKit.h>

@interface UINavigationItem (NoBorder)

- (void)setLeftBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (void)setRightBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (void)setLeftBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

- (void)setRightBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
