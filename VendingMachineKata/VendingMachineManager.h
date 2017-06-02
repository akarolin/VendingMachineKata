//
//  VendingMachineManager.h
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoinManager.h"
#import "Product.h"

@interface VendingMachineManager : NSObject

- (void)insertCoin:(CoinType) coin;
- (NSUInteger)pennyAmountOfCoinsInput;
- (NSUInteger)pennyAmountOfCoinsReturned;
- (NSUInteger)takeChange;
- (BOOL)canBuyProduct:(Product *)product;
- (void)completeTransaction;

@end
