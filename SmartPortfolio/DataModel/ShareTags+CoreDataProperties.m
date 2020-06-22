//
//  ShareTags+CoreDataProperties.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "ShareTags+CoreDataProperties.h"

@implementation ShareTags (CoreDataProperties)

+ (NSFetchRequest<ShareTags *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ShareTags"];
}

@dynamic share;
@dynamic tag;

@end
