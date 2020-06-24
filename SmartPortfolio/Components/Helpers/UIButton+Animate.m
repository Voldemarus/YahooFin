//
//  UIButton+Animate.m
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 24.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "UIButton+Animate.h"

@implementation UIButton_Animate

- (void) animatePulsingWithCompletion:(void (^ __nullable)(void))completion
{
    [CATransaction begin];
    CAKeyframeAnimation  *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.keyTimes = @[ @0, @0.5, @1];
    animation.values = @[@1, @0.5, @1];
    animation.duration = 0.5;

    [CATransaction setCompletionBlock:^{
        completion();
    }];

    [self.layer addAnimation:animation forKey:@"animation"];
    [CATransaction commit];

}

@end
