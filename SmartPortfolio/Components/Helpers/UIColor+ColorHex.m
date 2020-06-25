//
//  UIColor+ColorHex.m
//
//  Created by Dmitry Likhtarov on 23.04.2018.
//  Copyright © 2018 Geomatix Laboratory S.R.O. All rights reserved.
//

#import "UIColor+ColorHex.h"

@implementation UIColor (ColorHex)

+ (UIColor * _Nonnull) colorWithHexString:(NSString *_Nonnull) hexString
{
    // Возвращает Белый или UIColor
    
    if ([hexString length] != 6) {
        return [UIColor whiteColor];
    }
    
    // Проверим на валидность
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-fA-F|0-9]" options:0 error:NULL];
    NSUInteger match = [regex numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, [hexString length])];
    
    if (match != 0) {
        return [UIColor whiteColor];
    }
    
    NSRange rRange = NSMakeRange(0, 2);
    NSString *rComponent = [hexString substringWithRange:rRange];
    unsigned int rVal = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:rComponent];
    [rScanner scanHexInt:&rVal];
    float rRetVal = (float)rVal / 254;
    
    
    NSRange gRange = NSMakeRange(2, 2);
    NSString *gComponent = [hexString substringWithRange:gRange];
    unsigned int gVal = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:gComponent];
    [gScanner scanHexInt:&gVal];
    float gRetVal = (float)gVal / 254;
    
    NSRange bRange = NSMakeRange(4, 2);
    NSString *bComponent = [hexString substringWithRange:bRange];
    unsigned int bVal = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:bComponent];
    [bScanner scanHexInt:&bVal];
    float bRetVal = (float)bVal / 254;
    
    return [UIColor colorWithRed:rRetVal green:gRetVal blue:bRetVal alpha:1.0f];
    
}

+ (NSString * _Nonnull) hexValuesFromUIColor:(UIColor * _Nonnull) color
{
    // Возвращает Белый или 6 16-тиричных символов
    
    if (!color || color == [UIColor whiteColor]) {
        return @"ffffff"; // Special case, as white doesn't fall into the RGB color space
    }
    
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    int redDec   = (int)(red * 255);
    int greenDec = (int)(green * 255);
    int blueDec  = (int)(blue * 255);
    
    NSString *returnString = [NSString stringWithFormat:@"%02x%02x%02x", (unsigned int)redDec, (unsigned int)greenDec, (unsigned int)blueDec];
    
    return returnString;
 }

+ (UIColor *  _Nonnull) colorWithR:(int)r g:(int)g andB:(int)b alpha:(CGFloat) alpha
{
    if (r < 0 || r > 255 || g < 0 || g > 255 || b < 0 || g > 255) {
        return [UIColor blackColor];
    }
    double red = r / 255.0;
    double green = g / 255.0;
    double blue = b / 255.0;

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *  _Nonnull) colorWithRGB:(int)rgb
{
    int b = rgb & 0xFF;
    int g = (rgb >> 8) & 0xFF;
    int r = (rgb >> 16) & 0xFF;
    return [UIColor colorWithR:r g:g andB:b alpha:1.0];
}



@end

