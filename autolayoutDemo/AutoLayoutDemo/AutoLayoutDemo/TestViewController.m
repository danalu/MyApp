//
//  TestViewController.m
//  AutoLayoutDemo
//
//  Created by Dana on 2017/8/19.
//  Copyright © 2017年 Dana. All rights reserved.
//

#import "TestViewController.h"

static NSString* const DefaultCellReuseID = @"DefaultCellReuseID";

@interface TestViewController () {
    NSArray *_titles;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titles = @[
                  @"AutoresizingMaskVC",
                  @"FrameLayoutVC",
                  @"StackViewVC"
                  ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DefaultCellReuseID];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultCellReuseID forIndexPath:indexPath];
    cell.textLabel.text = _titles[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [[NSClassFromString(_titles[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
