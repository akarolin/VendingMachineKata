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

@property NSUInteger totalAmountInput;
@property NSUInteger totalInCoinReturn;
@property NSUInteger currentProductPrice;

// exposed for unit testing
- (void)takeChange;
- (void)insertCoin:(CoinType) coin;
- (void)buyProduct:(Product *)product;
- (void)setSoldOut:(BOOL)isSoldOut;
- (void)setExactChange:(BOOL)useExactChange;
- (void)returnCoins;

@end

// UI Testing Helpers
NSString * const THANK_YOU = @"THANK YOU";
NSString * const INSERT_COIN = @"INSERT COIN";
NSString * const PRICE = @"PRICE:";
NSString * const SOLD_OUT = @"SOLD OUT";
NSString * const EXACT_CHANGE_ONLY = @"EXACT CHANGE ONLY";

NSUInteger const CHIP_PRICE = 50;
NSUInteger const COLA_PRICE = 100;
NSUInteger const CANDY_PRICE = 65;

