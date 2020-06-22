//
//  Country+CoreDataClass.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Country+CoreDataClass.h"
#import "CountryInfo.h"

@implementation Country


- (UIImage *) flag
{
    return [[CountryInfo sharedInstance] countryFlagForCode:self.shortName];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"Country - %@",self.shortName];
}

+ (Country *) getcountry:(NSString *)shortName forMoc:(NSManagedObjectContext *)moc
{
    NSFetchRequest *req = [Country fetchRequest];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"shortName like [cd] %@", shortName];
    req.predicate = pred;
    NSError *error = nil;
    NSArray <Country *> *result = [moc executeFetchRequest:req error:&error];
    if (!error && result) {
        if (result.count > 0) {
            return result[0];
        }
        return nil;
    }
    NSLog(@"Cannot fetch from %@ for %@ --> %@",[self class], shortName, [error localizedDescription]);

    return nil;
}

+ (Country *) createNewCountryForshortName:(NSString *)shortName forMoc:(NSManagedObjectContext *)moc
{
    Country *newRec = [NSEntityDescription insertNewObjectForEntityForName:[[self class] description]
                                                  inManagedObjectContext:moc];
    if (newRec) {
        newRec.shortName = shortName;
        newRec.fullName = [[CountryInfo sharedInstance] countryNameForCode:shortName];
     }
    return newRec;
}

+ (NSInteger) recordsCountForMoc:(NSManagedObjectContext *) moc
{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[[self class] description]];
    NSError *error = nil;
    NSInteger res = [moc countForFetchRequest:req error:&error];
    if (error) {
        NSLog(@"Cannot get amount of records for %@ - %@", [self class], [error localizedDescription]);
        return -1;
    }
    return res;
}

+ (NSArray <Country *> *) sortedCountryNamesInMoc:(NSManagedObjectContext *) moc
{
    NSFetchRequest *req = [Country fetchRequest];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"shortName" ascending:YES]];
    NSError *error = nil;
    NSArray <Country *> *res = [moc executeFetchRequest:req error:&error];
    if (!res && error) {
        NSLog(@"Cannot fetch from %@ --> %@",[self class], [error localizedDescription]);
        return nil;
    }
    return res;
}


@end
