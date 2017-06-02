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

    XCTAssertTrue([insertCoinLabel.label isEqualToString:@"INSERT COIN"]);
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.00"]);
    
    XCUIElement *addMoneyButton = app.buttons[@"Add Money"];
    [addMoneyButton tap];
    
    XCUIElement *insertCoinsSheet = app.sheets[@"Insert Coins"];
    [insertCoinsSheet.buttons[@"Penny"] tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:@"INSERT COIN"]);
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.01"]);

    [addMoneyButton tap];
    [insertCoinsSheet.buttons[@"Nickel"] tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:@"$0.05"]);
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.01"]);

    [addMoneyButton tap];
    [insertCoinsSheet.buttons[@"Dime"] tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:@"$0.15"]);
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.01"]);

    [addMoneyButton tap];
    [insertCoinsSheet.buttons[@"Quarter"] tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:@"$0.40"]);
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.01"]);
}

-(void)testTakeChange {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *addMoneyButton = app.buttons[@"Add Money"];
    [addMoneyButton tap];
    
    XCUIElement *pennyButton = app.sheets[@"Insert Coins"].buttons[@"Penny"];
    [pennyButton tap];
    [addMoneyButton tap];
    [pennyButton tap];
    [addMoneyButton tap];
    [pennyButton tap];
    
    XCUIElement *changeLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"Change"];
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.03"]);
    
    [app.buttons[@"Take Change"] tap];
    XCTAssertTrue([changeLabel.label isEqualToString:@"$0.00"]);
}

-(void)testBuyChips {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *buyChipsButton = app.buttons[@"Buy Chips"];
    XCUIElement *insertCoinLabel = [app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"InsertCoins"];
    NSString *priceString = [NSString stringWithFormat:@"%@ $0.50",PRICE];
    
    XCTAssertTrue([insertCoinLabel.label isEqualToString:INSERT_COIN]);
    [buyChipsButton tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:priceString]);
    
    // Wait for label to return to INSERT_COIN
    XCUIElement *label = app.staticTexts[INSERT_COIN];
    NSPredicate *exists = [NSPredicate predicateWithFormat:@"exists == 1"];
    [self expectationForPredicate:exists evaluatedWithObject:label handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:INSERT_COIN]);
    
    [app.buttons[@"Add Money"] tap];
    [app.sheets[@"Insert Coins"].buttons[@"Quarter"] tap];
    [buyChipsButton tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:priceString]);

    // Wait for label to return to amount inserted
    label = app.staticTexts[@"$0.25"];
    [self expectationForPredicate:exists evaluatedWithObject:label handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:@"$0.25"]);
    
    [app.buttons[@"Add Money"] tap];
    [app.sheets[@"Insert Coins"].buttons[@"Quarter"] tap];
    [buyChipsButton tap];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:THANK_YOU]);

    // Wait for label to return to INSERT_COIN
    label = app.staticTexts[INSERT_COIN];
    [self expectationForPredicate:exists evaluatedWithObject:label handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    XCTAssertTrue([insertCoinLabel.label isEqualToString:INSERT_COIN]);

}

@end
