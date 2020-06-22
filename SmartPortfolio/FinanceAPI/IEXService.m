//
//  IEXService.m
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//

#import "IEXService.h"
#import "DAO.h"

NSString * const IEXSERVICE_REF_SECTOR_REQUESTED    =   @"VVV_IEX_SECTOR_REQUEST";
NSString * const IEXSERVICE_REF_SECTOR_RECEIVED     =   @"VVV_IEX_SECTOR_RECEIVED";
NSString * const IEXSERVICE_REF_TAG_REQUESTED       =   @"VVV_IEX_TAG_REQUEST";
NSString * const IEXSERVICE_REF_TAG_RECEIVED        =   @"VVV_IEX_TAG_RECEIVED";
NSString * const IEXSERVICE_REF_TICKER_REQUESTED    =   @"VVV_IEX_TICK_REQUEST";
NSString * const IEXSERVICE_REF_TICJER_RECEIVED     =   @"VVV_IEX_TICK_RECEIVED";
NSString * const IEXSERVICE_REF_STOCK_REQUESTED     =   @"VVV_IEX_STOCK_REQUEST";
NSString * const IEXSERVICE_REF_STOCK_RECEIVED      =   @"VVV_IEX_STOCK_RECEIVED";
NSString * const IEXSERVICE_REF_SHARE_REQUESTED     =   @"VVV_IEX_SHARE_REQUEST";
NSString * const IEXSERVICE_REF_SHARE_RECEIVED      =   @"VVV_IEX_SHARE_RECEIVED";


NSString * const STOCK_QUOTE_TEMPLATE   =   @"/stock/%@/quote";
NSString * const COMPANY_TEMPLATE       =   @"/stock/%@/company";
NSString * const LOGO_TEMPLATE          =   @"/stock/%@/logo";
NSString * const DIVIDEND_TEMPLATE      =   @"/stock/%@/dividends/";

NSString * const REF_DATA_TICKERS       =   @"/ref-data/symbols";
NSString * const REF_DATA_TAGS          =   @"/ref-data/tags";
NSString * const REF_DATA_STOCK         =   @"/ref-data/exchanges";
NSString * const REF_DATA_SECTOR        =   @"/ref-data/sectors";


typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeStockQuote = 0,
    RequestTypeCompanyInfo,
    RequestTypeLogo,
    RequestTypeDividend,
    RequestTypeRefDataTickers,
    RequestRefDataTags,
    RequestRefDatExchange,
    RequestRefDataSectors,
};


@interface IEXService ()
{
    BOOL _sandbox;
    NSString *token;
    DAO *dao;
   NSNotificationCenter *nc;
}

@end


@implementation IEXService

+ (IEXService *) sharedInstanceWithToken:(NSString *)aToken forSandbox:(BOOL)sandbox
{
    static IEXService *__service = nil;
    if (!__service) {
        __service = [[IEXService alloc] initWithToken:aToken forSandbox:sandbox];
    }
    return __service;
}

- (instancetype) initWithToken:(NSString *)aToken forSandbox:(BOOL)sandbox
{
    if (self = [super init]) {
        _sandbox = sandbox;
        token = aToken;
        dao = [DAO sharedInstance];
        nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(initialReferenceDateLoading:) name:IEXSERVICE_REF_SECTOR_RECEIVED object:nil];
        [nc addObserver:self selector:@selector(initialReferenceDateLoading:) name:IEXSERVICE_REF_TAG_RECEIVED object:nil];
        [nc addObserver:self selector:@selector(initialReferenceDateLoading:) name:IEXSERVICE_REF_STOCK_RECEIVED object:nil];
        [nc addObserver:self selector:@selector(initialReferenceDateLoading:) name:IEXSERVICE_REF_SHARE_RECEIVED object:nil];
        //
        // Load reference data if required
        //
        if ([dao sectorsCount] <= 0) {
            [self requestSectorRefData];
        }
        else if ([dao tagsCount] <= 0) {
            [self requestTagsRefData];
        }
    }
    return self;
}


