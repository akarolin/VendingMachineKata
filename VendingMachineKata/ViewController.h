//
//  ViewController.h
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VendingMachineManager.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *AmountInputLabel;
@property (weak, nonatomic) IBOutlet UILabel *AmountOfChangeLabel;

@property NSTimeInterval secondsOfDelay;

- (IBAction)takeChange:(id)sender;
- (IBAction)buyChips:(id)sender;
- (IBAction)buyCola:(id)sender;
- (IBAction)buyCandy:(id)sender;

- (void)insertCoin:(CoinType) coin;
- (void)buyProduct:(Product *)product;

@end

// UI Testing Helpers
NSString * const THANK_YOU = @"THANK YOU";
NSString * const INSERT_COIN = @"INSERT COIN";
NSString * const PRICE = @"PRICE:";
NSUInteger const CHIP_PRICE = 50;
NSUInteger const COLA_PRICE = 100;
NSUInteger const CANDY_PRICE = 65;

