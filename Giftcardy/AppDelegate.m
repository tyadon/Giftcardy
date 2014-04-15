//
//  AppDelegate.m
//  Giftcardy
//
//  Created by Trey Yadon on 1/6/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import "AppDelegate.h"
#import "Giftcard.h"
#import "GiftcardManager.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"Yf0q32Q6RSahHm4riHChVtdJvPKAgTIac90Hbx5L"
                  clientKey:@"zJi4cutcaluQJWFgVIrqqOGVgrlVVEJZoMdrYb88"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (error) {
            NSLog(@"Anonymous login failed.");
        } else {
            NSLog(@"Anonymous user logged in.");
        }
    }];
    
    [self checkForExistingCardsFromParse];
    
    if ([[GiftcardManager sharedManager] numberOfGiftcards] > 0) {
        UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
        tabBar.selectedIndex = 1;
    }
    
    return YES;
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) importExistingCardsFromParse {
    PFQuery *query = [PFQuery queryWithClassName:@"Giftcard"];
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"ownerUsername" equalTo:user.username];
    NSNumber *status = @1;
    [query whereKey:@"status" equalTo:status];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                Giftcard *giftcard = [Giftcard giftcardWithName:object[@"name"]
                                                         amount:[(NSNumber *)object[@"value"] doubleValue]
                                                           icon:[(NSNumber *)object[@"icon"] integerValue]];
                [[GiftcardManager sharedManager] addGiftcard:giftcard];
                [object setValue:@0 forKey:@"status"];
                [object saveInBackground];
            }
        }
    }];
}

- (void) checkForExistingCardsFromParse {
    PFQuery *query = [PFQuery queryWithClassName:@"Giftcard"];
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"ownerUsername" equalTo:user.username];
    NSLog(@"username: %@", user.username);
    NSNumber *status = @1;
    [query whereKey:@"status" equalTo:status];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (!error) {
            if (number > 0) {
                [self importExistingCardsFromParse];
            }
        }
    }];
}


@end
