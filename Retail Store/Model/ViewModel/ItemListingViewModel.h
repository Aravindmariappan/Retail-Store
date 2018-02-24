//
//  ItemListingViewModel.h
//  Retail Store
//
//  Created by Aravind on 07/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemCellViewModel.h"

@class  Category,Item;

typedef enum : NSUInteger {
    ItemListingTypeFurniture = 0,
    ItemListingTypeElectronics = 1,
    ItemListingTypeAll,
} ItemListingType;

@interface ItemListingViewModel : NSObject

- (instancetype)initWithItems:(NSArray<Item *> *)items andTitle:(NSString *)title;
- (instancetype)initWithListingType:(ItemListingType)listingType;

@property (readonly) NSString *navTitle;
@property (readonly) ItemListingType selectedListingType;

- (ItemCellViewModel *)cellViewModelAtIndex:(NSInteger)index;
- (NSInteger)getItemsCount;

- (void)filterArrayBasedOnListingType:(ItemListingType)listingType;

@end
