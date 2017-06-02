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

@property (strong, nonatomic) VendingMachineManager *vendingMachineManager;;

@end

@implementation VendingMachineManagerTests

- (void)setUp {
    [super setUp];
    self.vendingMachineManager = [[VendingMachineManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidCoin {
    [self.vendingMachineManager insertCoin:Nickel];
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsInput] == 5);

    [self.vendingMachineManager insertCoin:Dime];
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsInput] == 15);

    [self.vendingMachineManager insertCoin:Quarter];
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsInput] == 40);
}

- (void)testInvalidCoin {
    [self.vendingMachineManager insertCoin:Penny];
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsReturned] == 1);
    
    [self.vendingMachineManager insertCoin:Penny];
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsReturned] == 2);

}

- (void)testCoinsInput {
    NSUInteger total = 0;
    
    [self.vendingMachineManager insertCoin:Nickel];
    total = [self.vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 5);
    
    [self.vendingMachineManager insertCoin:Dime];
    total = [self.vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 15);
    
    [self.vendingMachineManager insertCoin:Quarter];
    total = [self.vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 40);
    
    [self.vendingMachineManager insertCoin:Penny];
    total = [self.vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 40);
}

- (void)testCoinsReturned {
    NSUInteger total = 0;
    
    [self.vendingMachineManager insertCoin:Penny];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 1);
    
    [self.vendingMachineManager insertCoin:Penny];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2);
    
    [self.vendingMachineManager insertCoin:Nickel];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2);
    
    [self.vendingMachineManager insertCoin:Dime];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2);
    
    [self.vendingMachineManager insertCoin:Quarter];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2);
    
    [self.vendingMachineManager insertCoin:Penny];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 3);
}

- (void)testTakeChange {
    NSUInteger total;
    
    [self.vendingMachineManager insertCoin:Penny];
    [self.vendingMachineManager insertCoin:Penny];
    [self.vendingMachineManager insertCoin:Penny];
    
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 3);

    total = [self.vendingMachineManager takeChange];
    XCTAssertTrue(total == 3);

    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 0);

}

- (void)testCanBuyProduct {
    Product *product = [[Product alloc] initProductName:@"Chips" withPrice:50];

    XCTAssertFalse([self.vendingMachineManager canBuyProduct:product]);
    [self.vendingMachineManager insertCoin:Quarter];
    XCTAssertFalse([self.vendingMachineManager canBuyProduct:product]);
    [self.vendingMachineManager insertCoin:Quarter];
    XCTAssertTrue([self.vendingMachineManager canBuyProduct:product]);
    [self.vendingMachineManager insertCoin:Quarter];
    XCTAssertTrue([self.vendingMachineManager canBuyProduct:product]);

}

@end
