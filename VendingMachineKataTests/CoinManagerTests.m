//
//  CoinManagerTests.m
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoinManager.h"

@interface CoinManagerTests : XCTestCase

@property (nonatomic, strong) CoinManager *coinManager;

@end

@implementation CoinManagerTests

- (void)setUp {
    [super setUp];

    self.coinManager = [[CoinManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIfPennyIsValid {
    XCTAssertFalse([self.coinManager isValidCoin:Penny]);
    
}

- (void)testIfNickelIsValid {
    XCTAssertTrue([self.coinManager isValidCoin:Nickel]);
    
}

- (void)testIfDimeIsValid {
    XCTAssertTrue([self.coinManager isValidCoin:Dime]);
    
}

- (void)testIfQuarterIsValid {
    XCTAssertTrue([self.coinManager isValidCoin:Quarter]);
}


/*
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
*/

@end
