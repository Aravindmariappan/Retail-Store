//
//  CategoryListingTableViewCell.h
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryCellViewModel.h"

@interface CategoryListingTableViewCell : UITableViewCell

+ (NSString *)cellIdentifier;

- (void)configureWithViewModel:(CategoryCellViewModel *)cellViewModel;

@end
