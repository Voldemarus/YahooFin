//
//  GMStackMenu.m
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 25.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "GMStackMenu.h"
#import "GMButtonMeniItem.h"

#define RELATION_FACTOR     (0.4*6./7.)

#define BUTTONS_PER_ROW     2

@interface GMStackMenu()


@end

@implementation GMStackMenu

- (instancetype) initWithFrame:(CGRect)frame andButtonList:(NSArray *)bList 
{
    if (self = [super initWithFrame:frame]) {
        [self stackConfiguration];
        [self stackItemsConfiguration:bList];
        self.alpha = 0.0;
        [self hideFromScreen];
    }
    return self;
}


- (void) stackConfiguration
{
//    self.axis = UILayoutConstraintAxisVertical;
//    self.alignment = UIStackViewAlignmentCenter;
//    self.distribution = UIStackViewDistributionFillEqually;
//    self.spacing = 0.0;
//    self.contentMode = UIViewContentModeScaleToFill;

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonClicked:) name: GMCircularButtonTapped object:nil];
}

- (void) stackItemsConfiguration:(NSArray *)bList
{
    BOOL odd = NO;
    NSInteger rows = bList.count / BUTTONS_PER_ROW;
    if (rows * BUTTONS_PER_ROW != bList.count) {
        rows++;
        odd = YES;
    }
//    CGRect containerFrame = self.frame;
//    containerFrame.origin = CGPointZero;
//    UIView *container = [[UIView alloc] initWithFrame:containerFrame];
    CGFloat leadTrail = (self.frame.size.width - BUTTONS_PER_ROW*(RELATION_FACTOR  * self.frame.size.width))/(BUTTONS_PER_ROW + 1.0);

    CGFloat buttonSize = 0.75 * (self.frame.size.width - leadTrail * 2.0)/ BUTTONS_PER_ROW;
    CGFloat xStep = buttonSize * 0.25;
    CGFloat yoffset = (self.frame.size.height - buttonSize*rows - xStep*(rows - 1)) / 2.0;

    
    for (NSInteger i = 0; i < bList.count; i++) {
        NSArray *a = bList[i];
        NSInteger rowOffset = i % BUTTONS_PER_ROW;
        NSInteger currentRow = i  / BUTTONS_PER_ROW;
        NSInteger tag = [a[0] integerValue];    // тег кнопки
        NSString *imName = a[1];
        NSString *lblText = a[2];
        GMGradient *gradient = a[3];

        CGFloat xOffset = leadTrail + rowOffset * (buttonSize + xStep);
        CGFloat yOffset = yoffset + currentRow  * (buttonSize + xStep);

        CGRect buttonFrame = CGRectMake(xOffset,yOffset,buttonSize, buttonSize);
        GMButtonMeniItem *item = [[GMButtonMeniItem alloc] initWithFrame:buttonFrame imageName:imName
                                                               labelText:lblText gradient:gradient
                                                         andComponentTag:tag];

        [self addSubview:item];
     }
    // добавим блюр
    CGRect frame = self.frame;
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *efView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    efView.frame = frame;
    [self insertSubview:efView belowSubview:self.subviews.firstObject];

}



- (void) buttonClicked:(NSNotification *) note
{
    NSInteger bTag = [[note object] integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(stackMenuButtonPressedWithTag:)]) {
        [self.delegate stackMenuButtonPressedWithTag:bTag];
        [self hideFromScreen];
    }
}


- (void) showOnScreen
{
    CGRect b = [UIScreen mainScreen].bounds;
    CGRect targetFrame = CGRectMake(0, b.origin.y,
                                    b.size.width, b.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = targetFrame;
        self.alpha = 1.0;
    }];
}

- (void) hideFromScreen
{
    CGRect b = [UIScreen mainScreen].bounds;
    CGRect targetFrame = CGRectMake(b.size.width, b.origin.y,
                                    b.size.width, b.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = targetFrame;
        self.alpha = 0.0;
    }];

}


@end
