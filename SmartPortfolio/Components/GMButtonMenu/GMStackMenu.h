//
//  GMStackMenu.h
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 25.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMStackMenuDelegate <NSObject>
@optional
- (void)stackMenuButtonPressedWithTag:(NSInteger) aTag;

@end


@interface GMStackMenu : UIStackView

@property (nonatomic, assign) id <GMStackMenuDelegate> delegate;

- (instancetype) initWithFrame:(CGRect)frame andButtonList:(NSArray *)bList;


@end

NS_ASSUME_NONNULL_END
