//
//  CartItemListingViewModel.h
//  Retail Store
//
//  Created by Aravind on 10/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cart+CoreDataClass.h"
#import "CartItemCellViewModel.h"

@interface CartItemListingViewModel : NSObject

- (instancetype)initWithCart:(Cart *)cart;

@property (readonly) NSMutableArray *contentArray;
@property (readonly) Cart *cart;

- (CartItemCellViewModel *)cellViewModelAtIndex:(NSInteger)index;
- (void)updateContentArray;
- (void)removedItemAtIndex:(NSInteger)index;

- (NSString *)totalPrice;
- (NSString *)totalItems;

@end
