//
//  UISegmentedControl+Hotel.m
//  CategoriesExtraction
//
//  Created by  on 4/18/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "UISegmentedControl+Hotel.h"
#import "UIFont+Hotel.h"
#import "UIColor+Hotel.h"

@implementation UISegmentedControl (Hotel)

+ (UISegmentedControl*)segmentedControlWithItems:(NSArray*)items
{
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    [segmentedControl setDividerImage:[UIImage imageNamed:@"Need_img"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [segmentedControl setDividerImage:[UIImage imageNamed:@"Need_img"] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"Need_img"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"Need_imgs"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [segmentedControl setContentPositionAdjustment:UIOffsetMake(0, -3.0f) forSegmentType:UISegmentedControlSegmentAny barMetrics:UIBarMetricsDefault];
    
    return segmentedControl;
}

@end
