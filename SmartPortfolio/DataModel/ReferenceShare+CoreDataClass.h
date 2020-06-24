//
//  ReferenceShare+CoreDataClass.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country, Stock;

NS_ASSUME_NONNULL_BEGIN

@interface ReferenceShare : NSManagedObject

+ (NSInteger) recordsCountForMoc:(NSManagedObjectContext *) moc;

+ (ReferenceShare *) getShare:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc;
+ (ReferenceShare *) createNewShareForData:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc;

+ (NSArray <ReferenceShare *> *) sortedShareTickerInMoc:(NSManagedObjectContext *) moc;
+ (NSArray <ReferenceShare *> *) sortedShareNamesInMoc:(NSManagedObjectContext *) moc;

@end

NS_ASSUME_NONNULL_END

#import "ReferenceShare+CoreDataProperties.h"
