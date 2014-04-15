//
//  CardCell.h
//  Giftcardy
//
//  Created by Trey Yadon on 1/7/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UIImageView *imgviewIcon;

@end
