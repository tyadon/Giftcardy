//
//  GiftcardManager.h
//  Giftcardy
//
//  Created by Trey Yadon on 4/14/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Giftcard;

@interface GiftcardManager : NSObject

+ (instancetype) sharedManager;
- (void) addGiftcard:(Giftcard*)giftcard;
- (Giftcard *) giftcardAtIndex:(NSUInteger)index;
- (NSInteger) numberOfGiftcards;
- (void) addAmount:(double)amount toGiftcard:(Giftcard *)giftcard;
- (void) subtractAmount:(double)amount fromGiftcard:(Giftcard *)giftcard;
- (void) deleteGiftcard:(Giftcard *)giftcard;

@property (nonatomic, readonly)NSMutableArray *giftcards;

@end
