//
//  CategoryListingViewModel.m
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "CategoryListingViewModel.h"

@interface CategoryListingViewModel()

@property  (readwrite) NSMutableArray *contentArray;

@end

@implementation CategoryListingViewModel

#pragma mark - Initialization

- (instancetype)initWithCategories:(NSArray<Category *> *)categories {
    self = [super init];
    if (self) {
        self.contentArray = [categories mutableCopy];
    }
    
    return self;
}

- (instancetype)initWithAllCategories {
    NSArray *allCatagories = [[DatabaseManager sharedInstance] getAllCatagories];
    self = [self initWithCategories:allCatagories];
    
    return self;
}

#pragma mark -

- (CategoryCellViewModel *)cellViewModelAtIndex:(NSInteger)index {
    Category *category = [self.contentArray objectAtIndex:index];
    CategoryCellViewModel *cellViewModel = [[CategoryCellViewModel alloc] init];
    [cellViewModel configureWithCategory:category];
    
    return cellViewModel;
}

@end
