//
//  Utility.h
//  AsTest
//
//  Created by Водолазкий В.В. on 26.10.15.
//  Copyright © 2015 Geomatix Laboratoriess S.R.O. All rights reserved.
//

#ifndef Utility_h
#define Utility_h

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

// iphone only!!! --  UIAlert.
//#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
//#else
//#   define ULog(...)
//#endif


/**
 RStr - Resource String
 Provides localized string from default localization storage
 */
#define RStr(name) NSLocalizedString(name, name)


#endif /* Utility_h */
