//
//  RSItemListViewController.h
//  Retail Store
//
//  Created by Aravind on 07/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemListingViewModel;
@interface ItemListViewController : UIViewController

+ (NSString *)itemListVCIdentifier;

@property (nonatomic, readonly) ItemListingViewModel *itemListingViewModel;

- (void)configureWithViewModel:(ItemListingViewModel *)itemListingViewModel;

@end
