//
//  UINavigationItem+NoBorder.m
//  HotelApp
//
//  Created by xwzhou on 14-6-16.
//
//

#import "UINavigationItem+NoBorder.h"

@implementation UINavigationItem (NoBorder)

- (void)setLeftBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    [self setBarButtonWithImage:image title:nil target:target action:action onLeft:YES];
}

- (void)setRightBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    [self setBarButtonWithImage:image title:nil target:target action:action onLeft:NO];
}

- (void)setLeftBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    [self setBarButtonWithImage:nil title:title target:target action:action onLeft:YES];
}

- (void)setRightBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    [self setBarButtonWithImage:nil title:title target:target action:action onLeft:NO];
}

- (void)setBarButtonWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action onLeft:(BOOL)onLeft {
    UIButton *barButtonCustomView = [[UIButton alloc] initWithFrame:CGRectZero];
    [barButtonCustomView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (image) {
        [barButtonCustomView setImage:image forState:UIControlStateNormal];
    }
    if (title) {
        [barButtonCustomView setTitle:title forState:UIControlStateNormal];
    }
    [barButtonCustomView sizeToFit];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:barButtonCustomView];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        [negativeSpacer setWidth:8];
    }
    
    if (onLeft) {
        self.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, backBtn, nil];
    } else {
        self.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, backBtn, nil];
    }
}

@end
