//
//  ItemDetailViewController.h
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCellViewModel.h"

@interface ItemDetailViewController : UIViewController

+ (NSString *)itemDetailVCStoryBoardIdentifier;

- (void)configureWithViewModel:(ItemCellViewModel *)cellViewModel;

@end
