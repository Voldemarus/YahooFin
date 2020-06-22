//
//  Share+CoreDataProperties.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Share+CoreDataProperties.h"

@implementation Share (CoreDataProperties)

+ (NSFetchRequest<Share *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Share"];
}

@dynamic companyName;
@dynamic ticker;
@dynamic ceo;
@dynamic address;
@dynamic city;
@dynamic note;
@dynamic employes;
@dynamic phone;
@dynamic securityName;
@dynamic state;
@dynamic website;
@dynamic zip;
@dynamic logoIcon;
@dynamic iexID;
@dynamic quotes;
@dynamic portfolio;
@dynamic industry;
@dynamic country;
@dynamic sector;
@dynamic shareTags;
@dynamic news;
@dynamic stock;

@end
