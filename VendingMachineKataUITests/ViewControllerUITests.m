//
//  ViewControllerUITests.m
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/2/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface ViewControllerUITests : XCTestCase

@end

@implementation ViewControllerUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testAddMoney {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *insertCoinLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"InsertCoins"];
    XCUIElement *changeLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"Change"];

    // Input label should read "INSERT COIN" to start
    XCTAssertTrue([insertCoinLabel.label isEqualToString:@"INSERT COIN"]);
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.00"]);
    
    XCUIElement *addMoneyButton = app.buttons[@"Add Money"];
    [addMoneyButton tap];
    
    XCUIElement *insertCoinsSheet = app.sheets[@"Insert Coins"];
    [insertCoinsSheet.buttons[@"Penny"] tap];
    
    // penny added, goes to change tray. Input label still shows "INSERT COIN"
    XCTAssertTrue([insertCoinLabel.label isEqualToString:@"INSERT COIN"]);
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.01"]);

    [addMoneyButton tap];
    [insertCoinsSheet.buttons[@"Nickel"] tap];
    
    // Input label incremented by 5 cents.
    XCTAssertTrue([insertCoinLabel.label isEqualToString:@"$0.05"]);
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.01"]);

    [addMoneyButton tap];
    [insertCoinsSheet.buttons[@"Dime"] tap];
    
    // Input label incremented by 10 cents.
    XCTAssertTrue([insertCoinLabel.label isEqualToString:@"$0.15"]);
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.01"]);

    [addMoneyButton tap];
    [insertCoinsSheet.buttons[@"Quarter"] tap];

    // Input label incremented by 25 cents.
    XCTAssertTrue([insertCoinLabel.label isEqualToString:@"$0.40"]);
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.01"]);
}

-(void)testTakeChange {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *addMoneyButton = app.buttons[@"Add Money"];
    [addMoneyButton tap];
    
    // add money to change tray
    XCUIElement *pennyButton = app.sheets[@"Insert Coins"].buttons[@"Penny"];
    [pennyButton tap];
    [addMoneyButton tap];
    [pennyButton tap];
    [addMoneyButton tap];
    [pennyButton tap];
    
    XCUIElement *changeLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"Change"];
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.03"]); // money in change tray
    
    [app.buttons[@"Take Change"] tap];
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.00"]); // no more money in change tray
}

-(void)testBuyChips {
    [self executePurchase:@"Buy Chips" productPrice:CHIP_PRICE];
}

-(void)testBuyCola {
    [self executePurchase:@"Buy Cola" productPrice:COLA_PRICE];
}

-(void)testBuyCandy {
    [self executePurchase:@"Buy Candy" productPrice:CANDY_PRICE];
}

-(void)executePurchase:(NSString *)buttonName productPrice:(NSUInteger)price {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *buyButton = app.buttons[buttonName];
    XCUIElement *insertCoinLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"InsertCoins"];
    XCUIElement *changeLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"Change"];

    // timer to wait for label changes to process
    NSPredicate *exists = [NSPredicate predicateWithFormat:@"exists == 1"];
    int timeOutWait = 2;

    NSString *priceString = [NSString stringWithFormat:@"%@ $%lu.%02lu",PRICE,price/100, price%100];
    NSUInteger amountInserted = 0;
    NSString * amountInsertedString = INSERT_COIN;

    XCTAssertTrue([insertCoinLabel.label isEqualToString:amountInsertedString]);    // no money yet

    while (amountInserted < price) {    // repeat this loop until enough money is added
        [buyButton tap];
        
        // not enough money, display product price
        XCTAssertTrue([insertCoinLabel.label isEqualToString:priceString]);
        
        // Wait for label to return to showing the current amount
        XCUIElement *label = app.staticTexts[amountInsertedString];
        [self expectationForPredicate:exists evaluatedWithObject:label handler:nil];
        [self waitForExpectationsWithTimeout:timeOutWait handler:nil];
        
        // now showing amount of coins input
        XCTAssertTrue([insertCoinLabel.label isEqualToString:amountInsertedString]);
        
        [app.buttons[@"Add Money"] tap];
        [app.sheets[@"Insert Coins"].buttons[@"Quarter"] tap];
        amountInserted += 25;
        amountInsertedString = [NSString stringWithFormat:@"$%lu.%02lu",amountInserted/100, amountInserted%100];
    }

    [buyButton tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:THANK_YOU]); // purchase successful

    // Wait for label to return to INSERT_COIN
    XCUIElement *label = app.staticTexts[INSERT_COIN];
    [self expectationForPredicate:exists evaluatedWithObject:label handler:nil];
    [self waitForExpectationsWithTimeout:timeOutWait handler:nil];
    
    // display restored to initial state
    XCTAssertTrue([insertCoinLabel.label isEqualToString:INSERT_COIN]);
    
    NSUInteger change = amountInserted - price;
    NSString *amountOfChange = [NSString stringWithFormat:@"$%lu.%02lu",change/100, change%100];
    
    // check for change
    XCTAssertTrue([changeLabel.label isEqualToString:amountOfChange]);
}

