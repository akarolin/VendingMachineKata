//
//  CoinManager.m
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import "CoinManager.h"

@implementation CoinManager

- (BOOL)isValidCoin:(CoinType)coin {
    return (coin == Nickel || coin == Dime || coin == Quarter);
}

@end
