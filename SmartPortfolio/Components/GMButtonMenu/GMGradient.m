//
//  GMGradient.m
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 24.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "GMGradient.h"

@implementation GMGradient

+ (CGPoint) startPointforOrientation:(GMGradientOrientation) orientation
{
    double x = 0.0;
    double y = 0.0;
    double coords[GMGradientOrientationSize][2] = {
        {0.0, 0.5}, {1.0, 0.5}, {0.5,0.0}, {0.5,1.0}, {0,0}, {1,1}, {1,0}, {0,1}
    };
    x = coords[orientation][0];
    y = coords[orientation][1];
    return CGPointMake(x, y);
}

+ (CGPoint) endPointforOrientation:(GMGradientOrientation) orientation
{
    double x = 0.0;
    double y = 0.0;
    double coords[GMGradientOrientationSize][2] = {
        {1.0, 0.5}, {0.0, 0.5}, {0.5,1.0}, {0.5,0.0}, {1,1}, {0,0}, {0,1}, {1,0}
    };
    x = coords[orientation][0];
    y = coords[orientation][1];
    return CGPointMake(x, y);
    return CGPointMake(x, y);
}

- (instancetype) init
{
    if (self = [super init]) {
        _colors = [NSMutableArray new];
    }
    return self;
}

- (CGPoint) startPoint
{
    return [GMGradient startPointforOrientation:self.orientation];
}

- (CGPoint) endPoint
{
    return [GMGradient endPointforOrientation:self.orientation];
}

- (UIColor *) startColor
{
    if (_colors.count > 0) {
        return [_colors firstObject];
    }
    return [UIColor blackColor];
}

- (UIColor *) endColor
{
    if (_colors.count > 0) {
        return [_colors lastObject];
    }
    return [UIColor whiteColor];
}

@end
