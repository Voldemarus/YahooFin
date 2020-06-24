//
//  ReferenceLoaderVCViewController.m
//  SmartPortfolio
//
//  Created by Водолазкий В.В. on 23.06.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "Utility.h"
#import "ReferenceLoaderVCViewController.h"
#import <YLProgressBar.h>

#import "IEXService.h"
#import "DAO.h"


#define LEFT_RED        15  / 255.0            // Componentes for left interval start
#define LEFT_GREEN        134  / 255.0
#define LEFT_BLUE        216  / 255.0

#define MEDIUM_RED        121  / 255.0                        // components for end of left interval and start of right
#define MEDIUM_GREEN    190  / 255.0
#define MEDIUM_BLUE        127  / 255.0

#define RIGHT_RED        250  / 255.0                        // components for the last border
#define RIGHT_GREEN        241  / 255.0
#define RIGHT_BLUE        60  / 255.0

#define EMPTY_FRAME        104                        // frame of the component
#define EMPTY_BACK        235                    // background color for the empty part

@interface ReferenceLoaderVCViewController () <IEXServiceReferenceDelegate>
{
    IEXService *srv;
    DAO *dao;
    YLProgressBar *pBar;
}
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIView *progressBar;

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
    self.progressBar.backgroundColor = [UIColor clearColor];
    CALayer *l = self.infoView.layer;
    l.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
    l.cornerRadius = self.infoView.frame.size.height * 0.2;
    l.borderWidth = 1.0;
    l.shadowOffset = CGSizeMake(5, 5);

    l = self.progressBar.layer;
    l.cornerRadius = 2.0;
    l.borderColor = [UIColor lightGrayColor].CGColor;
    l.borderWidth = 0.5;

    CGRect frame = self.view.frame;
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *efView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    efView.frame = frame;
    [self.view insertSubview:efView belowSubview:self.infoPanelView];
    l.shadowColor = [UIColor darkGrayColor].CGColor;
    l.borderColor = [UIColor blueColor].CGColor;
    self.operationPrompt.text = @"";
     self.countLabel.text = @"";
    //
    // Progress bar setup
    //
    // https://github.com/sleonardo/YLProgressBar
    //
    CGRect barFrame = self.progressBar.frame;
    barFrame.origin.x = 0;
    barFrame.origin.y = 0;
    pBar = [[YLProgressBar alloc] initWithFrame:barFrame];
    [self.progressBar addSubview:pBar];

    pBar.type               = YLProgressBarTypeFlat;
    pBar.backgroundColor = [UIColor whiteColor];
    //pBar.progressTintColor  = [UIColor blueColor];
    pBar.progressTintColors = @[
        [UIColor colorWithRed:LEFT_RED green:LEFT_GREEN blue:LEFT_BLUE alpha:1.0],
        [UIColor colorWithRed:MEDIUM_RED green:MEDIUM_GREEN blue:MEDIUM_BLUE alpha:1.0],
        [UIColor colorWithRed:RIGHT_RED green:RIGHT_GREEN blue:RIGHT_BLUE alpha:1.0],
    ];
    pBar.trackTintColor = [UIColor clearColor];

    pBar.hideStripes        = YES;
    pBar.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;

    [pBar setProgress:0.0];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSArray *requestSignals = @[
        IEXSERVICE_REF_SECTOR_REQUESTED, IEXSERVICE_REF_TAG_REQUESTED,
        IEXSERVICE_REF_STOCK_REQUESTED,
        IEXSERVICE_REF_SHARE_REQUESTED,
    ];
    for (NSString *sigName in requestSignals) {
        [nc addObserver:self selector:@selector(updateOperationPrompt:) name:sigName object:nil];
    }
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
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.view removeFromSuperview];
        });
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
    [pBar setProgress:0.0];   // reset progress indicator
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
            [self->pBar setProgress:prog animated:NO];
        });
         if ([notifier isEqualToString:IEXSERVICE_REF_TAG_RECEIVED]) {
            Tag *tag = [dao tagForData:d];
        } else if ([notifier isEqualToString:IEXSERVICE_REF_SECTOR_RECEIVED]) {
            Sector *sector = [dao sectorForData:d];
         } else if ([notifier isEqualToString:IEXSERVICE_REF_SHARE_RECEIVED]) {
            ReferenceShare *s = [dao refShareForData:d];
         } else if ([notifier isEqualToString:IEXSERVICE_REF_STOCK_RECEIVED]) {
            Stock *stock = [dao stockForData:d];

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
