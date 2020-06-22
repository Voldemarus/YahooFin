//
//  News+CoreDataProperties.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "News+CoreDataProperties.h"

@implementation News (CoreDataProperties)

+ (NSFetchRequest<News *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"News"];
}

@dynamic headline;
@dynamic published;
@dynamic source;
@dynamic url;
@dynamic paywall;
@dynamic summary;
@dynamic image;
@dynamic language;
@dynamic tickers;

@end
