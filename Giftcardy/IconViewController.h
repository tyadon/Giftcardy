//
//  IconViewController.h
//  Giftcardy
//
//  Created by Trey Yadon on 1/14/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Giftcard.h"

@interface IconViewController : UIViewController

@property (strong, nonatomic) Giftcard *giftcard;

- (IBAction)btnBeer:(id)sender;
- (IBAction)btnFries:(id)sender;
- (IBAction)btnPizza:(id)sender;
- (IBAction)btnTaco:(id)sender;
- (IBAction)btnHammer:(id)sender;
- (IBAction)btnShirt:(id)sender;
- (IBAction)btnSports:(id)sender;
- (IBAction)btnComputer:(id)sender;

@end
