//
//  Portfolio+CoreDataProperties.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Portfolio+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Portfolio (CoreDataProperties)

+ (NSFetchRequest<Portfolio *> *)fetchRequest;

@property (nonatomic) int32_t quantity;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) float price;
@property (nonatomic) BOOL bought;
@property (nullable, nonatomic, retain) Share *share;

@end

NS_ASSUME_NONNULL_END
