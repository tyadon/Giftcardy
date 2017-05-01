//
//  AddViewController.h
//  Giftcardy
//
//  Created by Trey Yadon on 1/6/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblNameStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblAmntStatus;
@property (weak, nonatomic) IBOutlet UITextField *cardName;
@property (weak, nonatomic) IBOutlet UITextField *cardValue;
@property (weak, nonatomic) IBOutlet UITextField *cardNumber;
@property (weak, nonatomic) IBOutlet UITextField *cardPin;

@end
