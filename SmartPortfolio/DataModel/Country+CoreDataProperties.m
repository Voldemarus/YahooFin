//
//  Country+CoreDataProperties.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Country+CoreDataProperties.h"

@implementation Country (CoreDataProperties)

+ (NSFetchRequest<Country *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Country"];
}

@dynamic shortName;
@dynamic fullName;
@dynamic companies;
@dynamic stocks;

@end
