//
//  CartItemCellViewModel.h
//  Retail Store
//
//  Created by Aravind on 10/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemCellViewModel.h"
#import "CartItem+CoreDataClass.h"

@interface CartItemCellViewModel : ItemCellViewModel

@property (readonly) CartItem *dispalyedCartItem;

@property (readonly) NSString *displayedItemQuantity;

- (void)configureWithCartItem:(CartItem *)cartItem;

@end
