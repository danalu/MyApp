//
//  GHCusomSegue.m
//  MyUtilityApp
//
//  Created by Dana on 8/14/14.
//
//

#import "GHCustomSegue.h"
#import "GHHomeViewController.h"
#import "UIViewController+Utility.h"

@implementation GHCustomSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    UIViewController *parentController = sourceViewController.parentViewController;
    if ([parentController isKindOfClass:[GHHomeViewController class]]) {
        [parentController showChildController:destinationViewController inView:((GHHomeViewController*)parentController).contentView animated:NO finalStateBlock:nil completionBlock:nil];
    }
}

@end
