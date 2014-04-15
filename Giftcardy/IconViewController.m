//
//  IconViewController.m
//  Giftcardy
//
//  Created by Trey Yadon on 1/14/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import "IconViewController.h"
#import "AddViewController.h"
#import "GiftcardManager.h"

@interface IconViewController () {
    int selectedIcon;
}

@end

@implementation IconViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"New Card";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveCardWithIcon:(int)icon{
    
    self.giftcard.icon = @(icon);
    [[GiftcardManager sharedManager] addGiftcard:self.giftcard];
    
    [self close];
}

- (void) close {
    self.tabBarController.selectedIndex = 1;
    AddViewController *rootViewController = (AddViewController *)[self.navigationController.viewControllers objectAtIndex:0];
    rootViewController.cardName.text = @"";
    rootViewController.cardValue.text = @"";
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (IBAction)btnBeer:(id)sender {
    [self saveCardWithIcon:0];
}

- (IBAction)btnFries:(id)sender {
    [self saveCardWithIcon:1];
}

- (IBAction)btnPizza:(id)sender {
    [self saveCardWithIcon:2];
}

- (IBAction)btnTaco:(id)sender {
    [self saveCardWithIcon:3];
}

- (IBAction)btnHammer:(id)sender {
    [self saveCardWithIcon:4];
}

- (IBAction)btnShirt:(id)sender {
    [self saveCardWithIcon:5];
}

- (IBAction)btnSports:(id)sender {
    [self saveCardWithIcon:6];
}

- (IBAction)btnComputer:(id)sender {
    [self saveCardWithIcon:7];
}
@end
