//
//  Stock+CoreDataProperties.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Stock+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Stock (CoreDataProperties)

+ (NSFetchRequest<Stock *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *stockName;
@property (nullable, nonatomic, copy) NSString *mic;
@property (nullable, nonatomic, copy) NSString *explanation;
@property (nullable, nonatomic, copy) NSString *suffix;
@property (nullable, nonatomic, retain) Country *country;
@property (nullable, nonatomic, retain) NSSet<Share *> *shares;

@end

@interface Stock (CoreDataGeneratedAccessors)

- (void)addSharesObject:(Share *)value;
- (void)removeSharesObject:(Share *)value;
- (void)addShares:(NSSet<Share *> *)values;
- (void)removeShares:(NSSet<Share *> *)values;

@end

NS_ASSUME_NONNULL_END
