//
//  ReferenceLoaderVCViewController.m
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 23.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "Utility.h"
#import "ReferenceLoaderVCViewController.h"

#import "IEXService.h"
#import "DAO.h"


@interface ReferenceLoaderVCViewController () <IEXServiceReferenceDelegate>
{
    IEXService *srv;
    DAO *dao;
}
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *operationPrompt;
@property (weak, nonatomic) IBOutlet UIView *infoPanelView;

@end

@implementation ReferenceLoaderVCViewController

- (instancetype) init
{
    if (self = [super initWithNibName:[[self class] description] bundle:nil]) {

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    dao = [DAO sharedInstance];
    srv = [IEXService sharedInstance];
    srv.referenceDelegate = self;
    self.view.backgroundColor = [UIColor clearColor];

    CALayer *l = self.infoView.layer;
    l.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
    l.cornerRadius = self.infoView.frame.size.height * 0.2;
    l.borderWidth = 1.0;
    l.shadowOffset = CGSizeMake(5, 5);
    CGRect frame = self.view.frame;
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *efView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    efView.frame = frame;
    [self.view insertSubview:efView belowSubview:self.infoPanelView];
    l.shadowColor = [UIColor darkGrayColor].CGColor;
    l.borderColor = [UIColor blueColor].CGColor;
    self.operationPrompt.text = @"";
    self.progress.progress = 0.0;
    self.countLabel.text = @"";
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSArray *requestSignals = @[
        IEXSERVICE_REF_SECTOR_REQUESTED, IEXSERVICE_REF_TAG_REQUESTED,
        IEXSERVICE_REF_STOCK_REQUESTED,
        IEXSERVICE_REF_SHARE_REQUESTED,
    ];
//    NSArray *receivedSignals = @[
//        IEXSERVICE_REF_SECTOR_RECEIVED, IEXSERVICE_REF_TAG_RECEIVED,
//        IEXSERVICE_REF_TICJER_RECEIVED, IEXSERVICE_REF_STOCK_RECEIVED,
//        IEXSERVICE_REF_SHARE_RECEIVED,
//    ];
    for (NSString *sigName in requestSignals) {
        [nc addObserver:self selector:@selector(updateOperationPrompt:) name:sigName object:nil];
    }
//    for (NSString *sigName in receivedSignals) {
//        [nc addObserver:self selector:@selector(reinitProgressor:) name:sigName object:nil];
//    }
}


- (void) loadReferenceData
{
    if ([dao sectorsCount] <= 0) {
        [srv requestSectorRefData];
    } else if ([dao tagsCount] <= 0) {
        [srv requestTagsRefData];
    } else if ([dao stocksCount] <= 0) {
        [srv requestStockRefData];
    } else if ([dao refSharesCount] <= 0) {
        [srv requestSharesRefData];
    } else {
        // leave recursion, if all reference data loaded
        srv.referenceDelegate = nil;
        [self.view removeFromSuperview];
    }
}



#pragma mark - Selectors

- (void) updateOperationPrompt:(NSNotification *)note
{
    NSString *notifier = [note name];
    NSDictionary *prompts = @{
        IEXSERVICE_REF_SECTOR_REQUESTED     :   RStr(@"Industry sectors loading"),
        IEXSERVICE_REF_TAG_REQUESTED        :   RStr(@"Tags are loading"),
        IEXSERVICE_REF_SHARE_REQUESTED      :   RStr(@"Shares info is loading"),
        IEXSERVICE_REF_STOCK_REQUESTED      :   RStr(@"Stocks list loading"),
     };
    NSString *info = prompts[notifier];
    if (info) {
        self.operationPrompt.text = info;
    } else {
        self.operationPrompt.text = notifier;
    }
    self.progress.progress = 0.0;   // reset progress indicator
    self.countLabel.text = @"...";
}

- (void)  reinitProgressor:(NSString *)notifier data:(NSArray <NSDictionary *> *)data
{
    NSDictionary *prompts = @{
        IEXSERVICE_REF_SECTOR_RECEIVED     :   RStr(@"Industry sectors loading"),
        IEXSERVICE_REF_TAG_RECEIVED        :   RStr(@"Tags loading..."),
        IEXSERVICE_REF_SHARE_RECEIVED      :   RStr(@"Tickers loading..."),
        IEXSERVICE_REF_STOCK_RECEIVED      :   RStr(@"Stocks list loading"),
    };
    NSString *info = prompts[notifier];
     dispatch_async(dispatch_get_main_queue(), ^{
         if (info) {
             self.operationPrompt.text = info;
         } else {
             self.operationPrompt.text = notifier;
         }
     });
    double totalCount = data.count;
    NSInteger step = 0;
    for (NSInteger i = 0; i < data.count; i++) {
        NSDictionary *d = data[i];
        step++;
        double prog = step / totalCount;
        NSString *stepPrompt = [NSString stringWithFormat:@"%3d/%.0f",(int)step,totalCount];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.countLabel.text = stepPrompt;
            self.progress.progress = prog;
        });
         if ([notifier isEqualToString:IEXSERVICE_REF_TAG_RECEIVED]) {
            Tag *tag = [dao tagForData:d];
            DLog(@"%@",tag);
        } else if ([notifier isEqualToString:IEXSERVICE_REF_SECTOR_RECEIVED]) {
            Sector *sector = [dao sectorForData:d];
            DLog(@"%@",sector);
        } else if ([notifier isEqualToString:IEXSERVICE_REF_SHARE_RECEIVED]) {
            ReferenceShare *s = [dao refShareForData:d];
            DLog(@"%@",s);
        } else if ([notifier isEqualToString:IEXSERVICE_REF_STOCK_RECEIVED]) {
            Stock *stock = [dao stockForData:d];
            DLog(@"%@",stock);
        }
    }
    [dao saveContext];
    [self loadReferenceData]; // next iteration (recursion point!)
}

- (void) processReferenceTagData:(NSArray <NSDictionary *> *) data
{
    [self reinitProgressor:IEXSERVICE_REF_TAG_RECEIVED data:data];
}

- (void) processReferenceShareData:(NSArray <NSDictionary *> *) data
{
    [self reinitProgressor:IEXSERVICE_REF_SHARE_RECEIVED data:data];
}

- (void) processReferenceSectorData:(NSArray <NSDictionary *> *) data
{
    [self reinitProgressor:IEXSERVICE_REF_SECTOR_RECEIVED data:data];
}

- (void) processReferenceStockData:(NSArray <NSDictionary *> *) data
{
    [self reinitProgressor:IEXSERVICE_REF_STOCK_RECEIVED data:data];
}



@end
