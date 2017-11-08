//
//  ItemDetailViewController.m
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "ItemDetailViewController.h"

@interface ItemDetailViewController ()

@property ItemCellViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;

@end

@implementation ItemDetailViewController

+ (NSString *)itemDetailVCStoryBoardIdentifier {
    return @"ItemDetailVCIdentifier";
}

- (void)configureWithViewModel:(ItemCellViewModel *)cellViewModel {
    self.viewModel = cellViewModel;
}

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

#pragma mark -

- (void)configureView {
    [self.itemImageView setImage:[UIImage imageNamed:self.viewModel.displayedItemImageName]];
    [self.itemTitle setText:self.viewModel.displayedItemTitle];
    [self.itemPrice setText:self.viewModel.displayedItemPrice];
    [self.navigationItem setTitle:self.viewModel.displayedItemTitle];
}

#pragma mark -

- (IBAction)addToCartButtonTapped:(id)sender {
}

@end
