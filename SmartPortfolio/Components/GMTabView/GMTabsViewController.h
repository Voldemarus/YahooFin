//
//  GMTabsViewController.h
//  AsTest
//
//  Created by Водолазкий В.В. on 24.11.2019.
//  Copyright © 2019 Geomatix Laboratory S.R.O. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GMTabItemViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMTabsViewController : UIViewController


@property (nonatomic, retain) NSArray <GMTabItemViewController *> *viewControllers;

@property (nonatomic, readwrite) NSInteger selectedTabBarIndex;

@end

NS_ASSUME_NONNULL_END
