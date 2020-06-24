//
//  UIColor+ColorHex.h
//
//  Created by Dmitry Likhtarov on 23.04.2018.
//  Copyright © 2018 Geomatix Laboratory S.R.O. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorHex)

+ (UIColor * _Nonnull) colorWithHexString:(NSString *_Nonnull) hexString;
+ (NSString * _Nonnull) hexValuesFromUIColor:(UIColor * _Nonnull) color;

+ (UIColor *  _Nonnull) colorWithR:(int)r g:(int)g andB:(int)b;
+ (UIColor *  _Nonnull) colorWithRGB:(int)rgb;


@end
