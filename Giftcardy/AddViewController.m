//
//  AddViewController.m
//  Giftcardy
//
//  Created by Trey Yadon on 1/6/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import "AddViewController.h"
#import "IconViewController.h"
#import "Giftcard.h"
#import "UIColor+Giftcardy.h"
#import "UIFont+Giftcardy.h"

@implementation AddViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
        
    // clear labels and text fields
    self.lblNameStatus.hidden = YES;
    self.lblAmntStatus.hidden = YES;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    // set delegates
    self.cardName.delegate = self;
    self.cardValue.delegate = self;
    
    // hide labels and set keyboard
    self.lblNameStatus.hidden = YES;
    self.lblNameStatus.textColor = [UIColor giftcardyStatusErrorColor];
    self.lblAmntStatus.hidden = YES;
    self.lblAmntStatus.textColor = [UIColor giftcardyStatusErrorColor];
    
    self.title = @"New Card";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                NSForegroundColorAttributeName : [UIColor whiteColor],
                                                NSFontAttributeName : [UIFont giftcardyNavigationBarFont]};
    
    // remove navigation back bar title
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    
    // set navigation bar color
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor giftcardyBlueColor];
        self.navigationController.navigationBar.translucent = NO;
    }else {
        self.navigationController.navigationBar.tintColor = [UIColor giftcardyBlueColor];
    }
    
    //set back button arrow color
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.cardName setAutocapitalizationType:UITextAutocapitalizationTypeWords];
    [self.cardValue setKeyboardType:UIKeyboardTypeDecimalPad];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        [self.cardValue becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark Validation

- (BOOL) isAmountValid:(NSString *)amount {
    BOOL isValid = YES;
    
    // check if empty
    if ([amount isEqualToString:@""]) {
        isValid = NO;
    }
    
    // check if more than one decimal is present
    if ([[amount componentsSeparatedByString:@"."] count]-1 > 1) {
        isValid = NO;
    }
    
    // check number of digits after decimal
    if ([amount rangeOfString:@"."].location != NSNotFound) {
        NSUInteger len = [[[amount componentsSeparatedByString:@"."] lastObject] length];
        if (len > 2) {
            isValid = NO;
        }
    }
    
    return isValid;
}

#pragma mark Navigation

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    BOOL shouldPerform = YES;
    
    if (![self isAmountValid:self.cardValue.text]) {
        self.lblAmntStatus.text = @"Please enter a valid amount";
        self.lblAmntStatus.hidden = NO;
        shouldPerform = NO;
    } else {
        self.lblAmntStatus.hidden = YES;
    }
    
    if ([self.cardName.text isEqualToString:@""]) {
        self.lblNameStatus.text = @"Please enter a name for this card";
        self.lblNameStatus.hidden = NO;
        shouldPerform = NO;
    } else {
        self.lblNameStatus.hidden = YES;
    }
    
    return shouldPerform;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"iconSegue"]) {
        IconViewController *destViewController = segue.destinationViewController;
        double amount = [self.cardValue.text doubleValue];
        Giftcard *giftcard = [Giftcard giftcardWithName:self.cardName.text amount: amount icon:0 number:@"" pin:@""];
        destViewController.giftcard = giftcard;
    }
}

@end
