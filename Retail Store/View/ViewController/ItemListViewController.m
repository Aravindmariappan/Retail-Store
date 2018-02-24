//
//  RSItemListViewController.m
//  Retail Store
//
//  Created by Aravind on 07/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "ItemListViewController.h"
#import "ItemListingViewModel.h"
#import "ItemListingCollectionViewCell.h"
#import "ItemDetailViewController.h"

static CGFloat const itemCellHeight = 220.0;

@interface ItemListViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (readwrite) ItemListingViewModel *itemListingViewModel;

@end

@implementation ItemListViewController

+ (NSString *)itemListVCIdentifier {
    return @"ItemListStoryboardID";
}

- (void)configureWithViewModel:(ItemListingViewModel *)itemListingViewModel {
    self.itemListingViewModel = itemListingViewModel;
}

#pragma mark - View Controller Life-cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureCollectionView:self.collectionView];
    //Load All Items Only When No Data Available
    if(self.itemListingViewModel == nil) {
        self.itemListingViewModel = [[ItemListingViewModel alloc] initWithListingType:ItemListingTypeAll];
    }
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
    [backBarButtonItem setTitle:@" "];
    [self.navigationItem setBackBarButtonItem:backBarButtonItem];
    [self.navigationItem setTitle:self.itemListingViewModel.navTitle];
}

#pragma mark - View Config

- (void)configureCollectionView:(UICollectionView *)collectionView {
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    UINib *cellNib = [UINib nibWithNibName:@"ItemListingCollectionViewCell" bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:[ItemListingCollectionViewCell cellIdentifier]];
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width/2, itemCellHeight);
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger itemsCount = [self.itemListingViewModel getItemsCount];

    return itemsCount;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ItemCellViewModel *cellViewModel = [self.itemListingViewModel cellViewModelAtIndex:indexPath.row];
    ItemListingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ItemListingCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell configureCellWithViewModel:cellViewModel];
    
    return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCellViewModel *cellViewModel = [self.itemListingViewModel cellViewModelAtIndex:indexPath.row];
    
    ItemDetailViewController *itemDetailVC = (ItemDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:[ItemDetailViewController itemDetailVCStoryBoardIdentifier]];
    [itemDetailVC configureWithViewModel:cellViewModel];
    [self.navigationController pushViewController:itemDetailVC animated:YES];
}

#pragma mark - Configure Actionsheet

- (IBAction)filterButtonTapped:(id)sender {
    [self showActionSheet];
}

- (void)showActionSheet {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Furniture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.itemListingViewModel filterArrayBasedOnListingType:[self typeForCategoryString:@"Furniture"]];
        [self.collectionView reloadData];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Electronics" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.itemListingViewModel filterArrayBasedOnListingType:[self typeForCategoryString:@"Electronics"]];
        [self.collectionView reloadData];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (ItemListingType)typeForCategoryString:(NSString *)categoryString {
    
    if ([categoryString isEqualToString:@"Furniture"]) {
        return ItemListingTypeFurniture;
    }
    else if ([categoryString isEqualToString:@"Electronics"]) {
        return ItemListingTypeElectronics;
    }
    else {
        return ItemListingTypeAll;
    }
}

@end
