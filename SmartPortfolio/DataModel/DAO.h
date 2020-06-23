//
//  DAO.h
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 22.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Stock+CoreDataClass.h"
#import "Sector+CoreDataClass.h"
#import "Share+CoreDataClass.h"
#import "Country+CoreDataClass.h"
#import "News+CoreDataClass.h"
#import "CompanyIndustry+CoreDataClass.h"
#import "Portfolio+CoreDataClass.h"
#import "Tag+CoreDataClass.h"
#import "ShareTags+CoreDataClass.h"
#import "Quote+CoreDataClass.h"
#import "ReferenceShare+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface DAO : NSObject

+ (DAO *) sharedInstance;


@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;



#pragma mark - Service methods

- (NSString *) securityTypeForCode:(NSString *)aCode;


#pragma mark - creation/ update for the records

- (Sector *) sectorForData:(NSDictionary *) aData;
- (NSInteger) sectorsCount;
- (NSArray <Sector *> *) sectorNames;   // sorted by sector; names

- (Tag *) tagForData:(NSDictionary *) aData;
- (NSInteger) tagsCount;
- (NSArray <Tag *> *) tagNames;     // sorted by tag' names

- (Stock *) stockForData:(NSDictionary *) aData;
- (NSInteger) stocksCount;
- (NSArray <Stock *> *) stockNames;     // sorted by stock' names

- (ReferenceShare *) refShareForData:(NSDictionary *) aData;
- (NSInteger) refSharesCount;
- (NSArray <ReferenceShare *> *) refSharesTickers;     // sorted by tickers

- (BOOL) referenceDataNotFilled;


@end

NS_ASSUME_NONNULL_END
