//
//  GMStackMenu.h
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 25.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GMGradient.h"
#import "UIColor+ColorHex.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GMStackMenuDelegate <NSObject>
@optional
- (void)stackMenuButtonPressedWithTag:(NSInteger) aTag;

@end

/**
    ButtonList Array of arrays:
        @[  @(buttonTag), NSString *imageName, NSString *labelText, CMGradient *gradient ]
 */


@interface GMStackMenu : UIView

@property (nonatomic, assign) id <GMStackMenuDelegate> delegate;

- (instancetype) initWithFrame:(CGRect)frame andButtonList:(NSArray *)bList;


- (void) showOnScreen;
- (void) hideFromScreen;

@end

NS_ASSUME_NONNULL_END
