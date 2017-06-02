//
//  ViewController.m
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) VendingMachineManager *vendingMachineManager;

@property (strong, nonatomic) Product *chips;
@property (strong, nonatomic) Product *cola;
@property (strong, nonatomic) Product *candy;

@end

@implementation ViewController

NSString * const THANK_YOU = @"THANK YOU";
NSString * const INSERT_COIN = @"INSERT COIN";
NSString * const PRICE = @"PRICE:";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vendingMachineManager = [[VendingMachineManager alloc] init];
    
    self.chips = [[Product alloc] initProductName:@"Chips" withPrice:50];
    self.cola = [[Product alloc] initProductName:@"Cola" withPrice:50];
    self.candy = [[Product alloc] initProductName:@"Candy" withPrice:50];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddMoney:(id)sender {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Insert Coins"
                                 message:@"Select Coin"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* penny = [UIAlertAction
                            actionWithTitle:@"Penny"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [self insertCoin:Penny];
                                [view dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    UIAlertAction* nickel = [UIAlertAction
                             actionWithTitle:@"Nickel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self insertCoin:Nickel];
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    UIAlertAction* dime = [UIAlertAction
                            actionWithTitle:@"Dime"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [self insertCoin:Dime];
                                [view dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    UIAlertAction* quarter = [UIAlertAction
                             actionWithTitle:@"Quarter"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self insertCoin:Quarter];
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:penny];
    [view addAction:nickel];
    [view addAction:dime];
    [view addAction:quarter];
    [self presentViewController:view animated:YES completion:nil];
}

- (IBAction)takeChange:(id)sender {
    [self.vendingMachineManager takeChange];
    [self showAmountOfChange];
}


- (void)insertCoin:(CoinType) coin {
    [self.vendingMachineManager insertCoin:coin];
    [self showAmountInput];
    [self showAmountOfChange];
}

- (void)needMoreMoney:(Product *)product {
    [self showProductPrice:product];
}

- (void)successfulPurchase {
    [self showThankYou];
}

- (void)showAmountInput {
    NSUInteger total = [self.vendingMachineManager pennyAmountOfCoinsInput];
    self.AmountInputLabel.text = total == 0 ? INSERT_COIN : [NSString stringWithFormat:@"$%lu.%02lu",total/100,total%100];
}

- (void)showAmountOfChange {
    NSUInteger change = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    self.AmountOfChangeLabel.text = [NSString stringWithFormat:@"$%lu.%02lu",change/100,change%100];
}

- (void)showProductPrice:(Product *)product {
    self.AmountInputLabel.text = [NSString stringWithFormat:@"%@ $%lu.%02lu",PRICE,product.price/100,product.price%100];
}

- (void)showThankYou {
    self.AmountInputLabel.text = THANK_YOU;
}

- (void)buyProduct:(Product *)product {
    if ([self.vendingMachineManager canBuyProduct:product]) {
        [self successfulPurchase];
    } else {
        [self needMoreMoney:product];
    }
}

- (void)selectChips {
    [self buyProduct:self.chips];
}

- (void)selectCola {
    [self buyProduct:self.cola];
}

- (void)selectCandy {
    [self buyProduct:self.candy];
}

@end
