//
//  GMTabsView.m
//  AsTest
//
//  Created by Водолазкий В.В. on 24.11.2019.
//  Copyright © 2019 Geomatix Laboratory S.R.O. All rights reserved.
//

#import "GMTabsView.h"

NSString * const BallAnimationKey       =   @"ball_animation_key";
NSString * const TabChangeAnimationKey  =   @"ball_animation_key";

#define TAB_ANIMATION           (self.animationDuration * 0.2)
#define BALL_ANIMATION          (self.animationDuration * 0.4)
#define TINT_CHANGE_ANIMATION   (self.animationDuration * 0.4)

@interface GMTabsView ()
{
    CALayer * ballonLayer;
    CAShapeLayer *shapeLayer;
    NSMutableArray <UIButton *> *buttons;
    NSInteger _selectedTabIndex;
    
    NSInteger previousTabIndex;

}

@property (nonatomic, readonly) CGFloat itemWidth;
@property (nonatomic, readonly) CGFloat itemHeight;
@property (nonatomic, readonly) CGFloat ballSize;
@property (nonatomic, readonly) CGFloat iconSize;

@end

@implementation GMTabsView

- (instancetype) initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self setupView];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void) setupView
{
    //
    // Set up default colors
    //
    self.ballColor = [UIColor colorNamed:@"GMTabsViewBallColor"];
    self.tabColor = [UIColor colorNamed:@"GMTabsViewTabsColor"];
    self.selectedTabTintColor = [UIColor colorNamed:@"GMTabsViewSelectedTintColor"];
    self.unSelectedTabTintColor = [UIColor colorNamed:@"GMTabsViewUnselectedTimtColor"];
    
//    self.ballColor = [UIColor colorWithRed:0.7529411765 green: 0.4470588235 blue: 0.5960784314 alpha: 1.0];
//    self.tabColor = [UIColor greenColor]; // [UIColor colorWithRed: 0.9960784314 green: 0.9960784314 blue: 0.9960784314 alpha: 1.0];
//    self.selectedTabTintColor = [UIColor blueColor];// [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
//    self.unSelectedTabTintColor = [UIColor greenColor]; // [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1.0];
    
    self.animationDuration = 1.0;
    //
    previousTabIndex = 0;
    //
    shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.fillColor = self.tabColor.CGColor;
    shapeLayer.lineWidth = 0.5;
    shapeLayer.position = CGPointMake(10.0, 10.0);
    [self.layer addSublayer:shapeLayer];
    self.backgroundColor = [UIColor clearColor];

    ballonLayer = [[CAShapeLayer alloc] init];
    ballonLayer.backgroundColor = self.ballColor.CGColor;
    [self.layer addSublayer:ballonLayer];
    
     _selectedTabIndex = 0;
}

#pragma mark - Draw view

- (void) drawRect:(CGRect)rect
{
     [self moveToSelectedTab];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self updateFrames];
}

- (void) updateFrames
{
    shapeLayer.fillColor = self.tabColor.CGColor;
    ballonLayer.backgroundColor = self.ballColor.CGColor;

    shapeLayer.frame = self.bounds;

    ballonLayer.frame = CGRectMake(0, 0, self.ballSize, self.ballSize);
    ballonLayer.cornerRadius = self.ballSize / 2;
    CGFloat sectionWidth = self.bounds.size.width / self.numberOfTabs;

    for (NSInteger i = 0; i < buttons.count; i++) {
        UIButton *b = buttons[i];
        CGFloat y = (i == self.selectedTabIndex) ? 0 : self.bounds.size.height / 2 - self.iconSize / 2;
        CGFloat x = sectionWidth * (i + 0.5) - self.iconSize / 2;
        b.frame = CGRectMake(x, y, self.iconSize, self.iconSize);
        b.maskView.frame = b.frame;
//        NSLog(@"button - %.0f *  %.0f ( %.0f *  %.0f)",b.frame.origin.x, b.frame.origin.y, b.frame.size.width, b.frame.size.height);
//        CALayer *bl = b.layer;
//        bl.borderColor = [UIColor blueColor].CGColor;
//        bl.borderWidth = 2.0;
    }
    
    [self moveToSelectedTab];
}


