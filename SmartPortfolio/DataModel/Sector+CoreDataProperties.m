//
//  Sector+CoreDataProperties.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Sector+CoreDataProperties.h"

@implementation Sector (CoreDataProperties)

+ (NSFetchRequest<Sector *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Sector"];
}

@dynamic name;
@dynamic explanation;
@dynamic company;

@end
