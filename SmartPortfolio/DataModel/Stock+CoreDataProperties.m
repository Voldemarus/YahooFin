//
//  Stock+CoreDataProperties.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Stock+CoreDataProperties.h"

@implementation Stock (CoreDataProperties)

+ (NSFetchRequest<Stock *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Stock"];
}

@dynamic stockName;
@dynamic country;
@dynamic shares;
@dynamic mic;
@dynamic explanation;
@dynamic suffix;

@end
