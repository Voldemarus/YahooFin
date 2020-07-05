//
//  MenuViewController.m
//  SmartPortfolio
//
//  Created by Мария Водолазкая on 05.07.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuCollectionViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController {
    MenuCollectionViewController *menuCollectionVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    menuCollectionVC = [[MenuCollectionViewController alloc] initWithNibName:@"MenuCollectionViewController" bundle:nil];
    [self.menuCollectionContainerView addSubview:menuCollectionVC.view];
    
    // constraints
    menuCollectionVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [menuCollectionVC.view.leadingAnchor
     constraintEqualToAnchor:self.menuCollectionContainerView.leadingAnchor
     constant:0].active = YES;
    [menuCollectionVC.view.trailingAnchor
     constraintEqualToAnchor:self.menuCollectionContainerView.trailingAnchor
     constant:0].active = YES;
    [menuCollectionVC.view.topAnchor
    constraintEqualToAnchor:self.menuCollectionContainerView.topAnchor
    constant:0].active = YES;
    [menuCollectionVC.view.bottomAnchor
    constraintEqualToAnchor:self.menuCollectionContainerView.bottomAnchor
    constant:0].active = YES;

}



@end
