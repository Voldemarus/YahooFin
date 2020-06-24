//
//  GMMenuCircularButton.h
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 24.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

//
// See https://github.com/pablogsIO/PGMenu/
//

#import <UIKit/UIKit.h>

#import "GMGradient.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GMCircularParameterType) {
    GMCircularParameterTypeImageName = 0,
    GMCircularParameterTypeGradient,
    GMCircularParameterTypeTextMenuItem,
};


@interface GMMenuCircularButton : UIButton

@property (nonatomic) GMGradient *gradient;
@property (nonatomic, retain) NSString *imageName;


- (instancetype) initWithFrame:(CGRect) frame gradient:(GMGradient *)aGradient
                  andImageName:(NSString *) imString;

@end

NS_ASSUME_NONNULL_END
