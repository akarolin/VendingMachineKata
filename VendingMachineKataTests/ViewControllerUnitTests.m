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

- (void)testAmountInputLabel {
    XCTAssertTrue([self.viewController.AmountInputLabel.text isEqualToString:@"INSERT COIN"]);
    [self.viewController insertCoin:Nickel];
    XCTAssertTrue([self.viewController.AmountInputLabel.text isEqualToString:@"$0.05"]);
    [self.viewController insertCoin:Quarter];
    XCTAssertTrue([self.viewController.AmountInputLabel.text isEqualToString:@"$0.30"]);
    [self.viewController insertCoin:Quarter];
    [self.viewController insertCoin:Quarter];
    [self.viewController insertCoin:Quarter];
    XCTAssertTrue([self.viewController.AmountInputLabel.text isEqualToString:@"$1.05"]);
}

- (void)testAmountOfChangeLabel {
    XCTAssertTrue([self.viewController.AmountOfChangeLabel.text isEqualToString:@"$0.00"]);
    [self.viewController insertCoin:Nickel];
    XCTAssertTrue([self.viewController.AmountOfChangeLabel.text isEqualToString:@"$0.00"]);
    [self.viewController insertCoin:Penny];
    [self.viewController insertCoin:Penny];
    [self.viewController insertCoin:Penny];
    XCTAssertTrue([self.viewController.AmountOfChangeLabel.text isEqualToString:@"$0.03"]);
}
@end