//
//  GiftcardDataManager.h
//  Giftcardy
//
//  Created by Trey Yadon on 4/14/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftcardDataManager : NSObject

+ (void) saveGiftcards:(NSMutableArray*)giftcards;
+ (NSMutableArray*) savedGiftcards;

@end
