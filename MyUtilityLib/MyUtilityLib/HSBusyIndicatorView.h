//
//  BusyIndicatorView.h
//  HibuSearch
//
//  Created by Tom York on 02/07/2013.
//  Copyright (c) 2013 HIBU. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A view that indicates a busy state.
 */
@interface HSBusyIndicatorView : UIView

/**
 The width of the border containing the animated indication, in points.
 */
@property (nonatomic) CGFloat lineWidth;

/**
 The distance in points over which the indication gradient goes from the busy color to transparency.
 */
@property (nonatomic) CGFloat fadeDistance;

/**
 The busy indicator active color.
 */
@property (nonatomic) UIColor* busyColor;

/**
 The busy indicator's inner background color.
 */
@property (nonatomic) UIColor* innerBackgroundColor;

/**
 The busy indicator's outer background color.
 */
@property (nonatomic) UIColor* outerBackgroundColor;

/**
 The busy indicator's span, how much of a full circle it fills.
 Clamped from 0.0f to 1.0f range.
 */
@property (nonatomic) CGFloat span;

/**
 The duration of the arc rotation.
 default is 0.25
 */
@property (nonatomic) CGFloat rotationDuration;

/**
 Generate a busy indicator view that's good for white or very bright backgrounds.
 */
+ (instancetype)transparentBackgroundBusyIndicatorWithSize:(CGSize)size;

/**
 Generate a busy indicator view that's good for darker backgrounds.
 */
+ (instancetype)solidBackgroundBusyIndicatorWithSize:(CGSize)size;

/**
 Apply transparent styling.
 */
- (void)applyTransparentBusyIndicatorStyle;

/**
 Apply darker styling.
 */
- (void)applySolidBusyIndicatorStyle;

@end
