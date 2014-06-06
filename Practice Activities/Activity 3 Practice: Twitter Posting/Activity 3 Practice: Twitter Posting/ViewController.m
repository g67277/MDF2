//
//  ViewController.m
//  Activity 3 Practice: Twitter Posting
//
//  Created by Nazir Shuqair on 6/3/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "TwitterPostInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [self twitterRefresh];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) twitterRefresh{
    
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    if (accountStore != nil) {
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter ];
        if (accountType != nil) {
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                if (granted) {
                    
                    NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                    if (twitterAccounts != nil) {
                        
                        ACAccount *currentAccount = [twitterAccounts objectAtIndex:0];
                        //NSLog(@"CurrentAccount: %@", currentAccount);
                        
                        NSString *requestURL = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
                        
                        SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:requestURL] parameters:nil];
                        
                        [request setAccount:currentAccount];
                        
                        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                            if ((error == nil) && ([urlResponse statusCode] == 200)) {
                                
                                NSArray *twitterFeed = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                                
                                for (NSInteger i = 0; i < [twitterFeed count]; i++) {
                                    
                                    TwitterPostInfo *postInfo = [self createPostInfoDictionary: [twitterFeed objectAtIndex:i]];
                                    
                                    if (postInfo != nil) {
                                        [twitterPosts addObject:postInfo];
                                    }
                                    
                                }
                                
                                NSDictionary *firstPost = [twitterFeed objectAtIndex:0];
                                NSLog(@"first post: %@", firstPost);
                                
                            }
                        }];
                    }
                    
                }else{
                    
                }
            }];
        }
    }
    
}

- (TwitterPostInfo*) createPostInfoDictionary: (NSDictionary*) postDictionary{
    
    NSString* timeDateString = [postDictionary objectForKey:@"created_at"];
    NSDictionary* userDictionary = [postDictionary objectForKey:@"user"];
    NSString* userNameString = [userDictionary  objectForKey:@"screen_name"];
    NSString* statusesCount = [userDictionary objectForKey:@"statuses_count"];
    NSString* retweetsCount = [postDictionary objectForKey:@"retweet_count"];
    NSString* textString = [postDictionary objectForKey:@"text"];
    
    TwitterPostInfo *postInfo = [[TwitterPostInfo alloc] initPostWithInfo:userNameString text:textString timeDateInfo:timeDateString retweets:retweetsCount statusCountInt:statusesCount];
    
    return postInfo;
    
}

- (IBAction)onClick:(id)sender{
    
    SLComposeViewController *slComposerViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [slComposerViewController setInitialText:@"this is a new test"];
    
    [self presentViewController:slComposerViewController animated:true completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
