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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
                                //Do some thing here
                                [view dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    UIAlertAction* nickel = [UIAlertAction
                             actionWithTitle:@"Nickel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    UIAlertAction* dime = [UIAlertAction
                            actionWithTitle:@"Dime"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                //Do some thing here
                                [view dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    UIAlertAction* quarter = [UIAlertAction
                             actionWithTitle:@"Quarter"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:penny];
    [view addAction:nickel];
    [view addAction:dime];
    [view addAction:quarter];
    [self presentViewController:view animated:YES completion:nil];
}

- (IBAction)TakeChange:(id)sender {
}

@end
