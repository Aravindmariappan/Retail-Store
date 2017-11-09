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

@interface DatabaseManager : NSObject

+(DatabaseManager *)sharedInstance;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong) NSManagedObjectContext *mainContext;

- (void)saveContext;

#pragma mark - Store API Data

- (NSArray *)storeCategoriesDictArray:(NSArray *)categoriesDictArray;
- (NSArray *)storeItemsDictArray:(NSArray *)itemsDictArray withCompletionBlock:(void(^)(NSArray *items))completion;

#pragma mark - Fetch From DB

- (NSArray *)getAllCatagories;

#pragma mark - CartItem

- (CartItem *)insertCartItemForItem:(Item *)item ;

@end
