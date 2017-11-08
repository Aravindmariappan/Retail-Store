//
//  ItemListingCollectionViewCell.m
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "ItemListingCollectionViewCell.h"

#define kListingCellIdentifier @"ItemListingCollectionViewCellIdntifier"

@interface ItemListingCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;

@end

@implementation ItemListingCollectionViewCell

+ (NSString *)cellIdentifier {
    return kListingCellIdentifier;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView.layer setBorderWidth:0.5];
    [self.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}

- (void)configureCellWithViewModel:(ItemCellViewModel *)viewModel {
    [self.itemImageView setImage:[UIImage imageNamed:viewModel.displayedItemImageName]];
    [self.itemNameLabel setText:viewModel.displayedItemTitle];
    [self.itemPrice setText:viewModel.displayedItemPrice];
}

@end
