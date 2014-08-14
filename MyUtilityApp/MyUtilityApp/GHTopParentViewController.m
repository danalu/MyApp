//
//  ADViewController.m
//  MyUtilityApp
//
//  Created by Dana on 8/13/14.
//
//

#import "GHTopParentViewController.h"
#import "UIViewController+Utility.h"
#import "GHHomeNavigationController.h"
#import "GHHomeViewController.h"
#import "StoryboardIDConsant.h"

#import "GHLeftNavigationController.h"
#import "GHLeftViewController.h"
#import "GHRightNavigationController.h"
#import "GHRightViewController.h"

#import <QuartzCore/QuartzCore.h>

#define PushAnimationKey @"pushAnimationKey"

@interface GHTopParentViewController ()

@property (nonatomic, strong) GHHomeNavigationController *homeNavigatonController;
@property (nonatomic, strong) GHLeftNavigationController *leftNavigationController;
@property (nonatomic, strong) GHRightNavigationController *rightNavigationController;

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIView *contentView;

@end

@implementation GHTopParentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self instanceHomeViewController];
}

#pragma mark init home view controller
- (void)instanceHomeViewController {
    if (!_homeNavigatonController) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GHHomeNavigationController *homeNavigatonController = [mainStoryboard instantiateViewControllerWithIdentifier:HomeNavigationControllerID];
        
        GHHomeViewController *homeViewController = (GHHomeViewController*)[homeNavigatonController topViewController];
        
        homeViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClicked:)];
        
        homeViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClicked:)];
        
        self.homeNavigatonController = homeNavigatonController;
    }
    [self showChildController:_homeNavigatonController inView:self.contentView animated:NO finalStateBlock:nil completionBlock:nil];
}

#pragma mark Action method
- (void)leftBarButtonItemClicked:(id)obj {
    NSLog(@"left response");
     [self.contentView.layer removeAnimationForKey:PushAnimationKey];
    
    if (!_leftNavigationController) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GHLeftNavigationController *leftNavigatonController = [mainStoryboard instantiateViewControllerWithIdentifier:LeftNavigationControllerID];
        
        GHLeftViewController *leftViewController = (GHLeftViewController*)[leftNavigatonController topViewController];
        
        leftViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(leftCancelButtonItemClicked:)];
        
        self.leftNavigationController = leftNavigatonController;
    }

    [self showChildController:_leftNavigationController inView:self.contentView animated:NO finalStateBlock:nil completionBlock:nil];
    
    [self pushViewControllerWithAnimationDirection:NO];
}

- (void)rightBarButtonItemClicked:(id)obj {
    NSLog(@"right response");

    if (!_rightNavigationController) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GHRightNavigationController *rightNavigatonController = [mainStoryboard instantiateViewControllerWithIdentifier:RightNavigationControllerID];
        
        GHRightViewController *rightViewController = (GHRightViewController*)[rightNavigatonController topViewController];
        
        rightViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(rightCancelButtonItemClicked:)];
        
        self.rightNavigationController = rightNavigatonController;

    }
    
    
    [self showChildController:_rightNavigationController inView:self.contentView animated:NO finalStateBlock:nil completionBlock:nil];
    
    [self pushViewControllerWithAnimationDirection:YES];
}

- (void)leftCancelButtonItemClicked:(id)obj {
    [self dismissChildViewController:_leftNavigationController animated:NO finalStateBlock:nil completionBlock:nil];
    
    [self pushViewControllerWithAnimationDirection:YES];
    
    _leftNavigationController = nil;
}

- (void)rightCancelButtonItemClicked:(id)obj {
    [self dismissChildViewController:_rightNavigationController animated:NO finalStateBlock:nil completionBlock:nil];
    
    [self pushViewControllerWithAnimationDirection:NO];
    
    _rightNavigationController = nil;

}

#pragma mark tool method
- (void)pushViewControllerWithAnimationDirection:(BOOL)right {
    [self.contentView.layer removeAnimationForKey:PushAnimationKey];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    
    if (right) {
        transition.subtype = kCATransitionFromRight;
    } else {
        transition.subtype = kCATransitionFromLeft;
    }
    
    [self.contentView.layer addAnimation:transition forKey:PushAnimationKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