#pragma mark -

- (void) requestStockRefData
{
    NSString *urlString = [self getReuestStringForRequest:REF_DATA_STOCK withParams:nil];
    [nc postNotificationName:IEXSERVICE_REF_STOCK_REQUESTED object:nil];
    [self spawnRequest:urlString withID:RequestRefDatExchange forTicker:nil];
}

- (void) requestTagsRefData
{
    NSString *urlString = [self getReuestStringForRequest:REF_DATA_TAGS withParams:nil];
     [nc postNotificationName:IEXSERVICE_REF_TAG_REQUESTED object:nil];
    [self spawnRequest:urlString withID:RequestRefDataTags forTicker:nil];
}

- (void) requestSharesRefData
{
    NSString *urlString = [self getReuestStringForRequest:REF_DATA_TICKERS withParams:nil];
    [nc postNotificationName:IEXSERVICE_REF_SHARE_REQUESTED object:nil];
    [self spawnRequest:urlString withID:RequestTypeRefDataTickers forTicker:nil];
}

- (void) requestSectorRefData
{
    NSString *urlString = [self getReuestStringForRequest:REF_DATA_SECTOR withParams:nil];
    [nc postNotificationName:IEXSERVICE_REF_SECTOR_REQUESTED object:nil];
    [self spawnRequest:urlString withID:RequestRefDataSectors forTicker:nil];
}

- (void) requestDividendForTicker:(NSString *)aTicker
{
    NSString *request = [NSString stringWithFormat:DIVIDEND_TEMPLATE, aTicker];
    NSString *urlString = [self getReuestStringForRequest:request withParams:nil];
    [self spawnRequest:urlString withID:RequestTypeStockQuote forTicker:aTicker];
}


- (void) requestLogoForTicker:(NSString *)aTicker
{
    NSString *request = [NSString stringWithFormat:LOGO_TEMPLATE, aTicker];
    NSString *urlString = [self getReuestStringForRequest:request withParams:nil];
    [self spawnRequest:urlString withID:RequestTypeStockQuote forTicker:aTicker];
}

- (void) requestCompanyInfoForTicker:(NSString *)aTicker
{
    NSString *request = [NSString stringWithFormat:COMPANY_TEMPLATE, aTicker];
    NSString *urlString = [self getReuestStringForRequest:request withParams:nil];
    [self spawnRequest:urlString withID:RequestTypeStockQuote forTicker:aTicker];
}

- (void) requestStockQuoteForTicker:(NSString *)aTicker
{
    NSString *request = [NSString stringWithFormat:STOCK_QUOTE_TEMPLATE, aTicker];
    NSDictionary *filter = @{
        @"filter" : @"symbol,close,closeTime,volume",
    };
    NSString *urlString = [self getReuestStringForRequest:request withParams:filter];
    [self spawnRequest:urlString withID:RequestTypeStockQuote forTicker:aTicker];
}


#pragma mark - Generate requuests

// exanmple
// https://sandbox.iexapis.com/stable/stock/APAJF/quote?token=Tpk_4d3da54bcc5a473894865ac1988a11ee


- (NSString *) getReuestStringForRequest:(NSString *)req withParams:(NSDictionary *)aPar
{
    NSAssert(req, @"request should be non empty");
    NSMutableString *reqStr = [NSMutableString stringWithFormat:@"https://%@.iexapis.com/stable/%@?token=%@",
                               (_sandbox ? @"sandbox": @"cloud"),req, token];

    if (aPar && aPar.count > 0) {
        for (NSString *key in aPar) {
            NSString *parameterString = [NSString stringWithFormat:@"%@=%@",
                                         key, aPar[key]];
            [reqStr appendFormat:@"&%@", parameterString];
        }
    }
    return reqStr;
}

