//
//  ViewController.m
//  Activity 2 Practice Tweets User Timeline
//
//  Created by Nazir Shuqair on 6/2/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [self refreshTweets];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshTweets{
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    if (accountStore != nil) {
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        if (accountType != nil) {
            
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                if (granted) {
                    
                    NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                    if (twitterAccounts != nil) {
                        ACAccount *account = [twitterAccounts objectAtIndex:0];
                        
                        NSString *requestString = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
                        
                        SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:requestString] parameters:nil];
                        
                        [request setAccount:account];
                        
                        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                            if ((error == nil) && ([urlResponse statusCode] == 200)) {
                                
                                NSArray *tweets = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                                
                                NSDictionary *firstPost = [tweets objectAtIndex:0];
                                NSLog(@"first post: %@", [firstPost description]);
                                
                            }
                            
                        }];
                    }
                    
                }else{
                    
                }
            }];
        }
    }
    
}

@end
