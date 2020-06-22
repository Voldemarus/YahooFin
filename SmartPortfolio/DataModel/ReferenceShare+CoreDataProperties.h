//
//  ReferenceShare+CoreDataProperties.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "ReferenceShare+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ReferenceShare (CoreDataProperties)

+ (NSFetchRequest<ReferenceShare *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *ticker;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSDate *generated;
@property (nonatomic) BOOL enabled;
@property (nullable, nonatomic, copy) NSString *typeCode;
@property (nullable, nonatomic, copy) NSString *iexID;
@property (nullable, nonatomic, retain) Stock *stock;
@property (nullable, nonatomic, retain) Country *country;

@end

NS_ASSUME_NONNULL_END
