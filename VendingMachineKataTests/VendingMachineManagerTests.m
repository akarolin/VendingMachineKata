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
    // valid coins will increment pennyAmountOfCoinsInput by coin value (cummulative)
    [self.vendingMachineManager insertCoin:Nickel];
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsInput] == 5);

    [self.vendingMachineManager insertCoin:Dime];
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsInput] == 15);

    [self.vendingMachineManager insertCoin:Quarter];
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsInput] == 40);
}

- (void)testInvalidCoin {
    // invalid coins will increment pennyAmountOfCoinsReturned input by coin value (cummulative)
    // invalid coins will not increment pennyAmountOfCoinsInput
    [self.vendingMachineManager takeChange];

    [self.vendingMachineManager insertCoin:Penny];
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsReturned] == 1);
    
    [self.vendingMachineManager insertCoin:Penny];
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsReturned] == 2);

}

- (void)testCoinsInput {
    // test each ot th coins individually
    NSUInteger total = 0;
    
    [self.vendingMachineManager insertCoin:Nickel];
    total = [self.vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 5);
    
    [self.vendingMachineManager insertCoin:Dime];
    total = [self.vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 15); // cumulative
    
    [self.vendingMachineManager insertCoin:Quarter];
    total = [self.vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 40); // cumulative
    
    [self.vendingMachineManager insertCoin:Penny];
    total = [self.vendingMachineManager pennyAmountOfCoinsInput];
    XCTAssertTrue(total == 40); // does not increment
}

- (void)testCoinsRejected {
    NSUInteger total = 0;
    [self.vendingMachineManager takeChange];
    
    [self.vendingMachineManager insertCoin:Penny];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 1);
    
    [self.vendingMachineManager insertCoin:Penny];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2); // cumulative
    
    [self.vendingMachineManager insertCoin:Nickel];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2); // does not increment
    
    [self.vendingMachineManager insertCoin:Dime];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2); // does not increment
    
    [self.vendingMachineManager insertCoin:Quarter];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 2);
    
    [self.vendingMachineManager insertCoin:Penny];
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 3); // cumulative
}

- (void)testTakeChange {
    NSUInteger total;
    
    // add pennies so that there is something in the change tray
    [self.vendingMachineManager takeChange];
    [self.vendingMachineManager insertCoin:Penny];
    [self.vendingMachineManager insertCoin:Penny];
    [self.vendingMachineManager insertCoin:Penny];
    
    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 3);

    total = [self.vendingMachineManager takeChange];
    XCTAssertTrue(total == 3); // function returns original amount

    total = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    XCTAssertTrue(total == 0); // no coins left

}

- (void)testBuyProduct {
    Product *product = [[Product alloc] initProductName:@"Chips" withPrice:50];
    
    // buyproduct returns a boolean if product can be purchased
    XCTAssertFalse([self.vendingMachineManager buyProduct:product]);    // cannot purchase - no money
    [self.vendingMachineManager insertCoin:Quarter];
    XCTAssertFalse([self.vendingMachineManager buyProduct:product]);    // cannot purchase - not enough money
    [self.vendingMachineManager insertCoin:Quarter];
    XCTAssertTrue([self.vendingMachineManager buyProduct:product]);     // can buy - enough money
}

- (void)testCompleteTransactionWithChange {
    Product *product = [[Product alloc] initProductName:@"Chips" withPrice:60];
    
    [self.vendingMachineManager insertCoin:Quarter];
    [self.vendingMachineManager insertCoin:Quarter];
    [self.vendingMachineManager insertCoin:Quarter];
    [self.vendingMachineManager buyProduct:product];    // 75 entered for purchase price of 60
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsReturned] == 15);
}

- (void)testCoinReturn {
    
    // add coins to return
    [self.vendingMachineManager insertCoin:Quarter];
    [self.vendingMachineManager insertCoin:Quarter];
    [self.vendingMachineManager insertCoin:Quarter];
    
    XCTAssertTrue([self.vendingMachineManager coinReturn] == 75); // function returns orignal amoung
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsReturned] == 75); // correct money in change tray
    XCTAssertTrue([self.vendingMachineManager pennyAmountOfCoinsInput] == 0); // nothing left in the coin input
}



@end