- (void) spawnRequest:(NSString *)req withID:(RequestType) aid forTicker:(NSString *)aTicker
{
    NSLog(@"req - %@", req);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:req]
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                               timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSError *parseError = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            if (error) {
                NSLog(@"Cannot parse incoming result - %@", [error localizedDescription]);
            } else {
                NSLog(@"result - %@", result);
                switch(aid) {
                    case RequestTypeStockQuote:     [self parseStockQuote:result]; break;
                    case RequestTypeLogo:           [self getAnLoadLogo:result forTicker:aTicker]; break;
                    case RequestTypeCompanyInfo:    [self getAndLoadCompanyInfo:result forTicker:aTicker]; break;
                    case RequestTypeDividend:       [self getAndLoadDividendInfo:result forTicker:aTicker]; break;
                    case RequestRefDataTags:        [self getAndLoadTagsRefData:result]; break;
                    case RequestTypeRefDataTickers: [self getAndLoadTickerRefData:result]; break;
                    case RequestRefDatExchange:     [self getAndLoadStockRefData:result]; break;
                    case RequestRefDataSectors:     [self getAndLoadSectorsRefData:result]; break;
                }
            }
        }
    }];
    [dataTask resume];
}


- (void) parseStockQuote:(NSDictionary *)data
{

}

- (void) getAnLoadLogo:(NSDictionary *)data forTicker:(NSString *)aTicker
{

}

- (void) getAndLoadCompanyInfo:(NSDictionary *)data forTicker:(NSString *)aTicker
{

}

- (void) getAndLoadDividendInfo:(NSDictionary *)data forTicker:(NSString *)aTicker
{

}

- (void) getAndLoadTagsRefData:(NSDictionary *) data
{
    for (NSDictionary *d in data) {
        Tag *tag = [dao tagForData:d];
#ifdef DEBUG
        NSLog(@"Tag - %@", tag);
#endif
    }
    [dao saveContext];
    [nc postNotificationName:IEXSERVICE_REF_TAG_RECEIVED object:@2];
}

- (void) getAndLoadTickerRefData:(NSDictionary *) data
{
    for (NSDictionary *d in data) {
        Stock *stock = [dao stockForData:d];
#ifdef DEBUG
        NSLog(@"Stock - %@", stock);
#endif
    }
    [dao saveContext];
    [nc postNotificationName:IEXSERVICE_REF_SHARE_RECEIVED object:@4];
}

- (void) getAndLoadStockRefData:(NSDictionary *) data
{
    for (NSDictionary *d in data) {
        Stock *stock = [dao stockForData:d];
#ifdef DEBUG
        NSLog(@"Stock - %@", stock);
#endif
    }
    [dao saveContext];
    [nc postNotificationName:IEXSERVICE_REF_STOCK_RECEIVED object:@3];
}

- (void) getAndLoadSectorsRefData:(NSArray *) data
{
    for (NSDictionary *d in data) {
        Sector *sector = [dao sectorForData:d];
#ifdef DEBUG
        NSLog(@"Sector - %@", sector);
#endif
    }
    [dao saveContext];
    [nc postNotificationName:IEXSERVICE_REF_SECTOR_RECEIVED object:@1];
}

- (void) initialReferenceDateLoading:(NSNotification *)note
{
    NSInteger code = [[note object] integerValue];
    if (code == 1) {
        // sectors were processed
        if ([dao tagsCount] <= 0) {
            [self requestTagsRefData];
            return;
        } else {
            code = 3;
        }
    }
    if (code == 2) {
        // tags were processed
        if ([dao stocksCount] <= 0) {
            [self requestStockRefData];
            return;
        } else {
            code = 4;
        }
    }
    if (code == 3) {
        // stocks were procesed
        if ([dao refSharesCount] <= 0) {
            [self requestSharesRefData];
            return;
        } else {
            code = 5;
        }
    }
}

@end
