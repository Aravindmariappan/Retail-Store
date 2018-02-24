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

@property  (readwrite) NSArray *contentArray;
@property  (readwrite) NSMutableArray *originalArray;
@property (readwrite) NSMutableArray *categoriesList;
@property (nonatomic, readwrite) NSString *navTitle;
@property (readwrite) Category *selectedCategory;

@end

@implementation ItemListingViewModel

#pragma mark - Initialization

- (instancetype)initWithItems:(NSArray<Item *> *)items andTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.contentArray = [items mutableCopy];
        self.navTitle = title;
    }
    
    return self;
}

- (instancetype)initWithListingType:(ItemListingType)listingType {
    self = [super init];
    if (self) {
        self.contentArray = [self initialLoadContentArrayFor:listingType];
        self.navTitle = [self navigationTitleForListingType:listingType];
    }
    
    return self;
}

#pragma mark - Configuration Based on Listing Type

- (NSArray *)initialLoadContentArrayFor:(ItemListingType)listingType {
    self.originalArray = [[[NetworkManager sharedInstance] fetchAllItems] mutableCopy];
    self.categoriesList = [[[DatabaseManager sharedInstance] getAllCatagories] mutableCopy];
    NSArray *contentArray;
    if (listingType == ItemListingTypeAll) {
        contentArray = self.originalArray.copy;
    }
    else {
        self.selectedCategory = self.categoriesList[listingType];
        contentArray = [self.selectedCategory.items allObjects];
    }
    
    return contentArray;
}

- (void)filterArrayBasedOnListingType:(ItemListingType)listingType {
    self.contentArray = [self filterArray:self.originalArray BasedOn:listingType];
}

- (NSArray *)filterArray:(NSArray *)inputArray BasedOn:(ItemListingType)listingType {
    
    NSString *filterBy = @"";
    
    switch (listingType) {
        
        case ItemListingTypeFurniture:
            filterBy = @"Furniture";
            break;

        case ItemListingTypeElectronics:
            filterBy = @"Electronics";
            break;

        default:
            break;
    }

    NSMutableArray *retArr = [[NSMutableArray alloc] init];
    
    for (Item *item in inputArray) {
        if ([item.category.categoryName isEqualToString:filterBy]) {
            [retArr addObject:item];
        }
    }
    
    return [retArr copy];
}

- (NSString *)navigationTitleForListingType:(ItemListingType)listingType {
    return @"ALL PRODUCTS";
}

#pragma mark - 

- (NSInteger)getItemsCount {
    return [self.contentArray count];
}

- (ItemCellViewModel *)cellViewModelAtIndex:(NSInteger)index {
    Item *item = [self.contentArray objectAtIndex:index];
    ItemCellViewModel *cellViewModel = [[ItemCellViewModel alloc] init];
    [cellViewModel configureWithItem:item];
    
    return cellViewModel;
}

@end
