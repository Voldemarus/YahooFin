//
//  IEXService.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//

#import <Foundation/Foundation.h>

extern NSString * const IEXSERVICE_REF_SECTOR_REQUESTED;
extern NSString * const IEXSERVICE_REF_SECTOR_RECEIVED;
extern NSString * const IEXSERVICE_REF_TAG_REQUESTED;
extern NSString * const IEXSERVICE_REF_TAG_RECEIVED;
extern NSString * const IEXSERVICE_REF_STOCK_REQUESTED;
extern NSString * const IEXSERVICE_REF_STOCK_RECEIVED;
extern NSString * const IEXSERVICE_REF_SHARE_REQUESTED;
extern NSString * const IEXSERVICE_REF_SHARE_RECEIVED;


@protocol IEXServiceReferenceDelegate <NSObject>
@optional
- (void) processReferenceTagData:(NSArray <NSDictionary *> *) data;
- (void) processReferenceShareData:(NSArray <NSDictionary *> *) data;
- (void) processReferenceSectorData:(NSArray <NSDictionary *> *) data;
- (void) processReferenceStockData:(NSArray <NSDictionary *> *) data;
@end


@interface IEXService : NSObject

@property (nonatomic) BOOL sandbox;
@property (nonatomic, retain) NSString *token;

@property (nonatomic, retain) id < IEXServiceReferenceDelegate> referenceDelegate;

// Call in AppDelegate to initalize token
// + (IEXService *) sharedInstanceWithToken:(NSString *)aToken forSandbox:(BOOL)sandbox;
+ (IEXService *) sharedInstance;

// Request data about particular ticker
- (void) requestStockQuoteForTicker:(NSString *)aTicker;

- (void) requestCompanyInfoForTicker:(NSString *)aTicker;

- (void) requestLogoForTicker:(NSString *)aTicker;

- (void) requestDividendForTicker:(NSString *)aTicker;

- (void) requestStockRefData;
- (void) requestTagsRefData;
- (void) requestSharesRefData;
- (void) requestSectorRefData;

@end

