//
//  AutoresizingMaskViewController.m
//  AutoLayoutDemo
//
//  Created by Dana on 2017/8/19.
//  Copyright © 2017年 Dana. All rights reserved.
//

#import "AutoresizingMaskVC.h"

@interface AutoresizingMaskVC ()

@property (nonatomic, weak) IBOutlet UIView *useConstraintsView;
@property (nonatomic, weak) IBOutlet UIView *notUseConstraintsView;

@end

@implementation AutoresizingMaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    BOOL isStop = NO;
//    while (isStop) {
//        NSUInteger functionIndex = 1;
//        switch (functionIndex) {
//            case 1:
//                [self testViewLoadedFromXIB];
//                break;
//            case 2:
//                [self testViewLoadedFromXIBAndModifyAutoResize];
//            default:
//                break;
//        }
//        
//        sleep(10);
//    }
    
//    [self testViewLoadedFromXIBAndModifyAutoResize];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - test

/**
 使用Xib加载view，且启用autoLayout.
 添加了约束的view，autoresize默认不为None,但translatesAutoresizingMaskIntoConstraints默认为false，故不会与添加的约束冲突.
 没有添加约束view，不修改的情况下，autoresize默认为true，会把autoresize转化为约束，不会只是xib里面固定的frame布局.
 */
- (void)testViewLoadedFromXIB {
    //通过xib加载view，使用autolayout和不使用的autoresizingMask默认值
    NSLog(@"手动添加了约束后的autoresizing: %@",self.useConstraintsView);
    NSLog(@"未手动添加约束autoresizing: %@", self.notUseConstraintsView);

    //通过xib加载view，使用autolayout和不使用的translatesAutoresizingMaskIntoConstraints默认值
    NSLog(@"使用了约束后的bool值： %@", self.useConstraintsView.translatesAutoresizingMaskIntoConstraints ? @"true" : @"false");
    NSLog(@"未使用约束的bool值：%@", self.notUseConstraintsView.translatesAutoresizingMaskIntoConstraints ? @"true" : @"false");
}

- (void)testViewLoadedFromXIBAndModifyAutoResize {
    self.useConstraintsView.translatesAutoresizingMaskIntoConstraints = YES;
    NSLog(@"添加了约束并把autoresize转化为约束: %@",self.useConstraintsView);

    self.notUseConstraintsView.autoresizingMask = UIViewAutoresizingNone;
    NSLog(@"默认是水平居中，设置autoresize为None,相当于没有任何约束: %@",self.notUseConstraintsView);
}

@end
