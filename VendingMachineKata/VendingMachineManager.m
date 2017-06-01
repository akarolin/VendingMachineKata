//
//  VendingMachineManager.m
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import "VendingMachineManager.h"

@interface CoinObject : NSObject
@property CoinType coin;
@end

@implementation CoinObject

- (id)initWithCoin:(CoinType) coin {
   if (self = [super init]) {
       _coin = coin;
    }
    return self;
}

@end

@interface VendingMachineManager()

@property (strong, nonatomic) NSMutableArray *coinsInput;
@property (strong, nonatomic) NSMutableArray *coinsReturned;
@property (strong, nonatomic) CoinManager *coinManager;

@end

@implementation VendingMachineManager

- (id)init {
    if (self = [super init]) {
        _coinsInput = [[NSMutableArray alloc] init];
        _coinsReturned = [[NSMutableArray alloc] init];
        _coinManager = [[CoinManager alloc] init];
    }
    return self;
}

- (void)inputCoin:(CoinType) coin {
    CoinObject *coinObj = [[CoinObject alloc] initWithCoin:coin];
    if ([self.coinManager isValidCoin:(coin)]) {
        [self.coinsInput addObject:coinObj];
    } else {
        [self.coinsReturned addObject:coinObj];
    }
}

- (NSUInteger)numberOfCoinsInput {
    return [self.coinsInput count];
}

- (NSUInteger)numberOfCoinsReturned {
    return [self.coinsReturned count];
}

@end
