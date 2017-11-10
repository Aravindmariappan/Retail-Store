//
//  ShoppingCartViewController.m
//  Retail Store
//
//  Created by Aravind on 09/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "CartItemTableViewCell.h"
#import "ItemDetailViewController.h"

@interface ShoppingCartViewController ()<UITableViewDataSource, UITableViewDelegate, CartItemTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *cartTableView;
@property (strong, nonatomic) CartItemListingViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UIView *emptyStateView;
@property (weak, nonatomic) IBOutlet UILabel *totalQuantity;

@end

@implementation ShoppingCartViewController

- (void)configureWithViewModel:(CartItemListingViewModel *)cartItemListingViewModel {
    self.viewModel = cartItemListingViewModel;
}

#pragma mark - View Controller LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    CartItemListingViewModel *cartViewModel = [[CartItemListingViewModel alloc] initWithCart:[DatabaseManager sharedInstance].defaultCart];
    [self configureWithViewModel:cartViewModel];
    [self configureTableView:self.cartTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cartUpdated:) name:kCartUpdatedNotification object:nil];
    [self configureTotalItemsView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.cartTableView reloadData];
}

#pragma mark - Config View

- (void)configureTableView:(UITableView *)tableView {
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [tableView registerNib:[UINib nibWithNibName:@"CartItemTableViewCell" bundle:nil] forCellReuseIdentifier:[CartItemTableViewCell cellIdentifier]];
}

- (void)configureTotalItemsView {
    [self.totalPrice setText:[self.viewModel totalPrice]];
    [self.totalQuantity setText:[self.viewModel totalItems]];
}

- (void)configureEmptyStateWithCount:(NSInteger)count {
    if (count == 0) {
        [self.emptyStateView setHidden:NO];
    }
    else {
        [self.emptyStateView setHidden:YES];
    }
}

#pragma mark - Tableview Datasource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self configureEmptyStateWithCount:self.viewModel.contentArray.count];
    return [self.viewModel.contentArray count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CartItemCellViewModel *cellViewModel = [self.viewModel cellViewModelAtIndex:indexPath.row];
    CartItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CartItemTableViewCell cellIdentifier]];
    [cell setDelegate:self];
    [cell configureWithViewModel:cellViewModel];
    
    return cell;
}

#pragma mark - Tableview Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemCellViewModel *cellViewModel = [self.viewModel cellViewModelAtIndex:indexPath.row];
    
    ItemDetailViewController *itemDetailVC = (ItemDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:[ItemDetailViewController itemDetailVCStoryBoardIdentifier]];
    [itemDetailVC configureWithViewModel:cellViewModel];
    [self.navigationController pushViewController:itemDetailVC animated:YES];
}

#pragma mark - CartItemTableViewCellDelegate

- (void)cartItemCell:(CartItemTableViewCell *)itemCell deleteButtonTapped:(UIButton *)deleteButton {
    NSIndexPath *deletedIndexPath = [self.cartTableView indexPathForCell:itemCell];
    [self.viewModel removedItemAtIndex:deletedIndexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCartUpdatedNotification object:self.viewModel.cart];
    [self.cartTableView deleteRowsAtIndexPaths:@[deletedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark -

- (void)cartUpdated:(NSNotification *)notification {
    Cart *cart = (Cart *)notification.object;
    [[self navigationController] tabBarItem].badgeValue = [NSString stringWithFormat:@"%d",cart.itemCount];
    [self.viewModel updateContentArray];
    [self configureTotalItemsView];
}

#pragma mark -

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
