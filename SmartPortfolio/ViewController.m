//
//  ViewController.m
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 21.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "ViewController.h"
#import "ReferenceLoaderVCViewController.h"
#import "GMStackMenu.h"
#import "DAO.h"

#import "MenuViewController.h"


@interface ViewController () <GMStackMenuDelegate>

@property (nonatomic, retain) GMStackMenu *stackMenu;
- (IBAction)menuTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[DAO sharedInstance] referenceDataNotFilled]) {
        ReferenceLoaderVCViewController *rlvc = [[ReferenceLoaderVCViewController alloc] init];
        if (rlvc) {
            [self.view addSubview:rlvc.view];
            [rlvc loadReferenceData];

        }
     }
}

- (void)viewDidAppear:(BOOL)animated {
    MenuViewController *menuVC = [[MenuViewController alloc] init];
    [self presentViewController:menuVC animated:YES completion:nil];
}



- (NSArray *) curcularMenuData
{
    GMGradient *gradient = [[GMGradient alloc] init];
    [gradient.colors addObject:[UIColor colorWithR:0 g:0 andB:60 alpha:0.2]];
    [gradient.colors addObject:[UIColor colorWithR:0 g:0 andB:210 alpha:0.7]];

    NSLog(@"colors - %@", gradient.colors);
    
    return @[
        @[@1000, @"News", @"News", gradient],
        @[@1001, @"Portfolio", @"My Portfolio", gradient],
        @[@1002, @"Money", @"My Cash", gradient],
        @[@1003, @"SavingPlan", @"Plans", gradient],
        @[@1004, @"Yield", @"Yield", gradient],
        @[@1005, @"Analytic", @"Visuals", gradient],

    ];
}



@end
