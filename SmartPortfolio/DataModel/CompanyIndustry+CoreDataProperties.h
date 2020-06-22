//
//  CompanyIndustry+CoreDataProperties.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "CompanyIndustry+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CompanyIndustry (CoreDataProperties)

+ (NSFetchRequest<CompanyIndustry *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Share *> *company;

@end

@interface CompanyIndustry (CoreDataGeneratedAccessors)

- (void)addCompanyObject:(Share *)value;
- (void)removeCompanyObject:(Share *)value;
- (void)addCompany:(NSSet<Share *> *)values;
- (void)removeCompany:(NSSet<Share *> *)values;

@end

NS_ASSUME_NONNULL_END
