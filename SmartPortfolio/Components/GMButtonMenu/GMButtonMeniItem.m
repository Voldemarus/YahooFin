//
//  GMButtonMeniItem.m
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 24.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "GMButtonMeniItem.h"
#import "UIColor+ColorHex.h"

NSString * const GMCircularButtonTapped =    @"GMCircularButtonTapped";

@interface GMButtonMeniItem()
{
    GMGradientOrientation gradientOrientation;
    UIColor *gradientColor;
}

@property (nonatomic, retain) GMMenuCircularButton *button;
@property (nonatomic, retain)UILabel *label;

@end


@implementation GMButtonMeniItem


- (instancetype) initWithFrame:(CGRect) frame imageName:(NSString *)aString
                     labelText:(NSString *)bString gradient:(GMGradient *)aGradient andComponentTag:(NSInteger) aTag
{
    if (self = [super initWithFrame:frame]) {
        [self defaultConfiguration];

        self.backgroundColor = [UIColor colorWithR:45 g:43 andB:88 alpha:0.2];
        self.layer.cornerRadius = self.bounds.size.width * 0.2;
        double ofs = self.frame.size.width/2.0;
        CGRect bFrame = CGRectMake(ofs, ofs, ofs, ofs);
        self.button = [[GMMenuCircularButton alloc] initWithFrame:bFrame gradient:aGradient andImageName:aString];
        self.button.tag = aTag;
        [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self setConstraintsForLabel:self.label andButton:self.button];

        CGRect lFrame = CGRectMake(0,0,self.frame.size.width, self.frame.size.height * 0.2);
        self.label = [[UILabel alloc] initWithFrame:lFrame];
        self.label.font = [UIFont systemFontOfSize:14.0];
        self.label.text = bString;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];

        [self addSubview:self.button];
        [self addSubview:self.label];

        self.button.translatesAutoresizingMaskIntoConstraints = NO;
        self.label.translatesAutoresizingMaskIntoConstraints = NO;

        [self setConstraintsForLabel:self.label andButton:self.button];

    }
    return self;
}


- (void) defaultConfiguration
{
    gradientOrientation = GMGradientOrientationBottomRightTopLeft;
    gradientColor = [UIColor blackColor];

}


- (void) layoutSubviews
{
    [super layoutSubviews];

    self.layer.cornerRadius = self.frame.size.width * 0.15;
}

- (void) setConstraintsForLabel:(UILabel *)aLabel andButton:(UIButton *)aButton
{
    [self setLabelConstraintsForLabel:aLabel];
    [self setButtonConstraintsForButton:aButton];
}

- (void) setLabelConstraintsForLabel: (UILabel *)label
{

    [self addConstraint:[NSLayoutConstraint constraintWithItem:label
            attribute:NSLayoutAttributeWidth
            relatedBy:NSLayoutRelationEqual
            toItem:self
            attribute:NSLayoutAttributeWidth
               multiplier:1.0
              constant:0.0]];


    [self addConstraint:[NSLayoutConstraint constraintWithItem:label
                attribute:NSLayoutAttributeCenterX
                  relatedBy:NSLayoutRelationEqual
                    toItem:self
                   attribute:NSLayoutAttributeCenterX
                       multiplier:1.0
                      constant:0.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:label
            attribute:NSLayoutAttributeHeight
            relatedBy:NSLayoutRelationEqual
            toItem:self
            attribute:NSLayoutAttributeHeight
            multiplier:1.0/8.0
             constant:self.frame.size.height/8.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:label
          attribute:NSLayoutAttributeBottom
          relatedBy:NSLayoutRelationEqual
          toItem:self
          attribute:NSLayoutAttributeBottom
          multiplier:1.0
          constant:-20.0]];
}

- (void) setButtonConstraintsForButton:(UIButton *) button
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:button
          attribute:NSLayoutAttributeCenterX
          relatedBy:NSLayoutRelationEqual
          toItem:self
          attribute:NSLayoutAttributeCenterX
          multiplier:1.0
          constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:button
           attribute:NSLayoutAttributeCenterY
           relatedBy:NSLayoutRelationEqual
           toItem:self
           attribute:NSLayoutAttributeCenterY
           multiplier:1.0
           constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:button
         attribute:NSLayoutAttributeTop
         relatedBy:NSLayoutRelationEqual
         toItem:self
        attribute:NSLayoutAttributeTop
         multiplier:1.0
         constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:button
         attribute:NSLayoutAttributeWidth
         relatedBy:NSLayoutRelationEqual
         toItem:self
         attribute:NSLayoutAttributeHeight
         multiplier:30.0/82.0
         constant:.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:button
         attribute:NSLayoutAttributeHeight
         relatedBy:NSLayoutRelationEqual
         toItem:button
          attribute:NSLayoutAttributeWidth
          multiplier:1.0
         constant:.0]];
}

- (void) buttonTapped:(id) sender
{
    NSInteger tag = [sender tag];
    NSLog(@"Button with tag %ld tapped",(long)tag);
    [[NSNotificationCenter defaultCenter] postNotificationName:GMCircularButtonTapped object:@(tag)];
}



@end
