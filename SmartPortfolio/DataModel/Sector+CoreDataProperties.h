//
//  Sector+CoreDataProperties.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Sector+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Sector (CoreDataProperties)

+ (NSFetchRequest<Sector *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *explanation;
@property (nullable, nonatomic, retain) NSSet<Share *> *company;

@end

@interface Sector (CoreDataGeneratedAccessors)

- (void)addCompanyObject:(Share *)value;
- (void)removeCompanyObject:(Share *)value;
- (void)addCompany:(NSSet<Share *> *)values;
- (void)removeCompany:(NSSet<Share *> *)values;

@end

NS_ASSUME_NONNULL_END
