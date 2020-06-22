//
//  CompanyIndustry+CoreDataProperties.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "CompanyIndustry+CoreDataProperties.h"

@implementation CompanyIndustry (CoreDataProperties)

+ (NSFetchRequest<CompanyIndustry *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CompanyIndustry"];
}

@dynamic name;
@dynamic company;

@end
