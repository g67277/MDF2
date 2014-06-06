//
//  ViewController.m
//  Activity 1 Practice Accounts Framework
//
//  Created by Nazir Shuqair on 6/2/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    if (accountStore != nil) {
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        if (accountType != nil) {
            
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                if (granted) {
                    NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                    
                    ACAccount *currentAccount = [twitterAccounts objectAtIndex:0];
                    NSLog(@"here: %@", currentAccount);

                }else{
                    
                }
            }];
        }
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
