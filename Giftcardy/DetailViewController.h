//
//  DetailViewController.h
//  Giftcardy
//
//  Created by Trey Yadon on 1/7/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Giftcard.h"

@interface DetailViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic) Giftcard *giftcard;

@property (weak, nonatomic) IBOutlet UIImageView *imgviewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UITextField *tfSpent;
@property (weak, nonatomic) IBOutlet UITextField *tfAdded;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;
- (IBAction)btnTrash:(id)sender;
- (IBAction)btnUpdate:(id)sender;

@end
