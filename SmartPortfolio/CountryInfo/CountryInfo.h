//
//  CountryInfo.h
//  Weather
//
//  Created by Водолазкий В.В. on 10.02.16.
//  Copyright © 2016 Geomatix Laboratoriess S.R.O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CountryInfo : NSObject

// ordered country codes
@property (nonatomic, readonly) NSArray *countryCodes;
// List of records, ordered by country' name
@property (nonatomic, readonly) NSArray *countries;

// index of US record in countries array to be set by default
@property (nonatomic, readonly) NSInteger defaultIndex;

+ (CountryInfo *) sharedInstance;

- (UIImage *) countryFlagForCode:(NSString *)countryCode;
- (NSString *) countryNameForCode:(NSString *)countryCode;



@end
