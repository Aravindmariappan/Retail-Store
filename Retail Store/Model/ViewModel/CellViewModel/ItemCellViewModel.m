//
//  ItemCellViewModel.m
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "ItemCellViewModel.h"

@interface ItemCellViewModel()

@property (readwrite) Item *dispalyedItem;
@property (readwrite, nonatomic) NSString *displayedItemTitle;
@property (readwrite, nonatomic) NSString *displayedItemPrice;
@property (readwrite, nonatomic) NSString *displayedItemImageName;

@end

@implementation ItemCellViewModel

#pragma mark - Setter

- (void)setDisplayedItemPrice:(NSString *)displayedItemPrice {
    _displayedItemPrice = displayedItemPrice;
    if (_displayedItemPrice.length == 0) {
        _displayedItemPrice = @"Not Available";
    }
}

#pragma mark - Configure

- (void)configureWithItem:(Item *)item {
    self.dispalyedItem = item;
    self.displayedItemTitle = item.itemName;
    NSString *itemPrice = [NSString stringWithFormat:@"₹ %.2f",item.itemPrice];
    self.displayedItemPrice = itemPrice;
    self.displayedItemImageName = item.itemImageName;
}

@end
