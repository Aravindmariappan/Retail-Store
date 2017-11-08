//
//  AppDelegate.m
//  Retail Store
//
//  Created by Aravind on 07/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "AppDelegate.h"

#define kCategoryDecription @"categoryDescription"
#define kCategoryID @"categoryID"
#define kCategoryName @"categoryName"

#define kItemName @"itemName"
#define kItemDescription @"itemDescription"
#define kItemID @"itemID"
#define kItemImageName @"itemImageName"
#define kItemPrice @"itemPrice"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NetworkManager sharedInstance] fetchAllCategories];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[DatabaseManager sharedInstance] saveContext];
}

#pragma mark - Initial Load


@end
