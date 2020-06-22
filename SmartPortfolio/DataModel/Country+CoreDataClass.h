//
//  Country+CoreDataClass.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class Share, Stock;

NS_ASSUME_NONNULL_BEGIN

@interface Country : NSManagedObject

@property (nonatomic, readonly) UIImage *flag;


+ (NSInteger) recordsCountForMoc:(NSManagedObjectContext *) moc;

+ (Country *) getcountry:(NSString *)shortName forMoc:(NSManagedObjectContext *)moc;
+ (Country *) createNewCountryForshortName:(NSString *)shortName forMoc:(NSManagedObjectContext *)moc;

+ (NSArray <Country *> *) sortedCountryNamesInMoc:(NSManagedObjectContext *) moc;




@end

NS_ASSUME_NONNULL_END

#import "Country+CoreDataProperties.h"
