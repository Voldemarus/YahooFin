//
//  GMGradient.h
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 24.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+ColorHex.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GMGradientOrientation) {
    GMGradientOrientationLeftRight = 0,
    GMGradientOrientationRightLeft,
    GMGradientOrientationTopBottom,
    GMGradientOrientationBottomTop,
    GMGradientOrientationTopLeftBottomRight,
    GMGradientOrientationBottomRightTopLeft,
    GMGradientOrientationTopRightBottomLeft,
    GMGradientOrientationBottomLeftTopRight,
    GMGradientOrientationSize,
};

@interface GMGradient : NSObject

+ (CGPoint) startPointforOrientation:(GMGradientOrientation) orientation;
+ (CGPoint) endPointforOrientation:(GMGradientOrientation) orientation;

@property (nonatomic, readonly) GMGradientOrientation orientation;
@property (nonatomic, retain) NSMutableArray *colors;

@property (nonatomic, readonly) CGPoint startPoint;
@property (nonatomic, readonly) CGPoint endPoint;
@property (nonatomic, readonly) UIColor *startColor;
@property (nonatomic, readonly) UIColor *endColor;



@end



NS_ASSUME_NONNULL_END
