//
//  ViewController.m
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 21.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "ViewController.h"
#import "ReferenceLoaderVCViewController.h"
#import "DAO.h"

@interface ViewController ()

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


@end
