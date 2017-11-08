//
//  CategoryListingTableViewCell.m
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "CategoryListingTableViewCell.h"
#import "CategoryCellViewModel.h"

@interface CategoryListingTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;

@end

@implementation CategoryListingTableViewCell

+ (NSString *)cellIdentifier {
    return @"tableViewCellIdentifier";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

- (void)configureWithViewModel:(CategoryCellViewModel *)cellViewModel {
    [self.categoryTitle setText:cellViewModel.displayedCategoryTitle];
}

@end
