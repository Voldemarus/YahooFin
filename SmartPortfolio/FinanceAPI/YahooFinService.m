//
//  YahooFinService.m
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 21.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "YahooFinService.h"
#import <UniRest.h>

NSString * const API_HOST   =   @"https://apidojo-yahoo-finance-v1.p.rapidapi.com/";

NSString * const   MARKET_SUMMARY   =   @"market/get-summary";
NSString * const   QUOTES           =   @"market/get-quotes";


@interface YahooFinService ()

@property (nonatomic, retain) NSString * apiKey;

@end

@implementation YahooFinService

+ (YahooFinService *) sharedServiceWithAPIKey:(NSString *)apiKey
{
    static YahooFinService * _finService = nil;
    if (!_finService) {
        _finService = [[YahooFinService alloc] initWithAPIKey:apiKey];
    }
    return _finService;
}

- (instancetype) initWithAPIKey:(NSString *)apikey
{
    if (self = [super init]) {
        self.apiKey = apikey;
    }
    return self;
}


- (void) getMarketSummaries
{
    [self spawnRequestToendpoint:MARKET_SUMMARY withParameters:nil];
}

// @"https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/get-quotes?region=US&lang=en&symbols=APA%252CT.MAC%252CTOT"];
// https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/get-quotes?region=CZ&lang=en?symbols=T,MAC,APA,TOT

// https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/get-quotes?region=CZ&lang=en?symbols=T%252MAC%252APA%252TOT
// https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/get-quotes?region=CZ&lang=en?symbols=T%252CMAC%252CAPA%252CTOT
// https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/get-quotes?region=US&lang=en&symbols=APA%252CT%252CMAC%252CTOT

- (void) getQuotesForShares:(NSArray <NSString *> *)tickers
{
    NSMutableString *quotesList = [[NSMutableString alloc] initWithString:@""];
    for (NSInteger i = 0; i < tickers.count; i++) {
        [quotesList appendString:tickers[i]];
        if (i < tickers.count - 1) {
            [quotesList appendString:@"%252C"];
        }
    }
    NSString *requestParam = [NSString stringWithFormat:@"symbols=%@",quotesList];

    [self spawnRequestToendpoint:QUOTES withParameters:requestParam];
}



#pragma mark - вгутренние сервиснсные мтеоды

/**
    Метод возвращает заголовки, общие для всех вызовов к API. API KEY должен быть определен
    Если его нет, возвращается nil. Запрос без загголовков результата не вернет.

 */
- (NSDictionary *) headers
{
    if (self.apiKey) {
    return  @{
        @"X-RapidAPI-Host": @"apidojo-yahoo-finance-v1.p.rapidapi.com",
         @"X-RapidAPI-Key": self.apiKey};
    } else {
        return nil;
    }
}

- (void) spawnRequestToendpoint:(NSString *)endPoint withParameters:(NSString *)aParam
{
    NSMutableString * urlString = [NSMutableString stringWithFormat:@"%@%@?region=US&lang=en", API_HOST,endPoint];
    if (aParam) {
        [urlString appendFormat:@"?%@",aParam];
    }
#ifdef DEBUG
    NSLog(@"request - %@",urlString);
    NSLog(@"headers - %@",[self headers]);
#endif
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:urlString];
        [request setHeaders:[self headers]];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSLog(@"return code - %ld", (long)code);
        NSLog(@"headers - %@",responseHeaders);


        if ([endPoint isEqualToString:MARKET_SUMMARY]) {
            NSArray <NSDictionary *> *ard = body.object[@"result"];
            for (NSDictionary *market in ard) {
                NSLog(@"market %@",market);
            }
        } else if ([endPoint isEqualToString:QUOTES]) {
            NSLog(@"quotes = %@",body.object);
            NSLog(@"quotes = %@",body.array);

        }



    }];
}


@end
