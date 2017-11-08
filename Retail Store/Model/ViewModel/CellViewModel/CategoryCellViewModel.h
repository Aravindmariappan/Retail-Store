//
//  CategoryCellViewModel.h
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category+CoreDataClass.h"

@interface CategoryCellViewModel : NSObject

@property (readonly) NSString *displayedCategoryTitle;

- (void)configureWithCategory:(Category *)category;

@end
