//
//  GMTabsView.h
//  AsTest
//
//  Created by Водолазкий В.В. on 24.11.2019.
//  Copyright © 2019 Geomatix Laboratory S.R.O. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BUTTON_TAG_OFFSET   250123

NS_ASSUME_NONNULL_BEGIN

@protocol GMTabViewDelegate <NSObject>
// Mandatory method!
- (void) tabDidSelectAt:(NSInteger) index;

@end


@interface GMTabsView : UIView


@property (nonatomic, readwrite) CGFloat animationDuration;

@property (nonatomic, retain) UIColor *ballColor;

@property (nonatomic, retain) UIColor *tabColor;

@property (nonatomic, retain) UIColor *selectedTabTintColor;

@property (nonatomic, retain) UIColor *unSelectedTabTintColor;

@property (nonatomic, retain) NSArray <UIImage *> *tabsImages;

@property (nonatomic, retain) NSArray <UILabel *> *tabsLabels;

@property (nonatomic, assign) id <GMTabViewDelegate> delegate;

@property (nonatomic, readonly) NSInteger numberOfTabs;

@property (nonatomic, readwrite) NSInteger selectedTabIndex;

@end

NS_ASSUME_NONNULL_END
