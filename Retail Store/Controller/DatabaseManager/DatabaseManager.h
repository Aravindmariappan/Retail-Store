//
//  DatabaseManager.h
//  Retail Store
//
//  Created by Aravind on 07/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Category+CoreDataClass.h"
#import "Item+CoreDataClass.h"
#import "CartItem+CoreDataClass.h"
#import "Cart+CoreDataClass.h"

@interface DatabaseManager : NSObject

+(DatabaseManager *)sharedInstance;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong) NSManagedObjectContext *mainContext;

@property (readonly) Cart *defaultCart;

- (void)saveContext;

#pragma mark - Store API Data

- (NSArray *)storeCategoriesDictArray:(NSArray *)categoriesDictArray;
- (NSArray *)storeItemsDictArray:(NSArray *)itemsDictArray withCompletionBlock:(void(^)(NSArray *items))completion;

#pragma mark - Fetch From DB

- (NSArray *)getAllCatagories;

#pragma mark - CartItem

- (Cart *)insertItem:(Item *)item toCart:(Cart *)cart;
- (void)removeCartItem:(CartItem *)cartItem fromCart:(Cart *)cart;

@end
