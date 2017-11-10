//
//  NetworkManager.h
//  Retail Store
//
//  Created by Aravind on 08/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+(NetworkManager *)sharedInstance;

- (BOOL)fetchAllCategories;
- (void)fetchAllItemsWithCompletionBlock:(void(^)(NSArray *items))completion;

@end
