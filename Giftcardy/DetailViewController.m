//
//  DetailViewController.m
//  Giftcardy
//
//  Created by Trey Yadon on 1/7/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import "DetailViewController.h"
#import "GiftcardManager.h"
#import "UIFont+Giftcardy.h"
#import "UIColor+Giftcardy.h"

@implementation DetailViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                NSForegroundColorAttributeName : [UIColor whiteColor],
                                                NSFontAttributeName : [UIFont giftcardyNavigationBarFontSmall]};
    
    self.lblStatus.hidden = YES;
    
    [self.tfAdded setKeyboardType:UIKeyboardTypeDecimalPad];
    [self.tfSpent setKeyboardType:UIKeyboardTypeDecimalPad];
    
    [self.btnUpdate setBackgroundColor:[UIColor giftcardyBlueColor]];
    
    self.title = self.giftcard.name;
    self.imgviewIcon.image = [self.giftcard iconImage];
    [self updateGiftcard];
    
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
}

- (void) close {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark TextField

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField{
    textField.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void) clearTextFields{
    self.tfAdded.text = @"";
    self.tfSpent.text = @"";
}

#pragma mark Giftcard methods

- (BOOL) isAmountValid:(NSString *)amount {
    BOOL isValid = YES;
        
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

- (void) updateGiftcard {

    self.lblAmount.text = [self.giftcard formattedAmount];
}

- (IBAction) btnUpdate:(id)sender {
    [self.tfAdded resignFirstResponder];
    [self.tfSpent resignFirstResponder];
    
    if ((![self isAmountValid:self.tfAdded.text]) | (! [self isAmountValid:self.tfSpent.text]) ) {
        self.lblStatus.text = @"Please enter a valid amount";
        self.lblStatus.textColor  = [UIColor giftcardyStatusErrorColor];
        self.lblStatus.hidden = NO;
        [self clearTextFields];
    } else {
        double added = [self.tfAdded.text floatValue];
        double spent = [self.tfSpent.text floatValue];

        if (added > 0) {
            [[GiftcardManager sharedManager] addAmount:added toGiftcard:self.giftcard];
        }
        
        if (spent > 0) {
            [[GiftcardManager sharedManager] subtractAmount:spent fromGiftcard:self.giftcard];
        }
        
        self.lblStatus.text = @"Successfully updated";
        self.lblStatus.textColor = [UIColor giftcardyGreenColor];
        self.lblStatus.hidden = NO;
        [self clearTextFields];
        [self updateGiftcard];
    }
}

#pragma mark Delete card

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Yes, delete it."]) {
        [[GiftcardManager sharedManager] deleteGiftcard:self.giftcard];
        [self close];
    }
}

- (IBAction) btnTrash:(id)sender {
    UIAlertView *deleteAlert = [[UIAlertView alloc] initWithTitle:@"Confirm"
                                                          message:@"Are you sure you want to delete this card?"
                                                          delegate:self
                                             cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Yes, delete it.", nil];
    [deleteAlert show];
}
@end
