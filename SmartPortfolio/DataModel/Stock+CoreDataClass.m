//
//  Stock+CoreDataClass.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Stock+CoreDataClass.h"
#import "Country+CoreDataClass.h"

@implementation Stock

/*
    description = "becrA niEshectDiexSbhgu uaa i";
    exchange = ASD;
    exchangeSuffix = "D-H";
    mic = DXAS;
    region = AE;
 */

+ (Stock *) getStock:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc
{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[[self class] description]];
    NSString *reqTerm = aData[@"stockName"];
    if (reqTerm) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"stockName like [cd] %@", reqTerm];
        req.predicate = pred;
        NSError *error = nil;
        NSArray <Stock *> *result = [moc executeFetchRequest:req error:&error];
        if (!error && result) {
            if (result.count > 0) {
                return result[0];
            }
            return nil;
        }
        NSLog(@"Cannot fetch from %@ for %@ --> %@",[self class], reqTerm, [error localizedDescription]);
    }
    return nil;
}

+ (Stock *) createNewStockForData:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc
{
    NSString *reqTerm = aData[@"stockName"];
    Stock *newRec = [NSEntityDescription insertNewObjectForEntityForName:[[self class] description]
                                                   inManagedObjectContext:moc];
    if (newRec) {
        newRec.stockName = reqTerm;
        newRec.explanation = aData[@"description"];
        newRec.suffix = aData[@"exchangeSuffix"];
        newRec.mic = aData[@"mic"];

        NSString *countryCode = aData[@"region"];
        Country *c  = [Country getcountry:countryCode forMoc:moc];
        if (!c) {
            c = [Country createNewCountryForshortName:countryCode forMoc:moc];
        }
        newRec.country = c;
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

+ (NSArray <Stock *> *) sortedStockNamesInMoc:(NSManagedObjectContext *) moc
{
    NSFetchRequest *req = [Stock fetchRequest];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"stockName" ascending:YES]];
    NSError *error = nil;
    NSArray <Stock *> *res = [moc executeFetchRequest:req error:&error];
    if (!res && error) {
        NSLog(@"Cannot fetch from %@ --> %@",[self class], [error localizedDescription]);
        return nil;
    }
    return res;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Stock : %@ (%@)", self.stockName, self.explanation];
}




@end
