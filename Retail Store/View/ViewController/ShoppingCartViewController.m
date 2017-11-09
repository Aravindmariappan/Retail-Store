//
//  ShoppingCartViewController.m
//  Retail Store
//
//  Created by Aravind on 09/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "ShoppingCartViewController.h"

@interface ShoppingCartViewController ()

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemAddedToCart:) name:kItemAddedToCartNotification object:nil];
}

- (void)itemAddedToCart:(NSNotification *)notification {
    CartItem *cartItem = (CartItem *)notification.object;
    [[self navigationController] tabBarItem].badgeValue = [NSString stringWithFormat:@"%hd",cartItem.quantity];
}

@end