-(void)testCoinReturn {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *insertCoinLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"InsertCoins"];
    XCUIElement *changeLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"Change"];

    // insert coins
    XCUIElement *addMoneyButton = app.buttons[@"Add Money"];
    [addMoneyButton tap];
    
    XCUIElement *insertCoinsSheet = app.sheets[@"Insert Coins"];
    [insertCoinsSheet.buttons[@"Nickel"] tap];
    [addMoneyButton tap];
    [insertCoinsSheet.buttons[@"Dime"] tap];
    [app.buttons[@"Coin Return"] tap];

    // check that coins were returned
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.15"]);
    XCTAssertTrue([insertCoinLabel.label isEqualToString:INSERT_COIN]);
}

-(void)testBuySoldOut {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *insertCoinLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"InsertCoins"];
    NSPredicate *exists = [NSPredicate predicateWithFormat:@"exists == 1"];
    int timeOutWait = 2;
    
    [app.switches[@"Sold Out"] tap];    // set sold out state
    [app.buttons[@"Buy Chips"] tap];    // try to buy product
    
    // Cannot buy product because it is sold out
    XCTAssertTrue([insertCoinLabel.label isEqualToString:SOLD_OUT]);

    // wait for display to return to amoun input
    XCUIElement *label = app.staticTexts[INSERT_COIN];
    [self expectationForPredicate:exists evaluatedWithObject:label handler:nil];
    [self waitForExpectationsWithTimeout:timeOutWait handler:nil];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:INSERT_COIN]);
}

-(void)testExactChangeToggle {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *exactChangeSwitch = app.switches[@"Exact Change"];
    XCUIElement *insertCoinLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"InsertCoins"];
    
    XCTAssertTrue([insertCoinLabel.label isEqualToString:INSERT_COIN]); // Initial value
    [exactChangeSwitch tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:EXACT_CHANGE_ONLY]); // exact change on
    [exactChangeSwitch tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:INSERT_COIN]); // exact change off agaoin
}

-(void)testExactChangePurchaseAttempt {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *insertCoinLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"InsertCoins"];
    NSPredicate *exists = [NSPredicate predicateWithFormat:@"exists == 1"];
    int timeOutWait = 2;

    [app.switches[@"Exact Change"] tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:EXACT_CHANGE_ONLY]);
    
    // add more money than product price
    XCUIElement *addMoneyButton = app.buttons[@"Add Money"];
    XCUIElement *quarterButton = app.sheets[@"Insert Coins"].buttons[@"Quarter"];

    [addMoneyButton tap];
    [quarterButton tap];
    [addMoneyButton tap];
    [quarterButton tap];
    [addMoneyButton tap];
    [quarterButton tap];
    
    NSString *amountString = @"$0.75";
    XCTAssertTrue([insertCoinLabel.label isEqualToString:amountString]);
    
    [app.buttons[@"Buy Candy"] tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:EXACT_CHANGE_ONLY]); // Too much money

    // revert label
    XCUIElement *label = app.staticTexts[amountString];
    [self expectationForPredicate:exists evaluatedWithObject:label handler:nil];
    [self waitForExpectationsWithTimeout:timeOutWait handler:nil];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:amountString]);
}


@end
