//
//  CategoryListingViewModel.h
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category+CoreDataClass.h"
#import "CategoryCellViewModel.h"

@interface CategoryListingViewModel : NSObject

- (instancetype)initWithCategories:(NSArray<Category *> *)categories;
- (instancetype)initWithAllCategories;

@property (readonly) NSMutableArray *contentArray;

- (CategoryCellViewModel *)cellViewModelAtIndex:(NSInteger)index;

@end
