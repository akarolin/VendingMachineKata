//
//  ViewController.h
//  VendingMachineKata
//
//  Created by Andy Karolin on 6/1/17.
//  Copyright © 2017 AccendantC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoinManager.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *AmountInputLabel;
@property (weak, nonatomic) IBOutlet UILabel *AmountOfChangeLabel;

- (void)insertCoin:(CoinType) coin;

@end

