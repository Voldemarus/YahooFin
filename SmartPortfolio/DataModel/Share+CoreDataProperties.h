//
//  Share+CoreDataProperties.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Share+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Share (CoreDataProperties)

+ (NSFetchRequest<Share *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *companyName;
@property (nullable, nonatomic, copy) NSString *ticker;
@property (nullable, nonatomic, copy) NSString *ceo;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) int64_t employes;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *securityName;
@property (nullable, nonatomic, copy) NSString *state;
@property (nullable, nonatomic, copy) NSString *website;
@property (nullable, nonatomic, copy) NSString *zip;
@property (nullable, nonatomic, copy) NSString *logoIcon;
@property (nullable, nonatomic, copy) NSString *iexID;
@property (nullable, nonatomic, retain) NSSet<Quote *> *quotes;
@property (nullable, nonatomic, retain) Portfolio *portfolio;
@property (nullable, nonatomic, retain) CompanyIndustry *industry;
@property (nullable, nonatomic, retain) Country *country;
@property (nullable, nonatomic, retain) Sector *sector;
@property (nullable, nonatomic, retain) NSSet<ShareTags *> *shareTags;
@property (nullable, nonatomic, retain) NSSet<News *> *news;
@property (nullable, nonatomic, retain) Stock *stock;

@end

@interface Share (CoreDataGeneratedAccessors)

- (void)addQuotesObject:(Quote *)value;
- (void)removeQuotesObject:(Quote *)value;
- (void)addQuotes:(NSSet<Quote *> *)values;
- (void)removeQuotes:(NSSet<Quote *> *)values;

- (void)addShareTagsObject:(ShareTags *)value;
- (void)removeShareTagsObject:(ShareTags *)value;
- (void)addShareTags:(NSSet<ShareTags *> *)values;
- (void)removeShareTags:(NSSet<ShareTags *> *)values;

- (void)addNewsObject:(News *)value;
- (void)removeNewsObject:(News *)value;
- (void)addNews:(NSSet<News *> *)values;
- (void)removeNews:(NSSet<News *> *)values;

@end

NS_ASSUME_NONNULL_END
