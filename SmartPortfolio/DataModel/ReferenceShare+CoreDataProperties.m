//
//  ReferenceShare+CoreDataProperties.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "ReferenceShare+CoreDataProperties.h"

@implementation ReferenceShare (CoreDataProperties)

+ (NSFetchRequest<ReferenceShare *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ReferenceShare"];
}

@dynamic ticker;
@dynamic name;
@dynamic generated;
@dynamic enabled;
@dynamic typeCode;
@dynamic iexID;
@dynamic stock;
@dynamic country;

@end
