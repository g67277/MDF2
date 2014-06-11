//
//  ViewController.m
//  MDF 2 Test 1
//
//  Created by Nazir Shuqair on 6/2/14.
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
    [self refreshTwitter];
    
    UIImage* test1 = [UIImage imageNamed:@"germany.png"];
    
    testView.image = test1;
    
    //initializing array
    twitterPosts = [[NSMutableArray alloc]init];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated{
    
    [UIView animateWithDuration:2.0f animations:^{
        
        //where to move the view
        myBox.frame = CGRectMake(100.0f, 200.0f, 50.0f, 50.0f);
        // change the color
        myBox.backgroundColor = [UIColor blueColor];
    }
     completion:^(BOOL finished) {
         myBox.hidden = true;
     }];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshTwitter {
    
        
    // This is the accounts store
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    if (accountStore != nil) {
        // Define the accoun type (e.g. facbook, twitter, ...)
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        if (accountType != nil){
            // Request permission to access the account
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                if (granted) {
                    //Add accounts to array incase there are more than one
                    NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                    if (twitterAccounts != nil) {
                        
                        //object to use if i want a single account from array
                        ACAccount *currentAccount = [twitterAccounts objectAtIndex:0];
                        NSLog(@"Twitter account = to %@", currentAccount);
                        
                        //Twitter timeline url
                        NSString *requestString = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
                        
                        //Social framework request
                        SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:requestString] parameters:nil];
                        
                        // requesting info on current account
                        [request setAccount:currentAccount];
                        
                        
                        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                            
                            //if there are no errors and code is 200 (which means good to go) then serialize
                            if ((error == nil) && ([urlResponse statusCode] == 200)) {
                                //serializing the responseData into twitterfeed
                                NSArray *twitterFeed = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                                NSLog(@"twitterFeed: %@", twitterFeed);
                                
                                // loops through all posts
                                for (NSInteger i = 0; i < [twitterFeed count]; i++) {
                                    
                                    //creates a dictionary for each post
                                    TwitterPostInfo *postInfo = [self createPostInfoFromDictionary: [twitterFeed objectAtIndex:i]];
                                    
                                    if (postInfo != nil) {
                                        
                                        //adds the post to the array
                                        [twitterPosts addObject:postInfo];
                                    }
                                }
                                
                                //Only calling first post
                                NSDictionary *firstPost = [twitterFeed objectAtIndex:0];
                                //NSLog(@"response: %@", [firstPost description]);
                            }
                        }];
                    }
                }else{
                
                }
            }];
        }
    }
    
    NSLog(@"%lu", (unsigned long)[twitterPosts count]);
}

// default social framework button to post tweets
- (IBAction)onClick:(id)sender{
    
    //defining the service time "Twitter"
    SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    //Set default/initial text in a post
    [slComposeViewController setInitialText:@"#LastPick"];
    
    //Set image in post
    [slComposeViewController addImage:[UIImage imageNamed:@""]];
    
    //preset the twitter default box on screen
    [self presentViewController:slComposeViewController animated:false completion:nil];
}

- (TwitterPostInfo*) createPostInfoFromDictionary: (NSDictionary*) postDictionary{
    
    // pull the data from dictionaries
    NSString* timeDateString = [postDictionary valueForKey:@"created_at"];
    NSDictionary* userDictionary = [postDictionary valueForKey:@"user"];
    NSString* userString = [userDictionary valueForKey:@"screen_name"];
    NSString* userDescriptionString = [userDictionary valueForKey:@"description"];
    NSString* tweetTextString = [postDictionary valueForKey:@"text"];
    NSString* userImageString = [userDictionary valueForKey:@"profile_image_url"];
    UIImage* userImage3 = [UIImage imageNamed:userImageString];
    
    //create the object and send in the data using the method
    TwitterPostInfo *postInfo = [[TwitterPostInfo alloc]initWithpostInfo:userString userDesc:userDescriptionString text:tweetTextString timeDateInfo:timeDateString userImage2:userImage3];

    return postInfo;
}

@end
