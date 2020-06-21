//
//  YahooFinService.h
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 21.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface YahooFinService : NSObject

+ (YahooFinService *) sharedServiceWithAPIKey:(NSString *)apiKey;


- (void) getMarketSummaries;
- (void) getQuotesForShares:(NSArray <NSString *> *)tickers;

@end

NS_ASSUME_NONNULL_END
