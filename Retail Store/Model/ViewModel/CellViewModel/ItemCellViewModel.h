//
//  ItemCellViewModel.h
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item+CoreDataProperties.h"

@interface ItemCellViewModel : NSObject

@property (readonly) NSString *displayedItemTitle;
@property (readonly) NSString *displayedItemPrice;
@property (readonly) NSString *displayedItemImageName;

- (void)configureWithItem:(Item *)item;

@end
