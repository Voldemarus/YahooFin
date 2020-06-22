//
//  Tag+CoreDataClass.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Tag+CoreDataClass.h"

@implementation Tag

+ (Tag *) getTag:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc
{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[[self class] description]];
    NSString *reqTerm = aData[@"name"];
    if (reqTerm) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"name like [cd] %@", reqTerm];
        req.predicate = pred;
        NSError *error = nil;
        NSArray <Tag *> *result = [moc executeFetchRequest:req error:&error];
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

+ (Tag *) createNewTagForData:(NSDictionary *)aData forMoc:(NSManagedObjectContext *)moc
{
    NSString *reqTerm = aData[@"name"];
    Tag *newRec = [NSEntityDescription insertNewObjectForEntityForName:[[self class] description]
                                                   inManagedObjectContext:moc];
    if (newRec) {
        newRec.name = reqTerm;
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

- (NSString *)description
{
    return [NSString stringWithFormat:@"Tag : %@", self.name];
}

+ (NSArray <Tag *> *) sortedTagNamesInMoc:(NSManagedObjectContext *)moc
{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[[self class] description]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSError *error = nil;
    NSArray <Tag *> *res = [moc executeFetchRequest:req error:&error];
    if (!res && error) {
        NSLog(@"Cannot fetch from %@ --> %@",[self class], [error localizedDescription]);
        return nil;
    }
    return res;
}


@end
