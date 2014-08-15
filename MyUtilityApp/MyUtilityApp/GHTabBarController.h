//
//  GHTabBarController.h
//  MyUtilityApp
//
//  Created by Dana on 8/14/14.
//
//

#import <UIKit/UIKit.h>

@class GHTabBarController;
@protocol GHTabBarControllerDelegate <NSObject>


- (void)tabBarController:(GHTabBarController*)tabBarController didSelectAtIndex:(NSInteger)index;

@end

@interface GHTabBarController : UIViewController

@property (nonatomic, weak) id<GHTabBarControllerDelegate> delegate;

@property (nonatomic, readonly) NSInteger currentSelectIndex;

@end
