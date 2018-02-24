//
//  CartItemCellViewModel.m
//  Retail Store
//
//  Created by Aravind on 10/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "CartItemCellViewModel.h"

@interface CartItemCellViewModel()

@property (readwrite) NSString *displayedItemPrice;
@property (readwrite, nonatomic) NSString *displayedItemQuantity;

@end

@implementation CartItemCellViewModel

@synthesize displayedItemPrice = _displayedItemPrice;

- (void)configureWithCartItem:(CartItem *)cartItem {
    [super configureWithItem:cartItem.addedItem];
    self.displayedItemQuantity = [NSString stringWithFormat:@"Quantity : %d",cartItem.quantity];
}

@end
