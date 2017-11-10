//
//  CartItemListingViewModel.m
//  Retail Store
//
//  Created by Aravind on 10/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "CartItemListingViewModel.h"

@interface CartItemListingViewModel()

@property (readwrite) Cart *cart;

@property (readwrite) NSMutableArray *contentArray;

@end

@implementation CartItemListingViewModel

#pragma mark - Initialization

- (instancetype)initWithCart:(Cart *)cart {
    self = [super init];
    if (self) {
        self.cart = cart;
        self.contentArray = [[cart.cartItems allObjects] mutableCopy];
    }
    
    return self;
}

#pragma mark -

- (void)removedItemAtIndex:(NSInteger)index {
    CartItem *removedCartItem = [self.contentArray objectAtIndex:index];
    [[DatabaseManager sharedInstance] removeCartItem:removedCartItem fromCart:self.cart];
    [self.contentArray removeObject:removedCartItem];
}

- (CartItemCellViewModel *)cellViewModelAtIndex:(NSInteger)index {
    CartItem *cartItem = [self.contentArray objectAtIndex:index];
    CartItemCellViewModel *cellViewModel = [[CartItemCellViewModel alloc] init];
    [cellViewModel configureWithCartItem:cartItem];
    
    return cellViewModel;
}

- (void)updateContentArray {
    self.contentArray = [[self.cart.cartItems allObjects] mutableCopy];
}

#pragma mark -

- (NSString *)totalPrice {
    NSString *totalPrice = [NSString stringWithFormat:@"Total Price : ₹ %.2f", self.cart.totalPrice];
    
    return totalPrice;
}

- (NSString *)totalItems {
    NSString *totalPrice = [NSString stringWithFormat:@"Total Items : %d", self.cart.itemCount];
    
    return totalPrice;
}

@end
