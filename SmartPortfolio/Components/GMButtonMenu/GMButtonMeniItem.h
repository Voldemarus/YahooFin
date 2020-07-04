//
//  GMButtonMeniItem.h
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 24.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMGradient.h"
#import "GMMenuCircularButton.h"

extern NSString * const GMCircularButtonTapped;

@interface GMButtonMeniItem : UIView

- (instancetype) initWithFrame:(CGRect) frame imageName:(NSString *)aString
                     labelText:(NSString *)bString gradient:(GMGradient *)aGradient andComponentTag:(NSInteger) aTag;

@end


