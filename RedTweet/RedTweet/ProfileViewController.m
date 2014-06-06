//
//  ProfileViewController.m
//  RedTweet
//
//  Created by Nazir Shuqair on 6/5/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "ProfileViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    profile = [[ProfileInfo alloc]init];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Loading" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    [alertView show];
    
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
                        
                        //Twitter timeline url
                        NSString *requestString = @"https://api.twitter.com/1.1/users/show.json";
                        
                        NSDictionary *params = [NSDictionary dictionaryWithObject:@"2230880107" forKey:@"user_id"];
                        
                        
                        //Social framework request
                        SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:requestString] parameters:params];
                        
                        // requesting info on current account
                        [request setAccount:currentAccount];
                        
                        
                        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                            
                            //if there are no errors and code is 200 (which means good to go) then serialize
                            if ((error == nil) && ([urlResponse statusCode] == 200)) {
                                NSArray *accountDetails = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                                
                                
                                NSMutableDictionary * mutableDict = [NSMutableDictionary dictionaryWithCapacity:10];
                                [mutableDict setObject:accountDetails forKey:@"threeLetters"];
                                NSDictionary * dict = [mutableDict valueForKey:@"threeLetters"];
                                NSString* userNameString = [dict valueForKeyPath:@"name"];
                                NSString* userDescriptionString = [dict valueForKeyPath:@"description"];
                                NSString* friendCountString = [dict valueForKeyPath:@"friends_count"];
                                NSString* followerCountString = [dict valueForKeyPath:@"followers_count"];
                                
                                // populating profileInfo variables
                                [profile initWithProfileInfo:userNameString userDiscString:userDescriptionString numFollowers:followerCountString numFriends:friendCountString];
                                
                                
                            }
                        }];
                    }
                }else{
                    
                }
            }];
            // dissmissing alert view once done loading
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    
    
    
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated{
    
    // Populating labels with data after the view appears
    
    _userName.text = [NSString stringWithFormat:@"Profile Name: %@", profile.userName];

    _userDisc.text = [NSString stringWithFormat:@"Description: %@",profile.userDisc];
    
    _userNumOfFollowers.text = [NSString stringWithFormat:@"Followers: %@", profile.userNumOfFollowers2];
    
    _userNumOfFriends.text = [NSString stringWithFormat:@"Friends: %@", profile.userNumOfFriends2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
