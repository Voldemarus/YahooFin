//
//  Quote+CoreDataProperties.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Quote+CoreDataProperties.h"

@implementation Quote (CoreDataProperties)

+ (NSFetchRequest<Quote *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Quote"];
}

@dynamic date;
@dynamic closePrice;
@dynamic volume;
@dynamic share;

@end
