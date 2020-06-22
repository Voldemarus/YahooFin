//
//  IEXService.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IEXService : NSObject

@property (nonatomic, readonly) BOOL sandbox;

+ (IEXService *) sharedInstanceWithToken:(NSString *)aToken forSandbox:(BOOL)sandbox;

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

NS_ASSUME_NONNULL_END
