//
//  Retail_StoreTests.m
//  Retail StoreTests
//
//  Created by Aravind on 07/11/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

#import <XCTest/XCTest.h>

#define kFailureMessage @"Test Case Failed"

@interface Retail_StoreTests : XCTestCase

@end

@implementation Retail_StoreTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchAllCategories {
    BOOL categoriesFetched = [[NetworkManager sharedInstance] fetchAllCategories];
    XCTAssert(categoriesFetched,kFailureMessage);
}

- (void)testFetchAllItems {
    __block NSInteger testItemCount = SampleInputItems.count;
    [[NetworkManager sharedInstance] fetchAllItemsWithCompletionBlock:^(NSArray *items) {
        BOOL itemCountEqual = (items.count == testItemCount);
        XCTAssert(itemCountEqual,kFailureMessage);
    }];
}


@end
