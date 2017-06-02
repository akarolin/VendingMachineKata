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

- (IBAction)takeChange:(id)sender;

- (void)insertCoin:(CoinType) coin;
- (void)buyProduct:(Product *)product;

@end

extern NSString * const THANK_YOU;
extern NSString * const INSERT_COIN;
extern NSString * const PRICE;

