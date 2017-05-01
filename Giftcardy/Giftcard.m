//
//  Giftcard.m
//  Giftcardy
//
//  Created by Trey Yadon on 4/14/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import "Giftcard.h"

@implementation Giftcard

#pragma mark NSCoding

#define kNameKey        @"Name"
#define kAmountKey      @"Amount"
#define kIconKey        @"Icon"
#define kNumberKey      @"Number"
#define kPinKey            @"Pin"

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeObject:self.amount forKey:kAmountKey];
    [aCoder encodeObject:self.icon forKey:kIconKey];
    [aCoder encodeObject:self.number forKey:kNumberKey];
    [aCoder encodeObject:self.pin forKey:kPinKey];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:kNameKey];
        self.amount = [aDecoder decodeObjectForKey:kAmountKey];
        self.icon = [aDecoder decodeObjectForKey:kIconKey];
        self.number = [aDecoder decodeObjectForKey:kNumberKey];
        self.pin = [aDecoder decodeObjectForKey:kPinKey];
    }
    return self;
}

+ (instancetype) giftcardWithName:(NSString *)name amount:(double)amount icon:(NSInteger)icon number:(NSString *)number pin:(NSString *)pin{
    Giftcard *newGiftcard = [Giftcard new];
    
    newGiftcard.name = name;
    newGiftcard.amount = [NSNumber numberWithDouble:amount];
    newGiftcard.icon = [NSNumber numberWithInteger:icon];
    newGiftcard.number = number;
    newGiftcard.pin = pin;
    
    return newGiftcard;
}

- (void) addAmount:(double)amount {
    double newAmount = [self.amount doubleValue] + amount;
    
    self.amount = [NSNumber numberWithDouble:newAmount];
}

- (void) subtractAmount:(double)amount {
    double newAmount = [self.amount doubleValue] - amount;
    
    self.amount = [NSNumber numberWithDouble:newAmount];
}

- (NSString *) formattedAmount {

    NSString *formattedVal = [NSString stringWithFormat:@"%.2f", [self.amount floatValue]];
    formattedVal = [@"$" stringByAppendingString:formattedVal];
    
    return formattedVal;
}

- (UIImage *) iconImage {
    NSString *imageName = [NSString stringWithFormat:@"icon%@.png", [self.icon stringValue]];
    return [UIImage imageNamed:imageName];
}

@end
