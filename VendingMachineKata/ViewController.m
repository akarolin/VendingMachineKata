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

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.vendingMachineManager = [[VendingMachineManager alloc] init];
    self.secondsOfDelay = 1.0;
    
    self.chips = [[Product alloc] initProductName:@"Chips" withPrice:CHIP_PRICE];
    self.cola =  [[Product alloc] initProductName:@"Cola" withPrice:COLA_PRICE];
    self.candy = [[Product alloc] initProductName:@"Candy" withPrice:CANDY_PRICE];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Actions

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

- (IBAction)buyChips:(id)sender {
    [self buyProduct:self.chips];
}

- (IBAction)buyCola:(id)sender {
    [self buyProduct:self.cola];
}

- (IBAction)buyCandy:(id)sender {
    [self buyProduct:self.candy];
}

- (IBAction)returnCoins:(id)sender {
    [self.vendingMachineManager coinReturn];
    [self showAmountOfChange];
    [self showAmountInput];
}

- (IBAction)setSoldOutStatus:(id)sender {
    [self setSoldOut:self.soldOutSwitch.on];
}

- (IBAction)exactChangeSwitchAction:(id)sender {
    [self setExactChange:self.exactChangeSwitch.on];
}

#pragma mark - supporting functions

- (void)insertCoin:(CoinType) coin {
    [self.vendingMachineManager insertCoin:coin];
    [self showAmountInput];
    [self showAmountOfChange];
}

- (void)needMoreMoney:(Product *)product {
    [self showProductPrice:product];
}

- (void)showAmountInput {
    NSUInteger total = [self.vendingMachineManager pennyAmountOfCoinsInput];
    self.AmountInputLabel.text = total == 0 ? self.vendingMachineManager.useExactChange ? EXACT_CHANGE_ONLY : INSERT_COIN : [NSString stringWithFormat:@"$%lu.%02lu",total/100,total%100];
}

- (void)showAmountOfChange {
    NSUInteger change = [self.vendingMachineManager pennyAmountOfCoinsReturned];
    self.AmountOfChangeLabel.text = [NSString stringWithFormat:@"$%lu.%02lu",change/100,change%100];
}

- (void)showProductPrice:(Product *)product {
    NSString *priceLabel = [NSString stringWithFormat:@"%@ $%lu.%02lu",PRICE,product.price/100,product.price%100];
    self.AmountInputLabel.text = self.vendingMachineManager.isSoldOut ? SOLD_OUT : self.vendingMachineManager.productCostExceeded ? EXACT_CHANGE_ONLY : priceLabel;
}

- (void)showThankYou {
    self.AmountInputLabel.text = THANK_YOU;
}

- (void)buyProduct:(Product *)product {
    if ([self.vendingMachineManager buyProduct:product]) {
        [self showThankYou];
        [self showAmountOfChange];
    } else {
        [self needMoreMoney:product];
    }
    [self performSelector:@selector(showAmountInput) withObject:nil afterDelay:self.secondsOfDelay];
}

- (void)setSoldOut:(BOOL)isSoldOut {
    self.vendingMachineManager.isSoldOut = isSoldOut;
}

- (void)setExactChange:(BOOL)useExactChange {
    self.vendingMachineManager.useExactChange = useExactChange;
    [self showAmountInput];
}

@end
