//
//  UIImage+Scale.h
//  CaloMemo
//
//  Created by xwzhou on 14-5-17.
//  Copyright (c) 2014年 MTI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

- (UIImage *)imageScaledToScale:(CGFloat)scale;
- (UIImage *)imageScaledToSize:(CGSize)newSize;

@end
