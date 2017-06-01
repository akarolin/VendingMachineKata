//
//  VendingMachineManager.h
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoinManager.h"

@interface VendingMachineManager : NSObject

- (void)inputCoin:(CoinType) coin;
- (NSUInteger)numberOfCoinsInput;
- (NSUInteger)numberOfCoinsReturned;

@end
