//
//  Sector+CoreDataClass.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Share;

NS_ASSUME_NONNULL_BEGIN

@interface Sector : NSManagedObject

+ (NSInteger) recordsCountForMoc:(NSManagedObjectContext *) moc;

+ (Sector *) getSector:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc;
+ (Sector *) createNewSecotrForData:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc;

+ (NSArray <Sector *> *) sortedSectorNamesInMoc:(NSManagedObjectContext *) moc;

@end

NS_ASSUME_NONNULL_END

#import "Sector+CoreDataProperties.h"
