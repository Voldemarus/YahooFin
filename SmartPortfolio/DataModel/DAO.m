//
//  DAO.m
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 22.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "DAO.h"
#import "IEXService.h"

@interface DAO () {
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@property (nonatomic, retain) NSManagedObjectContext *moc;
@property (nonatomic, retain) NSManagedObjectContext *storeMoc;

@end

@implementation DAO

+ (DAO *) sharedInstance
{
    static DAO *sharedDAO = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDAO = [[self alloc] init];
    });
    return sharedDAO;
}

- (id) init {
    if (self = [super init]) {
        
    }
    return self;
}




#pragma mark - Service and Reference


- (NSDictionary *) securityTypeDict
{
    return @{
        @"ad"   :   @"ADR",
        @"re"   :   @"REIT",
        @"ce"   :   @"Closed end fund",
        @"si"   :   @"Secondary Issue",
        @"lp"   :   @"Limited Partnerships",
        @"cs"   :   @"Common Stock",
        @"et"   :   @"ETF",
        @"wt"   :   @"Warrant",
        @"oef"  :   @"Open Ended Fund",
        @"cef"  :   @"Closed Ended Fund",
        @"ps"   :   @"Preferred Stock",
        @"ut"   :   @"Unit",
    @"struct"   :   @"Structured Product",
    };
}

- (NSString *) securityTypeForCode:(NSString *)aCode
{
    return [[self securityTypeDict] objectForKey:aCode];
}



#pragma mark - Creation/update of the entitirs


- (Sector *) sectorForData:(NSDictionary *) aData
{
    Sector *s = [Sector getSector:aData forMoc:self.moc];
    if (!s) {
        s = [Sector createNewSecotrForData:aData forMoc:self.storeMoc];

    }
    return s;
}

- (NSInteger) sectorsCount
{
    return [Sector recordsCountForMoc:self.moc];
}

- (NSArray <Sector *> *) sectorNames
{
    return [Sector sortedSectorNamesInMoc:self.moc];
}

- (Tag *) tagForData:(NSDictionary *) aData
{
    Tag *s = [Tag getTag:aData forMoc:self.moc];
    if (!s) {
        s = [Tag createNewTagForData:aData forMoc:self.storeMoc];

    }
    return s;
}

- (NSInteger) tagsCount
{
    return [Tag recordsCountForMoc:self.moc];
}

- (NSArray <Tag *> *) tagNames
{
    return [Tag sortedTagNamesInMoc:self.moc];
}

- (Stock *) stockForData:(NSDictionary *) aData
{
    Stock *s = [Stock getStock:aData forMoc:self.moc];
    if (!s) {
        s = [Stock createNewStockForData:aData forMoc:self.storeMoc];

    }
    return s;
}

- (NSInteger) stocksCount
{
    return [Stock recordsCountForMoc:self.moc];
}

- (NSArray <Stock *> *) stockNames
{
    return [Stock sortedStockNamesInMoc:self.moc];
}

- (ReferenceShare *) refShareForData:(NSDictionary *) aData
{
    ReferenceShare *s = [ReferenceShare getShare:aData forMoc:self.moc];
    if (!s) {
        s = [ReferenceShare createNewShareForData:aData forMoc:self.storeMoc];

    }
    return s;
}

- (NSInteger) refSharesCount
{
    return [ReferenceShare recordsCountForMoc:self.moc];
}

- (NSArray <ReferenceShare *> *) refSharesTickers
{
    return [ReferenceShare sortedShareTickerInMoc:self.moc];
}

- (BOOL) referenceDataNotFilled
{
    if ([self stocksCount] <= 0 || [self sectorsCount] <= 0 ||
        [self tagsCount] <= 0 ||  [self refSharesCount] <= 0) {
        return YES;
    }
    return NO;
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSManagedObjectContext *)moc
{
    return self.persistentContainer.viewContext;
}

- (NSManagedObjectContext *) storeMoc
{
    return self.persistentContainer.newBackgroundContext;
}

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SmartPortfolio"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }

    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



@end
