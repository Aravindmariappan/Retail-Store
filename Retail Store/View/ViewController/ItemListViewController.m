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
        [[NetworkManager sharedInstance] fetchAllItemsWithCompletionBlock:^(NSArray *items) {
            self.itemListingViewModel = [[ItemListingViewModel alloc] initWithAllItems:items];
            [self.collectionView reloadData];
        }];
    }
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
    [backBarButtonItem setTitle:@" "];
    [self.navigationItem setBackBarButtonItem:backBarButtonItem];
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
    NSInteger itemsCount = [self.itemListingViewModel.contentArray count];

    return itemsCount;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ItemCellViewModel *cellViewModel = [self.itemListingViewModel cellViewModelAtIndex:indexPath.row];
    ItemListingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ItemListingCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell configureCellWithViewModel:cellViewModel];
    
    return cell;
}

#pragma mark - Collection View Delegate


@end
