//
//  GiftcardManager.m
//  Giftcardy
//
//  Created by Trey Yadon on 4/14/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import "GiftcardManager.h"
#import "Giftcard.h"
#import "GiftcardDataManager.h"

@interface GiftcardManager ()

@property (nonatomic, readwrite) NSMutableArray *giftcards;

@end

@implementation GiftcardManager

+ (instancetype) sharedManager {
    static GiftcardManager *singleton;
    
    if (!singleton) {
        singleton = [GiftcardManager new];
        singleton.giftcards = [self properGiftcards];
    }
    
    return singleton;
}

+ (NSMutableArray*) properGiftcards {
    NSMutableArray *savedGiftcards = [GiftcardDataManager savedGiftcards];
    return savedGiftcards ? savedGiftcards : [NSMutableArray array];
}

- (void) addGiftcard:(Giftcard *)giftcard {
    if ([self.giftcards indexOfObject:giftcard] == NSNotFound) {
        [self.giftcards insertObject:giftcard atIndex:0];
        [self saveGiftcards];
    }
}

- (Giftcard*) giftcardAtIndex:(NSUInteger)index {
    return self.giftcards[index];
}

- (void) addAmount:(double)amount toGiftcard:(Giftcard *)giftcard {
    [giftcard addAmount:amount];
    [self saveGiftcards];
}

- (void) subtractAmount:(double)amount fromGiftcard:(Giftcard *)giftcard {
    [giftcard subtractAmount:amount];
    [self saveGiftcards];
}

- (NSString *) getFormattedValfromGiftcard:(Giftcard *)giftcard {
    return [giftcard formattedAmount];
}

- (void) deleteGiftcard:(Giftcard *)giftcard {
    if ([self.giftcards indexOfObject:giftcard] != NSNotFound) {
        [self.giftcards removeObject:giftcard];
        [self saveGiftcards];
    }
}

- (NSInteger) numberOfGiftcards {
    return [self.giftcards count];
}

- (void) saveGiftcards {
    [GiftcardDataManager saveGiftcards:self.giftcards];
}

@end
