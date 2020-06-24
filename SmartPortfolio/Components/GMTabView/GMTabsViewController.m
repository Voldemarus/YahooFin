//
//  GMTabsViewController.m
//  AsTest
//
//  Created by Водолазкий В.В. on 24.11.2019.
//  Copyright © 2019 Geomatix Laboratory S.R.O. All rights reserved.
//

#import "GMTabsViewController.h"
#import "GMTabsView.h"

@interface GMTabsViewController () <GMTabViewDelegate>
{
    GMTabsView  *tabBar;
    UIView      *containerView;
    UIView      *bottomView;
    
    NSInteger   lastSelectedViewIndex;
}
@end

@implementation GMTabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




#pragma mark -

- (void) moveToViewController:(NSInteger) index
{
    if (index < 0 || index >= self.childViewControllers.count) {
        index = 0;
    }
    UIViewController *controller = self.childViewControllers[index];
    UIView *newView = controller.view;
    newView.frame = containerView.bounds;
    NSArray *sv = containerView.subviews;
    if (sv.count > 0) {
        // We just have mode selected
        UIView *cView = sv[0];
        newView.alpha = 0.0;
        [containerView addSubview:newView];
        [UIView animateWithDuration:0.88 animations:^{
            cView.alpha = 0.0;
            newView.alpha = 1.0;
        }];
         [cView removeFromSuperview];
    } else {
        if (newView.superview == nil) {
           [containerView addSubview:newView];
           [controller didMoveToParentViewController:self];
            
         }
    }

    lastSelectedViewIndex = index;
    
}

#pragma mark -

- (NSInteger) selectedTabBarIndex
{
    return tabBar.selectedTabIndex;
}

- (void) setSelectedTabBarIndex:(NSInteger)selectedTabBarIndex
{
    tabBar.selectedTabIndex = selectedTabBarIndex;
    [self moveToViewController:selectedTabBarIndex];
}

- (void) setViewControllers:(NSArray<GMTabItemViewController *> *)viewControllers
{
    _viewControllers = viewControllers;
    for (GMTabItemViewController *v in viewControllers) {
        [self addChildViewController:v];
    }
    [self initViews];
    [self setTabsIcon];
    self.selectedTabBarIndex = 0;
    
}

#pragma mark - Internal methods

- (void) initViews
{
    containerView = [[UIView alloc] init];
    [self.view addSubview:containerView];


    tabBar = [[GMTabsView alloc] init];
    tabBar.delegate = self;
    [self.view addSubview:tabBar];
//    CALayer *l = tabBar.layer;
//    l.borderColor = [UIColor redColor].CGColor;
//    l.borderWidth = 2.0;

    bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorNamed:@"GMTabsViewTabsColor"];
    [self.view addSubview:bottomView];
//    CALayer *ll = bottomView.layer;
//    ll.borderColor = [UIColor greenColor].CGColor;
//    ll.borderWidth = 2.0;

    [self.view bringSubviewToFront:tabBar];
    
    [self makeConstraints];
    
 }


- (void) makeConstraints
{
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    tabBar.translatesAutoresizingMaskIntoConstraints = NO;
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:
     @[
         // Container view constraints
         [containerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
         [containerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
         [containerView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
         [containerView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
         
         // Tab bar constraints
         [tabBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
         [tabBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
         [tabBar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
         [tabBar.heightAnchor constraintEqualToConstant:60.0],
         
         // Bottom view constraints
         [bottomView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
         [bottomView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
         [bottomView.topAnchor constraintEqualToAnchor:tabBar.bottomAnchor],
         [bottomView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
     ]];
 }

- (void) setTabsIcon
{
    NSMutableArray *tImages = [NSMutableArray new];
    NSMutableArray *tLables = [NSMutableArray new];

    // Параметры надписи
    CGFloat fontSize = 13;
    UIFont *font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    NSInteger count = self.viewControllers.count;

    CGRect frameLabel = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width / count, fontSize * 1.2);

    for (NSInteger i = 0; i < count; i++) {             // simple iterator to keep order
        UIViewController *vc = self.viewControllers[i];
        GMTabItemViewController *tvc;
       if ([vc isKindOfClass:UINavigationController.class]) {
            UINavigationController *navVC = (UINavigationController *)vc;
            tvc = (GMTabItemViewController *)navVC.topViewController;
        } else {
            tvc = (GMTabItemViewController *)vc;
        }
        NSLog(@"processing - %@  %@, %@",[tvc class], tvc.tabImage, tvc.tabLabel);
        NSAssert(tvc.tabImage, @"tabImage should be set for top view controller");
        NSAssert(tvc.tabLabel, @"tabLabel should be set for each controller");
        [tImages addObject:tvc.tabImage];
        
        NSString *text = _viewControllers[i].tabLabel;//.uppercaseString;
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = text;
        label.font = font;
        label.frame = frameLabel;
        label.tag = BUTTON_TAG_OFFSET + i;
        
        [tabBar addSubview:label];
        
        [tLables addObject:label];

    }
    
    tabBar.tabsImages = tImages;
    tabBar.tabsLabels = tLables;

}

#pragma mark - GMTabViewDelegate

- (void) tabDidSelectAt:(NSInteger)index
{
    self.selectedTabBarIndex = index;
}

@end
