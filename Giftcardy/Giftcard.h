//
//  Giftcard.h
//  Giftcardy
//
//  Created by Trey Yadon on 4/14/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Giftcard : NSObject <NSCoding>

+ (instancetype) giftcardWithName:(NSString *)name amount:(double)amt icon:(NSInteger)icon number:(NSString *)number pin:(NSString *)pin;

- (void) addAmount:(double)amount;
- (void) subtractAmount:(double)amount;
- (NSString *) formattedAmount;
- (UIImage *) iconImage;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *icon;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *pin;

@end
