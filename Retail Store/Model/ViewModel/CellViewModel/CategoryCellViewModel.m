//
//  CategoryCellViewModel.m
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "CategoryCellViewModel.h"

@interface CategoryCellViewModel()

@property (readwrite) Category *dispalyedCategory;
@property (readwrite, nonatomic) NSString *displayedCategoryTitle;

@end

@implementation CategoryCellViewModel

- (void)configureWithCategory:(Category *)category {
    self.displayedCategoryTitle = category.categoryName;
}

@end
