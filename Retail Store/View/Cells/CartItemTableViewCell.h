//
//  CartItemTableViewCell.h
//  Retail Store
//
//  Created by Aravind on 10/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartItemCellViewModel.h"

@class CartItemTableViewCell;
@protocol CartItemTableViewCellDelegate <NSObject>

- (void)cartItemCell:(CartItemTableViewCell *)itemCell deleteButtonTapped:(UIButton *)deleteButton;

@end

@interface CartItemTableViewCell : UITableViewCell

@property (weak) id<CartItemTableViewCellDelegate>delegate;

+ (NSString *)cellIdentifier;

- (void)configureWithViewModel:(CartItemCellViewModel *)cellViewModel;

@end
