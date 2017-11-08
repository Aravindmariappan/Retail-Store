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

@interface ItemListingViewModel : NSObject

- (instancetype)initWithAllItems:(NSArray<Item *> *)items;
- (instancetype)initWithCategory:(Category *)category;

@property (readonly) NSMutableArray *contentArray;
@property (readonly) NSString *navTitle;

- (ItemCellViewModel *)cellViewModelAtIndex:(NSInteger)index;

@end
