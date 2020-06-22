//
//  Country+CoreDataProperties.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Country+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Country (CoreDataProperties)

+ (NSFetchRequest<Country *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *shortName;
@property (nullable, nonatomic, copy) NSString *fullName;
@property (nullable, nonatomic, retain) NSSet<Share *> *companies;
@property (nullable, nonatomic, retain) NSSet<Stock *> *stocks;

@end

@interface Country (CoreDataGeneratedAccessors)

- (void)addCompaniesObject:(Share *)value;
- (void)removeCompaniesObject:(Share *)value;
- (void)addCompanies:(NSSet<Share *> *)values;
- (void)removeCompanies:(NSSet<Share *> *)values;

- (void)addStocksObject:(Stock *)value;
- (void)removeStocksObject:(Stock *)value;
- (void)addStocks:(NSSet<Stock *> *)values;
- (void)removeStocks:(NSSet<Stock *> *)values;

@end

NS_ASSUME_NONNULL_END
