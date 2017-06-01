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
    [vendingMachineManager insertCoin:Nickel];
    XCTAssertTrue([vendingMachineManager numberOfCoinsInput] == 1);

    [vendingMachineManager insertCoin:Dime];
    XCTAssertTrue([vendingMachineManager numberOfCoinsInput] == 2);

    [vendingMachineManager insertCoin:Quarter];
    XCTAssertTrue([vendingMachineManager numberOfCoinsInput] == 3);
}

- (void)testInvalidCoin {
    VendingMachineManager *vendingMachineManager = [[VendingMachineManager alloc] init];
    [vendingMachineManager insertCoin:Penny];
    XCTAssertTrue([vendingMachineManager numberOfCoinsReturned] == 1);
    
    [vendingMachineManager insertCoin:Penny];
    XCTAssertTrue([vendingMachineManager numberOfCoinsReturned] == 2);

}

- (void)testCoinsInput {
    VendingMachineManager *vendingMachineManager = [[VendingMachineManager alloc] init];
    NSUInteger total = 0;
    
    [vendingMachineManager insertCoin:Nickel];
    total = [vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 5);
    
    [vendingMachineManager insertCoin:Dime];
    total = [vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 15);
    
    [vendingMachineManager insertCoin:Quarter];
    total = [vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 40);
    
    [vendingMachineManager insertCoin:Penny];
    total = [vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 40);
}

- (void)testCoinsReturned {
    VendingMachineManager *vendingMachineManager = [[VendingMachineManager alloc] init];
    NSUInteger total = 0;
    
    [vendingMachineManager insertCoin:Penny];
    total = [vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 1);
    
    [vendingMachineManager insertCoin:Penny];
    total = [vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2);
    
    [vendingMachineManager insertCoin:Nickel];
    total = [vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2);
    
    [vendingMachineManager insertCoin:Dime];
    total = [vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2);
    
    [vendingMachineManager insertCoin:Quarter];
    total = [vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2);
    
    [vendingMachineManager insertCoin:Penny];
    total = [vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 3);
}

@end
