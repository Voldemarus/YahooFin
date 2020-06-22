//
//  Tag+CoreDataClass.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ShareTags;

NS_ASSUME_NONNULL_BEGIN

@interface Tag : NSManagedObject

+ (NSInteger) recordsCountForMoc:(NSManagedObjectContext *) moc;

+ (Tag *) getTag:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc;
+ (Tag *) createNewTagForData:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc;

+ (NSArray <Tag *> *) sortedTagNamesInMoc:(NSManagedObjectContext *)moc;


@end

NS_ASSUME_NONNULL_END

#import "Tag+CoreDataProperties.h"
