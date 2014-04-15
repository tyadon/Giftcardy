//
//  CardsViewController.m
//  Giftcardy
//
//  Created by Trey Yadon on 1/6/14.
//  Copyright (c) 2014 Kentech. All rights reserved.
//

#import "CardsViewController.h"
#import "DetailViewController.h"
#import "CardCell.h"
#import "GiftcardManager.h"
#import "Giftcard.h"
#import "UIFont+Giftcardy.h"
#import "UIColor+Giftcardy.h"

@interface CardsViewController ()

@property (nonatomic) NSMutableArray *cards;

@end

@implementation CardsViewController

- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
    self.title = @"My Cards";
    
    // remove navigation back bar title
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // set title and title color
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                NSForegroundColorAttributeName : [UIColor whiteColor],
                                                NSFontAttributeName : [UIFont giftcardyNavigationBarFont]};
    
    //set back button color
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    //set back button arrow color
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor giftcardyBlueColor];
        self.navigationController.navigationBar.translucent = NO;
    }else {
        self.navigationController.navigationBar.tintColor = [UIColor giftcardyBlueColor];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [self checkNumberOfCards];
    [self refreshTable];
}

- (void) checkNumberOfCards {
    if ([[GiftcardManager sharedManager] numberOfGiftcards] == 0) {
        [self presentAddAlertView];
    }
}

#pragma mark AlertView

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Yes!"]) {
        [self presentAddViewController];
    }
}

- (void) presentAddAlertView {
    UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:nil
                                                       message:@"It looks like you don't have any giftcards. Would you like to add one now?"
                                                      delegate:self
                                             cancelButtonTitle:@"No Thanks"
                                             otherButtonTitles:@"Yes!", nil];
    [addAlert show];
}


#pragma mark - Table view data source

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[GiftcardManager sharedManager] numberOfGiftcards];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Giftcard *giftcard = [[GiftcardManager sharedManager] giftcardAtIndex:indexPath.row];
    
    CardCell *cell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:@"giftcardCell" forIndexPath:indexPath];
    
    cell.name.text = giftcard.name;
    cell.amount.text = [giftcard formattedAmount];
    cell.amount.textColor = [UIColor giftcardyGreenColor];
    
    cell.imgviewIcon.image = [giftcard iconImage];

    return cell;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void) refreshTable {
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Giftcard *giftcard = [[GiftcardManager sharedManager] giftcardAtIndex:indexPath.row];
        DetailViewController *dest = segue.destinationViewController;
        dest.giftcard = giftcard;
    }
}

- (void) presentAddViewController {
    UITabBarController *tabBar = self.tabBarController;
    tabBar.selectedIndex = 0;
}



@end
