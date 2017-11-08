//
//  ItemListingViewModel.m
//  Retail Store
//
//  Created by Aravind on 07/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "ItemListingViewModel.h"
#import "Category+CoreDataProperties.h"

@interface ItemListingViewModel()

@property Category *category;
@property  (readwrite) NSMutableArray *contentArray;
@property (nonatomic, readwrite) NSString *navTitle;
@property BOOL allItemsDisplayed;

@end

@implementation ItemListingViewModel

#pragma mark - Initialization

- (instancetype)initWithCategory:(Category *)category {
    self = [super init];
    if (self) {
        self.category = category;
        self.contentArray = [category.items.allObjects mutableCopy];
        self.allItemsDisplayed = NO;
    }
    
    return self;
}

- (instancetype)initWithAllItems:(NSArray<Item *> *)items {
    self = [super init];
    if (self) {
        self.contentArray = [items mutableCopy];
        self.allItemsDisplayed = YES;
    }
    
    return self;
}

#pragma mark - 

- (ItemCellViewModel *)cellViewModelAtIndex:(NSInteger)index {
    Item *item = [self.contentArray objectAtIndex:index];
    ItemCellViewModel *cellViewModel = [[ItemCellViewModel alloc] init];
    [cellViewModel configureWithItem:item];
    return cellViewModel;
}

- (NSString *)navTitle {
    NSString *navTitle = @"ALL PRODUCTS";
    if (self.allItemsDisplayed == NO) {
        navTitle = self.category.categoryName.capitalizedString;
    }
    
    return navTitle;
}

@end
