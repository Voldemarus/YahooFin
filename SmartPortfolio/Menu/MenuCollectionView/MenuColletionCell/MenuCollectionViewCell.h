//
//  MenuCollectionViewCell.h
//  SmartPortfolio
//
//  Created by Мария Водолазкая on 05.07.2020.
//  Copyright © 2020 Водолазкий В.В. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *cellView;


@end

NS_ASSUME_NONNULL_END
