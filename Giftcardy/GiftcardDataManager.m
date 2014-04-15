//
//  GiftcardDataManager.m
//  Giftcardy
//
//  Created by Trey Yadon on 4/14/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import "GiftcardDataManager.h"

@implementation GiftcardDataManager

+ (void) saveGiftcards:(NSMutableArray *)giftcards {
    [NSKeyedArchiver archiveRootObject:giftcards toFile:[self giftcardFilePath]];
}

+ (NSMutableArray*) savedGiftcards {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self giftcardFilePath]];
}

+ (NSString*) giftcardFilePath {
    return [self documentsDataPathWithPathComponent:@"Giftcards.gy"];
}

#pragma mark Common Methods

+ (NSString*) documentsDataPathWithPathComponent:(NSString*)pathComponent {
    NSString *documentsFileName = [[self documentsPath] stringByAppendingPathComponent:pathComponent];
    return documentsFileName;
}

+ (NSString*) documentsPath {
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    return [documentsURL path];
}

@end
