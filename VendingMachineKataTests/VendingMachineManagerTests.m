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
    XCTAssertTrue([vendingMachineManager pennyAmountOfCoinsInput] == 5);

    [vendingMachineManager insertCoin:Dime];
    XCTAssertTrue([vendingMachineManager pennyAmountOfCoinsInput] == 15);

    [vendingMachineManager insertCoin:Quarter];
    XCTAssertTrue([vendingMachineManager pennyAmountOfCoinsInput] == 40);
}

- (void)testInvalidCoin {
    VendingMachineManager *vendingMachineManager = [[VendingMachineManager alloc] init];
    [vendingMachineManager insertCoin:Penny];
    XCTAssertTrue([vendingMachineManager pennyAmountOfCoinsReturned] == 1);
    
    [vendingMachineManager insertCoin:Penny];
    XCTAssertTrue([vendingMachineManager pennyAmountOfCoinsReturned] == 2);

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

- (void)testTakeChange {
    VendingMachineManager *vendingMachineManager = [[VendingMachineManager alloc] init];
    NSUInteger total;
    
    [vendingMachineManager insertCoin:Penny];
    [vendingMachineManager insertCoin:Penny];
    [vendingMachineManager insertCoin:Penny];
    
    total = [vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 3);

    total = [vendingMachineManager takeChange];
    XCTAssertTrue(total == 3);

    total = [vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 0);

}

- (void)testCanBuyProduct {
    VendingMachineManager *vendingMachineManager = [[VendingMachineManager alloc] init];
    Product *product = [[Product alloc] initProductName:@"Chips" withPrice:50];

    XCTAssertFalse([vendingMachineManager canBuyProduct:product]);
    [vendingMachineManager insertCoin:Quarter];
    XCTAssertFalse([vendingMachineManager canBuyProduct:product]);
    [vendingMachineManager insertCoin:Quarter];
    XCTAssertTrue([vendingMachineManager canBuyProduct:product]);
    [vendingMachineManager insertCoin:Quarter];
    XCTAssertTrue([vendingMachineManager canBuyProduct:product]);

}
@end
