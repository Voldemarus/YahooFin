//
//  GMMenuCircularButton.m
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 24.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "GMMenuCircularButton.h"

@interface GMMenuCircularButton ()
{
    CAGradientLayer *gradientLayer;
}

@end

@implementation GMMenuCircularButton


- (instancetype) initWithFrame:(CGRect) frame gradient:(GMGradient *) gradient
                  andImageName:(NSString *) imString
{
    double maximium = MAX(frame.size.width, frame.size.height);
    CGRect targetFrame = frame;
    targetFrame.size.width = maximium;
    targetFrame.size.height = maximium;
    if (self = [super initWithFrame:targetFrame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self setGradientBackground:gradient];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.frame.size.width *0.5;
        UIImage *image = [UIImage imageNamed:imString];
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateHighlighted];
        CGFloat margin = self.bounds.size.width * 0.25;
        self.imageEdgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin);
        [self bringSubviewToFront:self.imageView];
    }
    return self;
}


- (void) layoutSubviews
{
    [super layoutSubviews];
    gradientLayer.frame = self.bounds;
    gradientLayer.cornerRadius = self.bounds.size.width * 0.25;
    CGFloat margin = self.bounds.size.width * 0.25;
    self.imageEdgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin);
}

- (void) setGradientBackground:(GMGradient *) gradient
{
    gradientLayer = [CAGradientLayer new];
    gradientLayer.colors = @[(id)gradient.startColor.CGColor, (id)gradient.endColor.CGColor];
    gradientLayer.startPoint = gradient.startPoint;
    gradientLayer.endPoint = gradient.endPoint;
    gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:gradientLayer atIndex:0];

}


@end
