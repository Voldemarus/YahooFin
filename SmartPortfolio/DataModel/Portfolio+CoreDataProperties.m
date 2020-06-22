//
//  Portfolio+CoreDataProperties.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Portfolio+CoreDataProperties.h"

@implementation Portfolio (CoreDataProperties)

+ (NSFetchRequest<Portfolio *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Portfolio"];
}

@dynamic quantity;
@dynamic date;
@dynamic price;
@dynamic bought;
@dynamic share;

@end
