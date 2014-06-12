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
@synthesize userName, userImageView;

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
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2;
    self.userImageView.clipsToBounds = YES;
    
    self.popUpView.layer.cornerRadius = 10.0f;
    self.popUpView.clipsToBounds = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void) viewWillAppear:(BOOL)animated{
    
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
                        NSString* username = currentAccount.accountDescription;
                        
                        //Twitter timeline url
                        NSString *requestString = @"https://api.twitter.com/1.1/users/show.json";
                        
                        NSDictionary *params = [NSDictionary dictionaryWithObject:username forKey:@"screen_name"];
                        
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
                                userName = [dict valueForKeyPath:@"name"];
                                userDisc = [dict valueForKeyPath:@"description"];
                                userNumOfFriends = [dict valueForKeyPath:@"friends_count"];
                                userNumOfFollowers = [dict valueForKeyPath:@"followers_count"];
                                NSString* imageURl = [dict valueForKey:@"profile_image_url"];
                                NSString* imageOriginal = [imageURl substringToIndex:[imageURl length] - 12];
                                NSMutableString* imageOriginalSize = [NSMutableString stringWithFormat:@"%@.jpeg", imageOriginal];
                                UIImage* postImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: imageOriginalSize]]];
                                UIImage* postBanner = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dict valueForKey:@"profile_banner_url"]]]];
                                userImage = postImage;
                                userBanner = postBanner;
                                
                                
                            }
                        }];
                    }
                }else{
                    // error alert view
                    UIAlertView *errorMessage = [[UIAlertView alloc] initWithTitle:@"Connection Lost!" message:@"Please check internet connection and try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [errorMessage show];
                    [alertView dismissWithClickedButtonIndex:0 animated:YES];
                    
                }
            }];
            // dissmissing alert view once done loading
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    
    
    
}

- (void) viewDidAppear:(BOOL)animated{
    
        // Populating labels with data after the view appears
    
    userNameLabel.text = userName;

    userDiscLabel.text = userDisc;
    
    userNumOfFollowersLabel.text = [NSString stringWithFormat:@"%@", userNumOfFollowers];
    
    userNumOfFriendsLabel.text = [NSString stringWithFormat:@"%@", userNumOfFriends];
    
    userBannerImage.image = userBanner;
    
    userImageView.image = userImage;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
