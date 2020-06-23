//
//  ReferenceShare+CoreDataClass.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "ReferenceShare+CoreDataClass.h"
#import "Country+CoreDataClass.h"
#import "Stock+CoreDataClass.h"

@implementation ReferenceShare

/*

 {
 "symbol": "A",
 "name": "Agilent Technologies Inc.",
 "date": "2019-03-07",
 "type": "cs",
 "iexId": "IEX_46574843354B2D52",
 "region": "US",
 "currency": "USD",
 "isEnabled": true,
 "figi": "BBG000C2V3D6",
 "cik": "1090872",
 },
 */

+ (ReferenceShare *) getShare:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc
{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[[self class] description]];
    NSString *reqTerm = aData[@"iexId"];
    if (reqTerm) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"iexID like [cd] %@", reqTerm];
        req.predicate = pred;
        NSError *error = nil;
        NSArray <ReferenceShare *> *result = [moc executeFetchRequest:req error:&error];
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

/*
 {
 cik = 8334;
 currency = USD;
 date = "2020-06-22";
 exchange = SAN;
 figi = 4X0BBGB0092B;
 iexId = "IEX_5737584C53442D52";
 isEnabled = 1;
 name = " ecoatroitcaAnnioiaClArtmp nr";
 region = US;
 symbol = AAME;
 type = cs;
 },
 */

+ (ReferenceShare *) createNewShareForData:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc
{
    NSString *reqTerm = aData[@"iexId"];
    ReferenceShare *newRec = [NSEntityDescription insertNewObjectForEntityForName:[[self class] description]
                                                  inManagedObjectContext:moc];
     if (newRec) {
        newRec.iexID= reqTerm;
        newRec.ticker = aData[@"symbol"];
        newRec.name = aData[@"name"];
        NSString *dateStr = aData[@"date"];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"YYYY-MM-DD"];
        NSDate *d = [df dateFromString:dateStr];
        newRec.generated = (d ? d : [NSDate date]);
        newRec.typeCode = aData[@"type"];
        newRec.enabled = [aData[@"isEnabled"] boolValue];
        NSString *countryCode = aData[@"region"];
        Country *c  = [Country getcountry:countryCode forMoc:moc];
        if (!c) {
            c = [Country createNewCountryForshortName:countryCode forMoc:moc];
        }
        newRec.country = c;
        NSString *exchangeCode = aData[@"exchange"];
        if (exchangeCode) {
            Stock *s = [Stock getStockForCode:exchangeCode inMoc:moc];
            newRec.stock = s;
        }
        NSError *error = nil;
        [moc save:&error];
        if (error) {
            NSLog(@"ReferenceShare : cannot save context !");
        }
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

+ (NSArray <ReferenceShare *> *) sortedStockNamesInMoc:(NSManagedObjectContext *) moc
{
    NSFetchRequest *req = [ReferenceShare fetchRequest];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"ticker" ascending:YES]];
    NSError *error = nil;
    NSArray <ReferenceShare *> *res = [moc executeFetchRequest:req error:&error];
    if (!res && error) {
        NSLog(@"Cannot fetch from %@ --> %@",[self class], [error localizedDescription]);
        return nil;
    }
    return res;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"ReferenceShare : %@ (%@)", self.ticker, self.name];
}


@end
