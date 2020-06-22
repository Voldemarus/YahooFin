//
//  DAO.h
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 22.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface DAO : NSObject

+ (DAO *) sharedInstance;


@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;



#pragma mark - Service methods

- (NSString *) securityTypeForCode:(NSString *)aCode;


@end

NS_ASSUME_NONNULL_END
