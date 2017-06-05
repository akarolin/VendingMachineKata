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

- (void)testAmoutAdder {
    NSUInteger total = 0;
    total = [self.coinManager addCoinToAmount:total coin:Penny];
    XCTAssertTrue(total == 1);
    
    total = [self.coinManager addCoinToAmount:total coin:Nickel];
    XCTAssertTrue(total == 6);
    
    total = [self.coinManager addCoinToAmount:total coin:Dime];
    XCTAssertTrue(total == 16);
    
    total = [self.coinManager addCoinToAmount:total coin:Quarter];
    XCTAssertTrue(total == 41);
    
}

@end
