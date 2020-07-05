//
//  MenuCollectionViewController.m
//  SmartPortfolio
//
//  Created by Мария Водолазкая on 05.07.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import "MenuCollectionViewController.h"
#import "MenuCollectionViewCell.h"
#import "GMGradient.h"


@interface MenuCollectionViewController ()

@end

@implementation MenuCollectionViewController

static NSString * const reuseIdentifier = @"MenuCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    // Register cell classes
    [self.collectionView registerClass:[MenuCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib
                                      nibWithNibName:@"MenuCollectionViewCell"
                                      bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:reuseIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:UIContentSizeCategoryDidChangeNotification object:nil];

    // Do any additional setup after loading the view.
    [self setEstimatedSizeIfNeeded];
}

- (void)setEstimatedSizeIfNeeded {
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat estimatedWidth = 30.f;
    CGFloat estimatedHeight = 30.f;
    if (flowLayout.estimatedItemSize.width != estimatedWidth) {
        [flowLayout setEstimatedItemSize:CGSizeMake(estimatedWidth, 100)];
        [flowLayout invalidateLayout];
    }
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuCollectionViewCell *cell = (MenuCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    NSArray *a = [self curcularMenuData];
    
    // 2 - количество sections в collection view
    NSInteger index = 2 * indexPath.section + indexPath.row;
    
    // Configure the cell
    [cell.titleLabel setText: a[index][1]];
    
    UIImage *image = [UIImage imageNamed:a[index][2]];
    [cell.imageView setImage:image];
    
    GMGradient *gradient = a[index][3];
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.colors = @[(id)gradient.startColor.CGColor, (id)gradient.endColor.CGColor];
    gradientLayer.startPoint = gradient.startPoint;
    gradientLayer.endPoint = gradient.endPoint;
    gradientLayer.frame = cell.cellView.bounds;
    [cell.cellView.layer insertSublayer:gradientLayer atIndex:0];
    
    return cell;
}

- (NSArray *) curcularMenuData
{
    GMGradient *gradient = [[GMGradient alloc] init];
    [gradient.colors addObject:[UIColor colorWithR:0 g:0 andB:60 alpha:0.2]];
    [gradient.colors addObject:[UIColor colorWithR:0 g:0 andB:210 alpha:0.7]];

    NSLog(@"colors - %@", gradient.colors);
    
    return @[
        @[@1000, @"News", @"News", gradient],
        @[@1001, @"Portfolio", @"My Portfolio", gradient],
        @[@1002, @"Money", @"My Cash", gradient],
        @[@1003, @"SavingPlan", @"Plans", gradient],
        @[@1004, @"Yield", @"Yield", gradient],
        @[@1005, @"Analytic", @"Visuals", gradient],

    ];
}


#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(collectionView.frame.size.width/2, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = 2 * indexPath.section + indexPath.row;
    NSArray *a = [self curcularMenuData];
    NSLog(@"tapped %@ button", a[index][1]);
}

@end
