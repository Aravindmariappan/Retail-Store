//
//  CategoriesViewController.m
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CategoryListingViewModel.h"
#import "CategoryListingTableViewCell.h"
#import "ItemListViewController.h"
#import "ItemListingViewModel.h"

@interface CategoriesViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;

@property CategoryListingViewModel *viewModel;

@end

@implementation CategoriesViewController

static NSString const *detailScreenSegueIdentifier = @"CategoryDetailSegueIdentifier";

#pragma mark - Viewcontroller Life-cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[CategoryListingViewModel alloc] initWithAllCategories];
    [self configureTableView:self.categoriesTableView];
}

#pragma mark - View Config

- (void)configureTableView:(UITableView *)tableView {
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView setEstimatedRowHeight:55.0f];
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [tableView registerNib:[UINib nibWithNibName:@"CategoryListingTableViewCell" bundle:nil] forCellReuseIdentifier:[CategoryListingTableViewCell cellIdentifier]];
}

#pragma mark - TableView Datasource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.contentArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoryCellViewModel *cellViewModel = [self.viewModel cellViewModelAtIndex:indexPath.row];

    return [self cellWithViewModel:cellViewModel];
}

- (UITableViewCell *)cellWithViewModel:(CategoryCellViewModel *)cellViewModel {
    CategoryListingTableViewCell *categoryCell = [self.categoriesTableView dequeueReusableCellWithIdentifier:[CategoryListingTableViewCell cellIdentifier]];
    [categoryCell configureWithViewModel:cellViewModel];
    
    return categoryCell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Category *selectedCategory = [self.viewModel.contentArray objectAtIndex:indexPath.row];
    ItemListViewController *detailViewController = (ItemListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:[ItemListViewController itemListVCIdentifier]];
//    ItemListingViewModel *itemsViewModel = [[ItemListingViewModel alloc] initWithItems:[selectedCategory.items allObjects] andTitle:selectedCategory.categoryName];
    ItemListingType lsitingType = [self typeForCategory:selectedCategory];
    ItemListingViewModel *itemsViewModel = [[ItemListingViewModel alloc] initWithListingType:lsitingType];
    [detailViewController configureWithViewModel:itemsViewModel];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (ItemListingType)typeForCategory:(Category *)category {
    
    if ([category.categoryName isEqualToString:@"Furniture"]) {
        return ItemListingTypeFurniture;
    }
    else if ([category.categoryName isEqualToString:@"Electronics"]) {
        return ItemListingTypeElectronics;
    }
    else {
        return ItemListingTypeAll;
    }
}

@end
