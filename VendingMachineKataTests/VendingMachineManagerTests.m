//
//  VendingMachineManagerTests.m
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VendingMachineManager.h"

@interface VendingMachineManagerTests : XCTestCase

@end

@implementation VendingMachineManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidCoin {
    VendingMachineManager *vendingMachineManager = [[VendingMachineManager alloc] init];
    [vendingMachineManager inputCoin:Nickel];
    XCTAssertTrue([vendingMachineManager numberOfCoinsInput] > 0);
}

- (void)testInalidCoin {
    VendingMachineManager *vendingMachineManager = [[VendingMachineManager alloc] init];
    [vendingMachineManager inputCoin:Penny];
    XCTAssertTrue([vendingMachineManager numberOfCoinsReturned] > 0);
}

@end
