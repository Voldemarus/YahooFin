//
//  News+CoreDataProperties.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "News+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface News (CoreDataProperties)

+ (NSFetchRequest<News *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *headline;
@property (nullable, nonatomic, copy) NSDate *published;
@property (nullable, nonatomic, copy) NSString *source;
@property (nullable, nonatomic, copy) NSString *url;
@property (nonatomic) BOOL paywall;
@property (nullable, nonatomic, copy) NSString *summary;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *language;
@property (nullable, nonatomic, retain) NSSet<Share *> *tickers;

@end

@interface News (CoreDataGeneratedAccessors)

- (void)addTickersObject:(Share *)value;
- (void)removeTickersObject:(Share *)value;
- (void)addTickers:(NSSet<Share *> *)values;
- (void)removeTickers:(NSSet<Share *> *)values;

@end

NS_ASSUME_NONNULL_END
