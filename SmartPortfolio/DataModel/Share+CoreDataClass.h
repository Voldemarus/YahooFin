//
//  Share+CoreDataClass.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CompanyIndustry, Country, News, Portfolio, Quote, Sector, ShareTags, Stock;

NS_ASSUME_NONNULL_BEGIN

@interface Share : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Share+CoreDataProperties.h"
