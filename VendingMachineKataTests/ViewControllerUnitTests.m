//
//  ViewControllerUnitTests.m
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface ViewControllerUnitTests : XCTestCase

@property (strong, nonatomic) ViewController *viewController;

@end

@implementation ViewControllerUnitTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [UIApplication sharedApplication].keyWindow.rootViewController = self.viewController;

    //let _ = viewController.view
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAmountInput {
    
    XCTAssertTrue(self.viewController.totalAmountInput == 0);
    [self.viewController insertCoin:Penny];
    XCTAssertTrue(self.viewController.totalAmountInput == 0);
    [self.viewController insertCoin:Nickel];
    XCTAssertTrue(self.viewController.totalAmountInput == 5);
    [self.viewController insertCoin:Quarter];
    XCTAssertTrue(self.viewController.totalAmountInput == 30);
    [self.viewController insertCoin:Quarter];
    [self.viewController insertCoin:Quarter];
    [self.viewController insertCoin:Quarter];
    XCTAssertTrue(self.viewController.totalAmountInput == 105);
}

- (void)testAmountOfChange {
    
    XCTAssertTrue(self.viewController.totalInCoinReturn == 0);
    [self.viewController insertCoin:Nickel];
    XCTAssertTrue(self.viewController.totalInCoinReturn == 0);
    [self.viewController insertCoin:Penny];
    [self.viewController insertCoin:Penny];
    [self.viewController insertCoin:Penny];
    XCTAssertTrue(self.viewController.totalInCoinReturn == 3);
}

- (void)testTakeChange {
    
    [self.viewController insertCoin:Penny];
    [self.viewController insertCoin:Penny];
    [self.viewController insertCoin:Penny];
    
    XCTAssertTrue(self.viewController.totalInCoinReturn == 3);
    
    [self.viewController takeChange];
    XCTAssertTrue(self.viewController.totalInCoinReturn == 0);
}

- (void)testBuyProduct {
    Product *product = [[Product alloc] initProductName:@"Chips" withPrice:50];
    
    [self.viewController buyProduct:product];

    XCTAssertTrue(self.viewController.currentProductPrice == 50); // check if product price is updated

    [self.viewController insertCoin:Quarter];
    [self.viewController buyProduct:product];
    XCTAssertTrue(self.viewController.totalAmountInput == 25);  // not enough money yet
    
    [self.viewController insertCoin:Quarter];
    [self.viewController buyProduct:product];
    XCTAssertTrue(self.viewController.totalAmountInput == 0);   // product purchase with exact change
}

- (void)testMakeChange {
    Product *product = [[Product alloc] initProductName:@"Chips" withPrice:60];
    [self.viewController insertCoin:Quarter];
    [self.viewController insertCoin:Quarter];
    [self.viewController insertCoin:Quarter];
    [self.viewController buyProduct:product];
    XCTAssertTrue(self.viewController.totalInCoinReturn == 15);
}

- (void)testCoinReturn {
    [self.viewController insertCoin:Quarter];
    [self.viewController insertCoin:Quarter];
    [self.viewController insertCoin:Quarter];
    [self.viewController takeChange];
    [self.viewController returnCoins];
    XCTAssertTrue(self.viewController.totalInCoinReturn == 75);
    XCTAssertTrue(self.viewController.totalAmountInput == 0);
}

- (void)testSoldOut {
    Product *product = [[Product alloc] initProductName:@"Chips" withPrice:25];
    [self.viewController setSoldOut:YES];
    [self.viewController insertCoin:Quarter];
    [self.viewController buyProduct:product];
    
    // total amount input should remain even when there is enough money to purchase
    XCTAssertTrue(self.viewController.totalAmountInput == 25);
}

- (void)testSoldOutToggle {
    Product *product = [[Product alloc] initProductName:@"Chips" withPrice:25];

    // make sure toggle resets properly
    [self.viewController setSoldOut:YES];
    [self.viewController setSoldOut:NO];
    [self.viewController insertCoin:Quarter];
    [self.viewController buyProduct:product];
    
    // able to buy because toggle set back to not sold out
    XCTAssertTrue(self.viewController.totalAmountInput == 0); // able to buy
}

- (void)testExactChangeToggle {
    Product *product = [[Product alloc] initProductName:@"Chips" withPrice:40];

    // make sure toggle resets properly
    [self.viewController setExactChange:YES];
    [self.viewController setExactChange:NO];
    [self.viewController insertCoin:Quarter];
    [self.viewController insertCoin:Quarter];
    [self.viewController buyProduct:product];
    
    // able to buy because toggle reset to exact change not required
    XCTAssertTrue(self.viewController.totalAmountInput == 0);
}

- (void)testExactChangeUsed {
    Product *product = [[Product alloc] initProductName:@"Chips" withPrice:40];
    
    [self.viewController setExactChange:YES];
    [self.viewController insertCoin:Quarter];
    [self.viewController insertCoin:Quarter];
    [self.viewController buyProduct:product];
    
    // not exact change. money stays in input
    XCTAssertTrue(self.viewController.totalAmountInput == 50);
}

@end
