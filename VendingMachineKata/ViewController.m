//
//  ViewController.m
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *AmountInputLabel;
@property (weak, nonatomic) IBOutlet UILabel *AmountOfChangeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *soldOutSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *exactChangeSwitch;

@property NSTimeInterval secondsOfDelay;
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
    self.totalAmountInput = 0;
    self.totalInCoinReturn = 0;
    self.currentProductPrice = 0;
    
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

- (IBAction)takeChangeButtonAction:(id)sender {
    [self takeChange];
}

- (IBAction)buyChipsButtonAction:(id)sender {
    [self buyProduct:self.chips];
}

- (IBAction)buyColaButtonAction:(id)sender {
    [self buyProduct:self.cola];
}

- (IBAction)buyCandyButtonAction:(id)sender {
    [self buyProduct:self.candy];
}

- (IBAction)returnCoinButtonAction:(id)sender {
    [self returnCoins];
}

- (IBAction)soldOutSwitchAction:(id)sender {
    [self setSoldOut:self.soldOutSwitch.on];
}

- (IBAction)exactChangeSwitchAction:(id)sender {
    [self setExactChange:self.exactChangeSwitch.on];
}

#pragma mark - supporting functions
- (void)updateCoinAmounts {
    self.totalAmountInput  = [self.vendingMachineManager pennyAmountOfCoinsInput];
    self.totalInCoinReturn = [self.vendingMachineManager pennyAmountOfCoinsReturned];
}

- (void)takeChange {
    [self.vendingMachineManager takeChange];
    [self updateCoinAmounts];
    [self updateChangeLabel];
}

- (void) returnCoins {
    [self.vendingMachineManager coinReturn];
    [self updateCoinAmounts];
    [self updateChangeLabel];
    [self updateInputLabel];
}

- (void)insertCoin:(CoinType) coin {
    [self.vendingMachineManager insertCoin:coin];
    [self updateCoinAmounts];
    [self updateInputLabel];
    [self updateChangeLabel];
}

- (void)updateInputLabel {
    self.AmountInputLabel.text = self.totalAmountInput == 0 ? (self.vendingMachineManager.useExactChange ? EXACT_CHANGE_ONLY : INSERT_COIN)
                                                            : [NSString stringWithFormat:@"$%lu.%02lu",self.totalAmountInput/100,self.totalAmountInput%100];
}

- (void)updateChangeLabel {
    self.AmountOfChangeLabel.text = [NSString stringWithFormat:@"$%lu.%02lu",self.totalInCoinReturn/100,self.totalInCoinReturn%100];
}

- (void)showProductPrice {
    NSString *priceLabel = [NSString stringWithFormat:@"%@ $%lu.%02lu",PRICE,self.currentProductPrice/100,self.currentProductPrice%100];
    self.AmountInputLabel.text = self.vendingMachineManager.isSoldOut ? SOLD_OUT : self.vendingMachineManager.productCostExceeded ? EXACT_CHANGE_ONLY : priceLabel;
}

- (void)showThankYou {
    self.AmountInputLabel.text = THANK_YOU;
}

- (void)buyProduct:(Product *)product {
    self.currentProductPrice = product.price;

    if (!self.vendingMachineManager.isSoldOut && [self.vendingMachineManager buyProduct:product]) {
        [self updateCoinAmounts];
        [self showThankYou];
        [self updateChangeLabel];
    } else {
        [self showProductPrice];
    }
    [self performSelector:@selector(updateInputLabel) withObject:nil afterDelay:self.secondsOfDelay];
}

- (void)setSoldOut:(BOOL)isSoldOut {
    self.vendingMachineManager.isSoldOut = isSoldOut;
}

- (void)setExactChange:(BOOL)useExactChange {
    self.vendingMachineManager.useExactChange = useExactChange;
    [self updateInputLabel];
}

@end
