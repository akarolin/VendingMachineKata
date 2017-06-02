//
//  Product.m
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/2/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import "Product.h"

@implementation Product

- (id)initProductName:(NSString *)productName withPrice:(NSUInteger)price {
    if (self = [super init]) {
        _productName = productName;
        _price = price;
    }
    return self;
}

@end
