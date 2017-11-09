//
//  ItemDetailViewController.m
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "CartItem+CoreDataClass.h"

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
    Item *displayedItem = self.viewModel.dispalyedItem;
    CartItem *cartItem = [[DatabaseManager sharedInstance] insertCartItemForItem:displayedItem];
    if (cartItem != nil) {
        [self postItemAddedNotification:cartItem];
        [self showAlertWithSuccessMessage:@"You have successfully added the item to the cart"];
    }
}

- (void)showAlertWithSuccessMessage:(NSString *)successMessage {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Success" message:successMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okayButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okayButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)postItemAddedNotification:(CartItem *)cartItem {
    [[NSNotificationCenter defaultCenter] postNotificationName:kItemAddedToCartNotification object:cartItem];
}

@end
