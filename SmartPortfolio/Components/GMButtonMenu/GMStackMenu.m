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

@interface GMStackMenu()
{
    UIStackView *panelStackView;
}

@end

@implementation GMStackMenu

- (instancetype) initWithFrame:(CGRect)frame andButtonList:(NSArray *)bList
{
    if (self = [super initWithFrame:frame]) {
        [self stackConfiguration];
        [self stackItemsConfiguration:bList];
    }
    return self;
}


- (void) stackConfiguration
{
    self.axis = UILayoutConstraintAxisHorizontal;
    self.alignment = UIStackViewAlignmentCenter;
    self.distribution = UIStackViewDistributionFillEqually;
    self.spacing = 0.0;
    self.contentMode = UIViewContentModeScaleToFill;

    panelStackView.axis = UILayoutConstraintAxisVertical;
    panelStackView.alignment = UIStackViewAlignmentCenter;
    panelStackView.distribution = UIStackViewDistributionFillEqually;
    panelStackView.spacing = 0.0;
    panelStackView.contentMode = UIViewContentModeScaleToFill;

    [self addArrangedSubview:panelStackView];
}

- (void) stackItemsConfiguration:(NSArray *)bList
{
    NSMutableArray *stackItems = [NSMutableArray new];
    BOOL odd = NO;
    NSInteger rows = bList.count / 2;
    if (rows * 2 != bList.count) {
        rows++;
        odd = YES;
    }

    for (NSArray *a in bList) {
        NSInteger tag = [a[0] integerValue];    // тег кнопки
        NSString *imName = a[1];
        NSString *lblText = a[2];
        GMGradient *gradient = a[3];
        CGRect buttonFrame;
        GMButtonMeniItem *item = [[GMButtonMeniItem alloc] initWithFrame:buttonFrame imageName:imName labelText:lblText gradient:gradient andComponentTag:tag];


    }
}


@end
