//
//  FadedArcLayer.h
//  HibuSearch
//
//  Created by Tom York on 04/07/2013.
//  Copyright (c) 2013 HIBU. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
/**
 Draws an arc that fades out towards its ends.
 */
@interface HSFadingGradientArcLayer : CALayer

/**
 The width of the arc in points.
 */
@property (nonatomic) CGFloat lineWidth;

/**
 The distance in points over which the arc fades.
 */
@property (nonatomic) CGFloat fadeDistance;

/**
 The arc color.
 */
@property (nonatomic) UIColor* arcColor;

/**
 The arc's span, how much of a full circle it occupies.
 Clamped to the range from 0.0 to 1.0.
 */
@property (nonatomic) CGFloat span;

@end
