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
    self.stackMenu = [[GMStackMenu alloc] initWithFrame:self.view.bounds andButtonList:[self curcularMenuData]];
    self.stackMenu.delegate = self;
    [self.view addSubview:self.stackMenu];

    [self.stackMenu showOnScreen];
}



- (NSArray *) curcularMenuData
{
    GMGradient *gradient = [[GMGradient alloc] init];
    [gradient.colors addObject:[UIColor colorWithR:0 g:0 andB:20 alpha:1.0]];
    [gradient.colors addObject:[UIColor colorWithR:0 g:0 andB:160 alpha:1.0]];
    [gradient.colors addObject:[UIColor colorWithR:0 g:0 andB:20 alpha:1.0]];
    
    return @[
        @[@1000, @"News", @"News", gradient],
        @[@1001, @"Portfolio", @"My Portfolio", gradient],
        @[@1002, @"Money", @"My Cash", gradient],
        @[@1003, @"SavingPlan", @"Plans", gradient],
        @[@1004, @"Yield", @"Yield", gradient],
        @[@1005, @"Analytic", @"Visuals", gradient],

    ];
}

- (void)stackMenuButtonPressedWithTag:(NSInteger) aTag
{
    NSLog(@"Кнопка - %ld",aTag);
}


- (IBAction)menuTapped:(id)sender
{
    [self.stackMenu showOnScreen];
}

@end
