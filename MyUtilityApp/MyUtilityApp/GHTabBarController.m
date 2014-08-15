//
//  GHTabBarController.m
//  MyUtilityApp
//
//  Created by Dana on 8/14/14.
//
//

#import "GHTabBarController.h"

static NSInteger const TabBarBaseTag = 101010;

@interface GHTabBarController () {
 
}

@property (nonatomic, weak) IBOutlet UIButton *tabButtonOne;
@property (nonatomic, weak) IBOutlet UIButton *tabButtonTwo;
@property (nonatomic, weak) IBOutlet UIButton *tabButtonThree;
@property (nonatomic, weak) IBOutlet UIButton *tabButtonFour;

- (IBAction)tabBarButtonClicked:(id)sender;

@end

@implementation GHTabBarController

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
    _currentSelectIndex = 0;
    [self setSelectedButtonHighLightState];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tool method
- (void)setSelectedButtonHighLightState {
    NSArray *buttons = @[self.tabButtonOne,self.tabButtonTwo,self.tabButtonThree,self.tabButtonFour];
    
    [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton*)obj;
        if (idx == _currentSelectIndex) {
            [button setBackgroundColor:[UIColor darkGrayColor]];
        } else {
            [button setBackgroundColor:[UIColor whiteColor]];
        }
    }];
}

#pragma mark tab bar tag.
- (IBAction)tabBarButtonClicked:(id)sender {
    NSInteger index = ((UIButton*)sender).tag - TabBarBaseTag;
    
    if (index != _currentSelectIndex) {
        _currentSelectIndex = index;
        [self setSelectedButtonHighLightState];
        
        if ([_delegate respondsToSelector:@selector(tabBarController:didSelectAtIndex:)]) {
            [_delegate tabBarController:self didSelectAtIndex:index];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
