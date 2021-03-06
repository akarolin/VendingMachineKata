//
//  VendingMachineManager.m
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import "VendingMachineManager.h"
#import "Product.h"

@interface VendingMachineManager()

@property (strong, nonatomic) CoinManager *coinManager;

@property NSUInteger totalAmountInput;
@property NSUInteger totalAmountOfChange;

@end

@implementation VendingMachineManager

- (id)init {
    if (self = [super init]) {
        _coinManager = [[CoinManager alloc] init];
        _totalAmountInput = 0;
        _totalAmountOfChange = 0;
    }
    return self;
}

- (void)insertCoin:(CoinType) coin {
    if ([self.coinManager isValidCoin:(coin)]) {
        self.totalAmountInput = [self.coinManager addCoinToAmount:self.totalAmountInput coin:coin];
    } else {
        self.totalAmountOfChange = [self.coinManager addCoinToAmount:self.totalAmountOfChange coin:coin];
    }
}

- (NSUInteger)pennyAmountOfCoinsInput {
    return self.totalAmountInput;
}

- (NSUInteger)pennyAmountOfCoinsReturned {
    return self.totalAmountOfChange;
}

- (NSUInteger)takeChange {
    NSUInteger change = self.totalAmountOfChange;
    self.totalAmountOfChange = 0;
    return change;
}


- (BOOL)canBuyProduct:(Product *)product {
    self.productCostExceeded = self.totalAmountInput > product.price;
    if (self.useExactChange)
        return self.totalAmountInput == product.price;
    else
        return self.totalAmountInput >= product.price;
}

- (void)completeTransaction:(Product *)product {
    if (self.productCostExceeded) {
        self.totalAmountOfChange = self.totalAmountInput - product.price;
    }
    self.totalAmountInput = 0;
}

- (BOOL)buyProduct:(Product *)product {
    BOOL bought = NO;
    if ([self canBuyProduct:product]) {
        [self completeTransaction:product];
        bought = YES;
    }
    return bought;
}

- (NSUInteger)coinReturn {
    self.totalAmountOfChange += self.totalAmountInput;
    NSUInteger saveTotalAmountInput = self.totalAmountInput;
    self.totalAmountInput = 0;
    return saveTotalAmountInput;
}



@end