#pragma mark - Moving methods

- (void) moveToSelectedTab
{
    [self animateBallWithPath:[self ballPath]];
    [self animateTabToPath:[self fullRectangle] completion:^{
        [self animateTabToPath:[self holePathForSelectedIndex] completion:^{
            previousTabIndex = self.selectedTabIndex;
        }];
    }];
    [self animateTintColorChanging];
 }

#pragma mark - Path generators

// Generate arc shaped movement for the ball
- (CGPathRef) ballPath
{
    CGFloat sectionWidth = self.bounds.size.width / self.numberOfTabs;
    CGFloat fromX = ((previousTabIndex + 1) * sectionWidth) - (sectionWidth * 0.5);
    CGFloat toX = ((self.selectedTabIndex + 1) * sectionWidth) - (sectionWidth * 0.5);
    CGFloat controlPointY = fabs(fromX - toX);
    controlPointY = (controlPointY != 0 ? controlPointY : 50.0);
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path  moveToPoint:CGPointMake(fromX, self.itemHeight * 0.5)];
    [path addQuadCurveToPoint:CGPointMake(toX, self.itemHeight * 0.25)
                 controlPoint:CGPointMake((fromX + toX) * 0.5, -controlPointY)];
    return CGPathCreateCopy(path.CGPath);
 }

// Closed path for selected index with hole
- (CGPathRef) holePathForSelectedIndex
{
    CGFloat sectionWidth = self.bounds.size.width / self.numberOfTabs;
    CGFloat sectionHeight = self.bounds.size.height;

    CGFloat beginningOfTheTab = (self.selectedTabIndex * sectionWidth);

    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath  moveToPoint:CGPointZero];

    [bezierPath addLineToPoint:CGPointMake( beginningOfTheTab - (sectionWidth * 0.3), 0)];
    [bezierPath addQuadCurveToPoint:CGPointMake(beginningOfTheTab + (sectionWidth * 0.2),  self.itemHeight * 0.5)
                  controlPoint:CGPointMake(beginningOfTheTab + (sectionWidth * 0.1), 0)];
    [bezierPath addCurveToPoint:CGPointMake(beginningOfTheTab + (sectionWidth * 0.8), self.itemHeight * 0.5)
                  controlPoint1:CGPointMake(beginningOfTheTab + (sectionWidth * 0.3), self.itemHeight)
                  controlPoint2:CGPointMake( beginningOfTheTab + (sectionWidth * 0.7), self.itemHeight)];
    [bezierPath addQuadCurveToPoint:CGPointMake(beginningOfTheTab + sectionWidth + (sectionWidth * 0.3), 0)
                       controlPoint:CGPointMake(beginningOfTheTab + (sectionWidth * 0.9), 0)];
    [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width, sectionHeight)];
    [bezierPath addLineToPoint:CGPointMake(0, sectionHeight)];
    [bezierPath addLineToPoint:CGPointZero];
    [bezierPath closePath];
    
    return CGPathCreateCopy(bezierPath.CGPath);
  }

// CGPath describing whole components' frame
 - (CGPathRef) fullRectangle
{
    CGFloat  height = self.bounds.size.height;
    CGFloat  width = self.bounds.size.width;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [bezierPath moveToPoint:CGPointZero];
    [bezierPath addLineToPoint:CGPointMake(width, 0)];
    [bezierPath addLineToPoint:CGPointMake(width, height)];
    [bezierPath addLineToPoint:CGPointMake(0, height)];
    [bezierPath addLineToPoint:CGPointZero];
    [bezierPath closePath];
    return CGPathCreateCopy(bezierPath.CGPath);
}

#pragma mark - Animation methods

- (void) animateTabToPath:(CGPathRef) cgPath completion:(void (^ __nullable)(void))completion
 {
     [CATransaction begin];
     CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
     animation.toValue = (__bridge id) cgPath;
     animation.fillMode = kCAFillModeBoth;
     animation.removedOnCompletion = NO;
     animation.duration = TAB_ANIMATION;

     CATransaction.completionBlock = ^{
         NSLog(@"♦️ Здесь падает при сворачивании в фоновый режим,\n shapeLayer.path = %@ \n cgPath = %@",shapeLayer.path, cgPath);

         shapeLayer.path = cgPath;
         if (completion) {
             completion();
         }
     };
     [shapeLayer addAnimation:animation forKey:TabChangeAnimationKey];
     [CATransaction commit];
}

