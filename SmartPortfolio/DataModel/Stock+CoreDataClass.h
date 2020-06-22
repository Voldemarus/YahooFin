//
//  Stock+CoreDataClass.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country, Share;

NS_ASSUME_NONNULL_BEGIN

@interface Stock : NSManagedObject

+ (NSInteger) recordsCountForMoc:(NSManagedObjectContext *) moc;

+ (Stock *) getStock:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc;
+ (Stock *) createNewStockForData:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc;

+ (NSArray <Stock *> *) sortedStockNamesInMoc:(NSManagedObjectContext *) moc;


@end

NS_ASSUME_NONNULL_END

#import "Stock+CoreDataProperties.h"
