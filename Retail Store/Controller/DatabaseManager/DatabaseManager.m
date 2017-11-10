//
//  DatabaseManager.m
//  Retail Store
//
//  Created by Aravind on 07/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import "DatabaseManager.h"

@interface DatabaseManager()

@property (readwrite, nonatomic) Cart *defaultCart;

@end

@implementation DatabaseManager

static DatabaseManager *sharedInstance = nil;

#pragma mark - Initailization

+ (DatabaseManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Retail_Store"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

- (NSManagedObjectContext *)mainContext {
    return self.persistentContainer.viewContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

#pragma mark - Cart

- (Cart *)defaultCart {
    if (_defaultCart == nil) {
        NSNumber *cartID = [DefaultCart valueForKey:kCartID];
        _defaultCart = [self fetchCartWithCartID:cartID.intValue];
        if (_defaultCart == nil) {
            _defaultCart = [self insertDefaultCartFromDict:DefaultCart];
            [self saveContext];
        }
    }
    
    return _defaultCart;
}

- (Cart *)fetchCartWithCartID:(int)cartID {
    NSPredicate *idPredicate = [NSPredicate predicateWithFormat:@"cartID = %d",cartID];
    NSFetchRequest *fetchRequest = [Cart fetchRequest];
    [fetchRequest setPredicate:idPredicate];
    NSArray *cartPresent = [self.mainContext executeFetchRequest:fetchRequest error:nil];
    Cart *fetchedCart = [cartPresent firstObject];
    
    return fetchedCart;
}

- (Cart *)insertDefaultCartFromDict:(NSDictionary *)cartDict {
    Cart *defaultCart = [NSEntityDescription insertNewObjectForEntityForName:@"Cart" inManagedObjectContext:self.persistentContainer.viewContext];
    NSNumber *cartID = [cartDict valueForKey:kCartID];
    [defaultCart setCartID:cartID.intValue];
    
    return defaultCart;
}

- (Cart *)addCartItem:(CartItem *)cartItem toCart:(Cart *)cart {
    [cart addCartItemsObject:cartItem];
    cart.itemCount += 1;
    cart.totalPrice += cartItem.price;
    
    return cart;
}

- (Cart *)insertItem:(Item *)item toCart:(Cart *)cart {
    CartItem *cartItem = [self insertCartItemForItem:item];
    cart = [self addCartItem:cartItem toCart:cart];
    [self saveContext];

    return cart;
}

- (void)removeCartItem:(CartItem *)cartItem fromCart:(Cart *)cart{
    cart.itemCount -= cartItem.quantity;
    cart.totalPrice -= (cartItem.quantity * cartItem.price);
    [cart removeCartItemsObject:cartItem];
    [self.mainContext deleteObject:cartItem];
    [self saveContext];
}

#pragma mark - Category

- (NSArray *)storeCategoriesDictArray:(NSArray *)categoriesDictArray {
    NSMutableArray *categories = [NSMutableArray array];
    for (NSDictionary *categoryDict in categoriesDictArray) {
        NSNumber *categoryID = [categoryDict valueForKey:kCategoryID];
        Category *fetchedCategory = [self fetchCategoryWithID:categoryID.integerValue];
        if (fetchedCategory == nil) {
            fetchedCategory = [self insertNewCategory];
        }
        fetchedCategory = [self mapCategoryDict:categoryDict toCategory:fetchedCategory];
        [categories addObject:fetchedCategory];
    }
    [self saveContext];
    
    return categories;
}

/**
 Insert Category With Default Value

 @return Newly created Category
 */
- (Category *)insertNewCategory {
    Category *newCategory = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:self.persistentContainer.viewContext];
    return newCategory;
}

- (Category *)mapCategoryDict:(NSDictionary *)categoryDict toCategory:(Category *)category {
    [category setCategoryName:[categoryDict valueForKey:kCategoryName]];
    [category setCategoryDescription:[categoryDict valueForKey:kCategoryDecription]];
    NSNumber *categoryID = [categoryDict valueForKey:kCategoryID];
    [category setCategoryID:categoryID.doubleValue];

    return category;
}

- (Category *)fetchCategoryWithID:(NSInteger)categoryID {
    NSPredicate *idPredicate = [NSPredicate predicateWithFormat:@"categoryID = %d",categoryID];
    NSFetchRequest *fetchRequest = [Category fetchRequest];
    [fetchRequest setPredicate:idPredicate];
    NSArray *categoryPresent = [self.mainContext executeFetchRequest:fetchRequest error:nil];
    Category *fetchedCategory = [categoryPresent firstObject];
    
    return fetchedCategory;
}

- (NSArray *)getAllCatagories {
    NSFetchRequest *fetchRequest = [Category fetchRequest];
    NSArray *categories = [self.mainContext executeFetchRequest:fetchRequest error:nil];

    return categories;
}

#pragma mark - Items

- (NSArray *)storeItemsDictArray:(NSArray *)itemsDictArray withCompletionBlock:(void(^)(NSArray *items))completion{
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *itemsDict in itemsDictArray) {
        NSNumber *itemID = [itemsDict valueForKey:kItemID];
        NSPredicate *idPredicate = [NSPredicate predicateWithFormat:@"itemID = %@",itemID];
        NSFetchRequest *fetchRequest = [Item fetchRequest];
        [fetchRequest setPredicate:idPredicate];
        NSArray *itemPresent = [self.mainContext executeFetchRequest:fetchRequest error:nil];;
        Item *item = [itemPresent firstObject];
        if (item == nil) {
            item = [self insertNewItem];
        }
        item = [self mapItemDict:itemsDict toItem:item];
        //Link Item With Category
        NSNumber *categoryID = [itemsDict valueForKey:kCategoryID];
        Category *itemCategory = [self fetchCategoryWithID:categoryID.integerValue];
        [item setCategory:itemCategory];
        
        [items addObject:item];
    }
    if (completion != nil) {
        completion(items);
    }
    [self saveContext];

    return items;
}

