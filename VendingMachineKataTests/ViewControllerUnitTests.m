//
//  ViewControllerUnitTests.m
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ViewControllerUnitTests : XCTestCase

@property (strong, nonatomic) UIViewController *viewController;

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

- (void)testExample {
    // used to test setup
    XCTAssertTrue(YES);
}


@end
