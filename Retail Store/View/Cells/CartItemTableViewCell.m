//
//  CartItemTableViewCell.m
//  Retail Store
//
//  Created by Aravind on 10/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "CartItemTableViewCell.h"

#define kCartItemCellIdentifier @"CartItemCellIdentifier"
@interface CartItemTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *displayedImageView;
@property (weak, nonatomic) IBOutlet UILabel *displayedCartItemName;
@property (weak, nonatomic) IBOutlet UILabel *displayedItemPrice;
@property (weak, nonatomic) IBOutlet UILabel *displayedItemQuantity;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation CartItemTableViewCell

+ (NSString *)cellIdentifier {
    return kCartItemCellIdentifier;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.deleteButton.layer setBorderWidth:0.5];
    [self.deleteButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}

- (void)configureWithViewModel:(CartItemCellViewModel *)viewModel {
    [self.displayedImageView setImage:[UIImage imageNamed:viewModel.displayedItemImageName]];
    [self.displayedCartItemName setText:viewModel.displayedItemTitle];
    [self.displayedItemPrice setText:viewModel.displayedItemPrice];
    [self.displayedItemQuantity setText:viewModel.displayedItemQuantity];
}

- (IBAction)deleteButtonTapped:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cartItemCell:deleteButtonTapped:)]) {
        [self.delegate cartItemCell:self deleteButtonTapped:sender];
    }
}

@end
