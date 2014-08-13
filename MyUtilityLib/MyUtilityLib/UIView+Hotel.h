//
//  UIView+Hotel.h
//  CategoriesExtraction
//
//  Created by  on 4/18/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @enum HSViewAlignment
 @brief A bitmask based on CGRectEdge that can be used to represent multiple edges of CGRects for sizing and alignment.
 */
typedef enum
{
    HSViewAlignmentMinX = (1 << CGRectMinXEdge),    //!< The edge with smallest X.
    HSViewAlignmentMinY = (1 << CGRectMinYEdge),    //!< The edge with smallest Y.
    HSViewAlignmentMaxX = (1 << CGRectMaxXEdge),    //!< The edge with largest X.
    HSViewAlignmentMaxY = (1 << CGRectMaxYEdge),    //!< The edge with largest Y.
} HSViewAlignment;

/**
 @enum HSViewAxis
 @brief A bitmask that represents the X and Y axes and their combination.
 */
typedef enum
{
    HSViewAxisX = (1 << 0), //!< The X axis.
    HSViewAxisY = (1 << 1)  //!< The Y axis.
} HSViewAxis;

/**
 @category UIView(Hotel)
 @brief Extends UIView with some geometry helpers.
 */

@interface UIView (Hotel)

/**
 Returns the origin that aligns sourceFrame with alignmentFrame along the edges specified.
 @param sourceFrame The frame that should be aligned.
 @param alignmentFrame The frame to align with.
 @param edges The edges to align with, from @ref HSViewAlignment.
 @param offset Offsets the aligned frame away from the alignment edge.
 You can submit multiple edges by combining them with the bitwise operator |.
 @return The origin for sourceFrame that aligns it with the alignment frame.
 */
- (CGPoint)originThatAlignsFrame:(CGRect)sourceFrame withFrame:(CGRect)alignmentFrame edges:(HSViewAlignment)edges offset:(CGSize)offset;

/**
 Aligns the receiver with alignmentFrame along the edges specified.
 @param alignmentFrame The frame to align with.
 @param edges The edges to align with, from @ref HSViewAlignment.
 You can submit multiple edges by combining them with the bitwise operator |.
 */
- (void)alignWithFrame:(CGRect)alignmentFrame edges:(HSViewAlignment)edges;

/**
 Aligns the receiver with alignmentFrame along the edges specified, applying the specified offset.
 @param alignmentFrame The frame to align with.
 @param edges The edges to align with, from @ref HSViewAlignment.
 You can submit multiple edges by combining them with the bitwise operator |.
 @param offset The offset to apply in the X/Y directions.
 */
- (void)alignWithFrame:(CGRect)alignmentFrame edges:(HSViewAlignment)edges offset:(CGSize)offset;

/**
 Returns the origin that places the sourceFrame on the specified edges of the alignmentFrame.
 @param sourceFrame The frame that should be placed.
 @param alignmentFrame The frame to place sourceFrame on.
 @param edges The edges of alignmentFrame to place sourceFrame on, from @ref HSViewAlignment.
 You can submit multiple edges by combining them with the bitwise operator |.
 @param insets Insets from the alignment edges.
 @return The origin for sourceFrame that puts it on the alignment frame.
 */
- (CGPoint)originThatPutsFrame:(CGRect)sourceFrame onFrame:(CGRect)alignmentFrame edges:(HSViewAlignment)edges insets:(UIEdgeInsets)insets;

/**
 Places the receiver on the specified edges of the alignmentFrame.
 @param alignmentFrame The frame to place sourceFrame on.
 @param edges The edges of alignmentFrame to place sourceFrame on, from @ref HSViewAlignment.
 You can submit multiple edges by combining them with the bitwise operator |.
 @param insets Insets from the alignment edges.
 */
- (void)putOnFrame:(CGRect)alignmentFrame edges:(HSViewAlignment)edges insets:(UIEdgeInsets)insets;

/**
 Returns the origin for sourceFrame that centers it in alignmentFrame along the specified axes.
 @param sourceFrame The frame that should be centered.
 @param alignmentFrame The frame to center within.
 @param axes The axes to center sourceFrame in, from @ref HSViewAxis.
 You can submit multiple axes by combining them with the bitwise operator |.
 @return The origin for sourceFrame that centers it in the alignment frame.
 */
- (CGPoint)originThatCentersFrame:(CGRect)sourceFrame inFrame:(CGRect)alignmentFrame axes:(HSViewAxis)axes;

/**
 Centers the receiver in the specified frame along the specified axes.
 @param alignmentFrame The frame to center within.
 @param axes The axes to center the receiver in, from @ref HSViewAxis.
 You can submit multiple axes by combining them with the bitwise operator |.
 */
- (void)centerInFrame:(CGRect)alignmentFrame axes:(HSViewAxis)axes;

/**
 Causes the receiver to fill the specified frame along the specified axes.
 @param alignmentFrame The frame to fill.
 @param axes The axes for the receiver to fill, from @ref HSViewAxis.
 You can submit multiple axes by combining them with the bitwise operator |.
 */
- (void)fillFrame:(CGRect)alignmentFrame axes:(HSViewAxis)axes;

/**
 Causes the receiver to fill the specified frame along the specified axes, up to the limit specified.
 @param alignmentFrame The frame to fill.
 @param axes The axes for the receiver to fill, from @ref HSViewAxis.
 You can submit multiple axes by combining them with the bitwise operator |.
 @param edges The edges to fill from, with values from @ref HSViewAlignment.
 You can submit multiple edges by combining them with the bitwise operator |.
 @param maxSize The maximum size to fit to. MAXFLOAT values indicate no maximum constraint.
 */
- (void)fillFrame:(CGRect)alignmentFrame axes:(HSViewAxis)axes fromEdges:(HSViewAlignment)edges maximumSize:(CGSize)maxSize;

/**
 Positions the receiver to fit in between the specified minimum and maximum rectangles along the separation axis(es).
 The rectangles must not overlap in the separation axis.
 @param minFrame The view is positioned to start from this frame's maximum extent in the separation axis(es).
 @param maxFrame The view is sized to end at this frame's minimum extent in the separation axis(es).
 @param axis The separation axis(es). You can use multiple values combined with bitwise OR to fill in multiple axes.
 @param margin You can shrink the receiver away from the min and max rectangles using this argument.
 */
- (void)fillFromFrame:(CGRect)minFrame toFrame:(CGRect)maxFrame axis:(HSViewAxis)axis margin:(CGSize)margin;

/**
 Causes the receiver to be sized to fit along the specified axes.
 @param axes The axes for the receiver to be sized to fit in, from @ref HSViewAxis.
 You can submit multiple axes by combining them with the bitwise operator |.
 */
- (void)sizeToFitInAxes:(HSViewAxis)axes;

/**
 Causes the receiver to be sized to fit along the specified axes up to a maximum size.
 @param axes The axes for the receiver to be sized to fit in, from @ref HSViewAxis.
 You can submit multiple axes by combining them with the bitwise operator |.
 @param maxSize The maximum size to fit to. MAXFLOAT values indicate no maximum constraint.
 */
- (void)sizeToFitInAxes:(HSViewAxis)axes maximumSize:(CGSize)maxSize;

@end
