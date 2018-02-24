//
//  AppDelegate.m
//  Retail Store
//
//  Created by Aravind on 07/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NetworkManager sharedInstance] fetchAllCategories];
    [self customViewUpdate];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[DatabaseManager sharedInstance] saveContext];
}

#pragma mark - Initial Load

- (void)customViewUpdate {
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : kAppRedColor } forState:UIControlStateSelected];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cartUpdated:) name:kCartUpdatedNotification object:nil];
    [self configureShoppingCartBadgeWithCount:[DatabaseManager sharedInstance].defaultCart.itemCount];
}

#pragma mark - Badge Count Update

- (void)cartUpdated:(NSNotification *)notification {
    Cart *cart = (Cart *)notification.object;
    [self configureShoppingCartBadgeWithCount:cart.itemCount];
}

- (void)configureShoppingCartBadgeWithCount:(NSInteger)count {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBarItem *badgeTabBar;
    for (UITabBarItem *tabBarItem in tabBarController.tabBar.items) {
        if (tabBarItem.tag == kShoppingCartBadgeTabItemTag) {
            badgeTabBar = tabBarItem;
        }
    }

    [badgeTabBar setBadgeValue:[NSString stringWithFormat:@"%ld",(long)count]];
}
@end
