//
//  NetworkManager.m
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

static NetworkManager *sharedInstance = nil;

#pragma mark - Initailization

+ (NetworkManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Fetch Data


/**
 Fetch All Category Details and Store in DB
 */
- (void)fetchAllCategories {
    NSArray *allCategories = SampleInputCategories; //Fetch Network Data in Real time Scenario
    [[DatabaseManager sharedInstance] storeCategoriesDictArray:allCategories];
}

- (void)fetchAllItemsWithCompletionBlock:(void(^)(NSArray *items))completion {
    NSArray *allItems = SampleInputItems;
    [[DatabaseManager sharedInstance] storeItemsDictArray:allItems withCompletionBlock:^(NSArray *items) {
        if(completion) {
            completion(items);
        }
    }];
}

@end
