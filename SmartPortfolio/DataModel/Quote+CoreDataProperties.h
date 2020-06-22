//
//  Quote+CoreDataProperties.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Quote+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Quote (CoreDataProperties)

+ (NSFetchRequest<Quote *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) float closePrice;
@property (nonatomic) int64_t volume;
@property (nullable, nonatomic, retain) Share *share;

@end

NS_ASSUME_NONNULL_END
