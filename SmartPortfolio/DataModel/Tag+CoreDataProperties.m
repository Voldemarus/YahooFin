//
//  Tag+CoreDataProperties.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Tag+CoreDataProperties.h"

@implementation Tag (CoreDataProperties)

+ (NSFetchRequest<Tag *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
}

@dynamic name;
@dynamic explanation;
@dynamic shareTags;

@end
