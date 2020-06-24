//
//  UIButton+Animate.h
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 24.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton_Animate : UIButton

- (void) animatePulsingWithCompletion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
