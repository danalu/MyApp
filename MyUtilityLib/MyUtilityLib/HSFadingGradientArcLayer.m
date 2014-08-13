//
//  FadedArcLayer.m
//  HibuSearch
//
//  Created by Tom York on 04/07/2013.
//  Copyright (c) 2013 HIBU. All rights reserved.
//

#import "HSFadingGradientArcLayer.h"

@implementation HSFadingGradientArcLayer

- (void)setArcColor:(UIColor *)arcColor
{
    if(_arcColor != arcColor)
    {
        _arcColor = arcColor;
        [self setNeedsDisplay];
    }
}

- (void)setFadeDistance:(CGFloat)fadeDistance
{
    if(_fadeDistance != fadeDistance)
    {
        _fadeDistance = fadeDistance;
        [self setNeedsLayout];
    }
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    if(_lineWidth != lineWidth)
    {
        _lineWidth = lineWidth;
        [self setNeedsDisplay];
    }
}

- (void)setSpan:(CGFloat)span
{
    if(_span != span)
    {
        _span = MAX(MIN(1.0f, span), 0.0f);
        [self setNeedsDisplay];
    }
}

- (UIBezierPath*)arcPathInRect:(CGRect)rect fractionOfCircle:(CGFloat)fraction
{
    const CGPoint centerPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat radius = floorf(0.5f*(MIN(rect.size.width, rect.size.height) - self.lineWidth));
    const CGFloat startAngle = (M_PI * (1.0f - fraction));
    const CGFloat endAngle = (M_PI * (1.0f + fraction));
    return [UIBezierPath bezierPathWithArcCenter:centerPoint
                                          radius:radius
                                      startAngle:startAngle
                                        endAngle:endAngle
                                       clockwise:YES];
}

- (void)drawInContext:(CGContextRef)ctx
{
    const CGFloat squareSize = MIN(self.bounds.size.width, self.bounds.size.height);
    const CGRect layoutRect = CGRectMake(0, 0, squareSize, squareSize);
    UIBezierPath* path = [self arcPathInRect:layoutRect fractionOfCircle:self.span];
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextAddPath(ctx, path.CGPath);
    CGContextReplacePathWithStrokedPath(ctx);
    CGContextClip(ctx);
        
    const CGFloat locations[3] = { 0.0f, 0.5f, 1.0f };
    NSArray* colors = @[
            (id)self.arcColor.CGColor,
            (id)self.arcColor.CGColor,
            (id)[self.arcColor colorWithAlphaComponent:0.0f].CGColor
    ];
    const CGPoint drawCenter = CGPointMake(floorf(self.lineWidth/2), CGRectGetMidY(layoutRect));
    const CGFloat circleRadius = floorf(M_PI*layoutRect.size.width*self.span*0.5f);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)(colors), locations);
    CGContextDrawRadialGradient(ctx, gradient, drawCenter, 0, drawCenter, circleRadius, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

}

@end
