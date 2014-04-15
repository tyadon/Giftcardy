//
//  CardCell.m
//  Giftcardy
//
//  Created by Trey Yadon on 1/7/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import "CardCell.h"
#import "Giftcard.h"

@interface CardCell ()

@end

@implementation CardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
