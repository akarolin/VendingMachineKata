//
//  Product.h
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/2/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (strong, nonatomic) NSString *productName;
@property NSUInteger price; // in pennies

- (id)initProductName:(NSString *)productName withPrice:(NSUInteger)price;

@end