/**
 Insert Item With Default Value
 
 @return Newly created Item
 */
- (Item *)insertNewItem {
    Item *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.persistentContainer.viewContext];
    return newItem;
}

- (Item *)mapItemDict:(NSDictionary *)itemDict toItem:(Item *)item {
    [item setItemName:[itemDict valueForKey:kItemName]];
    [item setItemDescription:[itemDict valueForKey:kItemDescription]];
    [item setItemImageName:[itemDict valueForKey:kItemImageName]];
    NSNumber *itemPrice = [itemDict valueForKey:kItemPrice];
    [item setItemPrice:itemPrice.intValue];
    NSNumber *itemID = [itemDict valueForKey:kItemID];
    [item setItemID:itemID.doubleValue];

    return item;
}

#pragma mark - CartItem

- (CartItem *)insertCartItemForItem:(Item *)item {
    CartItem *cartItem = [self getCartItemForItem:item];
    if (cartItem == nil) {
        cartItem = [self insertNewCartItemForItem:item];
    }
    else {
        cartItem.quantity += 1;
    }
    
    return cartItem;
}

- (CartItem *)getCartItemForItem:(Item *)item {
    NSFetchRequest *fetchRequest = [CartItem fetchRequest];
    NSPredicate *itemIDPredicate = [NSPredicate predicateWithFormat:@"addedItem.itemID = %f", item.itemID];
    [fetchRequest setPredicate:itemIDPredicate];
    NSArray *cartItems = [self.mainContext executeFetchRequest:fetchRequest error:nil];
    
    return [cartItems firstObject];
}

- (CartItem *)insertNewCartItemForItem:(Item *)item {
    CartItem *newCartItem = [NSEntityDescription insertNewObjectForEntityForName:@"CartItem" inManagedObjectContext:self.persistentContainer.viewContext];
    newCartItem.addedItem = item;
    newCartItem.price = item.itemPrice;
    newCartItem.quantity += 1;

    return newCartItem;
}
@end
