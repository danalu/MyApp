//
//  GHHomeViewController.m
//  MyUtilityApp
//
//  Created by Dana on 8/14/14.
//
//

#import "GHHomeViewController.h"

#import "StoryboardIDConsant.h"
#import "GHTabBarController.h"
#import "UIViewController+Utility.h"

#import "GHTabOneViewController.h"
#import "GHTabTwoViewController.h"
#import "GHTabThreeViewController.h"
#import "GHTabFourViewController.h"

@interface GHHomeViewController ()<GHTabBarControllerDelegate>

@property (nonatomic, strong) GHTabOneViewController *OneViewController;
@property (nonatomic, strong) GHTabTwoViewController *twoViewControlelr;
@property (nonatomic, strong) GHTabThreeViewController *threeViewController;
@property (nonatomic, strong) GHTabFourViewController *fourViewController;

@property (nonatomic, weak) UIViewController *currentSelectedViewController;

@end

@implementation GHHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //默认显示第一个tab.
    [self showTabBarControllerAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark GHTabbarControllerDelegate
- (void)tabBarController:(GHTabBarController*)tabBarController didSelectAtIndex:(NSInteger)index {
    [self showTabBarControllerAtIndex:index];
}

#pragma mark tool method
- (void)showTabBarControllerAtIndex:(NSInteger)tabBarIndex {
    enum {
        OneViewController,
        TwoViewController,
        ThreeViewController,
        FourViewController
    };
    
    NSArray *fourTabBarControllerID = @[TabOneViewControllerID,TabTwoViewControllerID,TabThreeViewControllerID,TabFourViewControllerID];
    
    switch (tabBarIndex) {
        case OneViewController: {
            self.currentSelectedViewController = self.OneViewController;
        }
            break;
        case TwoViewController: {
            self.currentSelectedViewController = self.twoViewControlelr;
            break;
        }
        case ThreeViewController: {
            self.currentSelectedViewController = self.threeViewController;
            
            break;
        }
        case FourViewController: {
            self.currentSelectedViewController = self.fourViewController;
            break;
        }
            
        default:
            break;
    }
    
    UIViewController *childController = [self getTabBarControllerWithID:fourTabBarControllerID[tabBarIndex] viewController:self.currentSelectedViewController];
    
    [self showChildController:childController inView:self.contentView animated:NO finalStateBlock:nil completionBlock:nil];
}

- (UIViewController*)getTabBarControllerWithID:(NSString*)storyboardID viewController:(UIViewController*)tabBarController {
    if (!tabBarController) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        tabBarController = [mainStoryboard instantiateViewControllerWithIdentifier:storyboardID];
    }
    
    return tabBarController;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"segue identifiler %@", segue.identifier);
    if ([segue.identifier isEqualToString:@"TabBarID"]) {
        GHTabBarController  *tabBarViewController = [segue destinationViewController];
        tabBarViewController.delegate = self;
    }

}


@end
