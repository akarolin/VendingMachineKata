//
//  CoinManager.h
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoinManager.h"

@interface CoinManager : NSObject

typedef NS_ENUM(NSUInteger, CoinType) {
    Penny = 1,
    Nickel = 5,
    Dime = 10,
    Quarter = 25,
    HalfDollar = 50,
    Dollar = 100
};

- (BOOL)isValidCoin:(CoinType)coin;

@end
