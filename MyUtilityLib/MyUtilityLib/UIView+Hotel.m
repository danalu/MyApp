//
//  UIView+Hotel.m
//  CategoriesExtraction
//
//  Created by  on 4/18/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "UIView+Hotel.h"

@implementation UIView (Hotel)

- (void)fillFromFrame:(CGRect)minFrame toFrame:(CGRect)maxFrame axis:(HSViewAxis)axis margin:(CGSize)margin
{
    CGRect rect = self.frame;
    if(axis & HSViewAxisX)
    {
        rect.origin.x = CGRectGetMaxX(minFrame) + margin.width;
        rect.size.width = CGRectGetMinX(maxFrame) - CGRectGetMaxX(minFrame) - 2.0f*margin.width;
    }
    if(axis & HSViewAxisY)
    {
        rect.origin.y = CGRectGetMaxY(minFrame) + margin.height;
        rect.size.height = CGRectGetMinY(maxFrame) - CGRectGetMaxY(minFrame) - 2.0f*margin.height;
    }
    self.frame = rect;
}

- (CGPoint)originThatAlignsFrame:(CGRect)sourceFrame withFrame:(CGRect)alignmentFrame edges:(HSViewAlignment)edges offset:(CGSize)offset
{
    CGPoint alignedOrigin = sourceFrame.origin;
    if(edges & HSViewAlignmentMinX)
    {
        alignedOrigin.x = alignmentFrame.origin.x;
    }
    if(edges & HSViewAlignmentMinY)
    {
        alignedOrigin.y = alignmentFrame.origin.y;
    }
    if(edges & HSViewAlignmentMaxX)
    {
        alignedOrigin.x = CGRectGetMaxX(alignmentFrame) - sourceFrame.size.width;
    }
    if(edges & HSViewAlignmentMaxY)
    {
        alignedOrigin.y = CGRectGetMaxY(alignmentFrame) - sourceFrame.size.height;
    }
    
    alignedOrigin.x += offset.width;
    alignedOrigin.y += offset.height;
    return alignedOrigin;
}

- (void)alignWithFrame:(CGRect)alignmentFrame edges:(HSViewAlignment)edges
{
    CGRect myFrame = self.frame;
    myFrame.origin = [self originThatAlignsFrame:myFrame withFrame:alignmentFrame edges:edges offset:CGSizeZero];
    self.frame = myFrame;
}

- (void)alignWithFrame:(CGRect)alignmentFrame edges:(HSViewAlignment)edges offset:(CGSize)offset
{
    CGRect myFrame = self.frame;
    myFrame.origin = [self originThatAlignsFrame:myFrame withFrame:alignmentFrame edges:edges offset:offset];
    self.frame = myFrame;
}


- (CGPoint)originThatPutsFrame:(CGRect)sourceFrame onFrame:(CGRect)alignmentFrame edges:(HSViewAlignment)edges insets:(UIEdgeInsets)insets
{
    CGPoint putOrigin = sourceFrame.origin;
    if(edges & HSViewAlignmentMinX)
    {
        putOrigin.x = alignmentFrame.origin.x - sourceFrame.size.width - insets.right;
    }
    if(edges & HSViewAlignmentMinY)
    {
        putOrigin.y = alignmentFrame.origin.y - sourceFrame.size.height - insets.bottom;
    }
    if(edges & HSViewAlignmentMaxX)
    {
        putOrigin.x = CGRectGetMaxX(alignmentFrame) + insets.left;
    }
    if(edges & HSViewAlignmentMaxY)
    {
        putOrigin.y = CGRectGetMaxY(alignmentFrame) + insets.top;
    }
    return putOrigin;
}

- (void)putOnFrame:(CGRect)alignmentFrame edges:(HSViewAlignment)edges insets:(UIEdgeInsets)insets
{
    CGRect myFrame = self.frame;
    myFrame.origin = [self originThatPutsFrame:myFrame onFrame:alignmentFrame edges:edges insets:insets];
    self.frame = myFrame;
}

- (CGPoint)originThatCentersFrame:(CGRect)sourceFrame inFrame:(CGRect)alignmentFrame axes:(HSViewAxis)axes
{
    CGPoint centerOrigin = sourceFrame.origin;
    if(axes & HSViewAxisX)
    {
        centerOrigin.x = floorf(0.5f*(alignmentFrame.size.width - sourceFrame.size.width)) + alignmentFrame.origin.x;
    }
    if(axes & HSViewAxisY)
    {
        centerOrigin.y = floorf(0.5f*(alignmentFrame.size.height - sourceFrame.size.height)) + alignmentFrame.origin.y;
    }
    return centerOrigin;
}

- (void)centerInFrame:(CGRect)alignmentFrame axes:(HSViewAxis)axes
{
    CGRect myFrame = self.frame;
    myFrame.origin = [self originThatCentersFrame:myFrame inFrame:alignmentFrame axes:axes];
    self.frame = myFrame;
}

- (void)fillFrame:(CGRect)alignmentFrame axes:(HSViewAxis)axes
{
    [self fillFrame:alignmentFrame axes:axes fromEdges:HSViewAlignmentMinX|HSViewAlignmentMinY maximumSize:alignmentFrame.size];
}

- (void)fillFrame:(CGRect)alignmentFrame axes:(HSViewAxis)axes fromEdges:(HSViewAlignment)edges maximumSize:(CGSize)maxSize
{
    const CGSize sizeToUse = CGSizeMake(MIN(alignmentFrame.size.width, maxSize.width),
                                        MIN(alignmentFrame.size.height, maxSize.height));
    
    const CGSize excessSize = CGSizeMake(alignmentFrame.size.width - sizeToUse.width,
                                         alignmentFrame.size.height - sizeToUse.height);
    
    CGRect myFrame = self.frame;
    if(axes & HSViewAxisX)
    {
        if(edges & HSViewAlignmentMaxX)
        {
            myFrame.origin.x = alignmentFrame.origin.x + excessSize.width;
        }
        else
        {
            myFrame.origin.x = alignmentFrame.origin.x;
        }
        myFrame.size.width = sizeToUse.width;
    }
    
    if(axes & HSViewAxisY)
    {
        if(edges & HSViewAlignmentMaxY)
        {
            myFrame.origin.y = alignmentFrame.origin.y + excessSize.height;
        }
        else
        {
            myFrame.origin.y = alignmentFrame.origin.y;
        }
        myFrame.size.height = sizeToUse.height;
    }
    self.frame = myFrame;
}

- (void)sizeToFitInAxes:(HSViewAxis)axes
{
    [self sizeToFitInAxes:axes maximumSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

- (void)sizeToFitInAxes:(HSViewAxis)axes maximumSize:(CGSize)maxSize
{
    const CGSize preferredSize = [self sizeThatFits:self.bounds.size];
    CGRect myFrame = self.frame;
    if(axes & HSViewAxisX)
    {
        myFrame.size.width = MIN(preferredSize.width, maxSize.width);
    }
    if(axes & HSViewAxisY)
    {
        myFrame.size.height = MIN(preferredSize.height, maxSize.height);
    }
    self.frame = myFrame;
}

@end