- (void) animateBallWithPath:(CGPathRef) cgPath
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = cgPath;
    animation.calculationMode = @"paced";
    animation.duration = BALL_ANIMATION;
    animation.fillMode = kCAFillModeBoth;
    animation.removedOnCompletion = NO;
    animation.timingFunctions = @[[CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [ballonLayer addAnimation:animation forKey:BallAnimationKey];
}

- (void) animateTintColorChanging
{
    [UIView animateWithDuration:TINT_CHANGE_ANIMATION animations:^{
        // "unselect" buttons
        for (UIButton *b in buttons) {
            NSInteger index  = b.tag - BUTTON_TAG_OFFSET;
            CGRect frame = b.frame;
            if (index != self.selectedTabIndex) {
                // unselect all buttons
                [b setTintColor:self.unSelectedTabTintColor];
                frame.origin.y = (self.bounds.size.height / 2 - self.iconSize / 2.0);
            } else {
                [b setTintColor:self.selectedTabTintColor];
                frame.origin.y = -3.5;// 0.0;
            }
            b.frame = frame;
            
            // Цвет текста и центры
            UILabel *lab = self.tabsLabels[index];
            lab.textColor = (lab.tag - BUTTON_TAG_OFFSET == self.selectedTabIndex) ? self.selectedTabTintColor : self.unSelectedTabTintColor;
            lab.center = CGPointMake(b.center.x, self.bounds.size.height - lab.frame.size.height / 2);
         }
        
    }];
}

#pragma mark - Setters/getters

- (NSInteger) numberOfTabs
{
    return buttons.count;
}

- (CGFloat) ballSize
{
    return self.itemWidth / 2.0;
}

- (CGFloat) iconSize
{
    return self.ballSize / 1.5;
}

- (CGFloat) itemHeight
{
    CGFloat height = self.bounds.size.height;
    return (height > self.ballSize ? self.ballSize : height);
}

- (CGFloat) itemWidth
{
    NSAssert(buttons.count > 0,@"Should be called after buttons are created");
    CGFloat it = self.bounds.size.width / buttons.count;
    return (it > 100 ? 100 : it);
}

- (void) setBallColor:(UIColor *)ballColor
{
    _ballColor = ballColor;
    ballonLayer.backgroundColor = ballColor.CGColor;
}

- (void) setTabColor:(UIColor *)tabColor
{
    _tabColor = tabColor;
    shapeLayer.fillColor = tabColor.CGColor;
}

- (void) setTabsImages:(NSArray<UIImage *> *)tabsImages
{
    NSAssert(tabsImages.count > 0, @"tabsImages shouldn't be empty!");
    _tabsImages = tabsImages;

    // remove old buttons
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:UIButton.class]) {
            [v removeFromSuperview];
        }
    }
    
    if (buttons) {
        [buttons removeAllObjects];
    } else {
        buttons = [NSMutableArray new];
    }
 
    // Add images to the list
    // Now we should recreate all buttons
    for (NSInteger i = 0; i < _tabsImages.count; i++) {
        // simple iterator to keep order
        UIImage *image = _tabsImages[i];
        UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
        [b setImage:image forState:UIControlStateNormal];
        [b addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        b.adjustsImageWhenHighlighted = NO;
        b.contentMode = UIViewContentModeScaleAspectFit;
        b.tag = BUTTON_TAG_OFFSET + i;
        [buttons addObject:b];
        [self addSubview:b];
        
    }
}

- (void) buttonTapped:(id)sender
{
    NSInteger index = [(UIButton *)sender tag] - BUTTON_TAG_OFFSET;
    index = (index >= 0 ? index : 0);
    if (self.delegate) {
       [self.delegate tabDidSelectAt:index];
    }
}

- (NSInteger) selectedTabIndex
{
    return _selectedTabIndex;
}

- (void) setSelectedTabIndex:(NSInteger)selectedTabIndex
{
    _selectedTabIndex = selectedTabIndex;
    [self moveToSelectedTab];
}

@end

