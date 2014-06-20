//
//  ViewController.m
//  RedTweet
//
//  Created by Nazir Shuqair on 6/4/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "FriendInfo.h"
#import "FriendCell.h"
#import "DetailsViewController.h"
#import "FriendDetailsViewController.h"
#import "PostInformation.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize currentAccount, profilePicture;


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
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
                        currentAccount = [twitterAccounts objectAtIndex:0];
                    }
                }else{
                    // error alert view
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *errorMessage = [[UIAlertView alloc] initWithTitle:@"Account Access!" message:@"Access not granted, please go to settings > twitter and grant RedTweet Access" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [errorMessage show];
                    });
                    
                }
            }];
        }
    }
    
    if ([twitterPosts count] < 1) {
        
        [self refreshTwitter];
    }
    
}

- (void) viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    //table view begins in the at 150 instead of top
    self.myTableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    self.myCollectionView.contentInset = UIEdgeInsetsMake(170, 0, 0, 0);
    
}

- (void)viewDidLoad
{
    
    //initializing array
    twitterPosts = [[NSMutableArray alloc]init];
    followerInfo = [[NSMutableArray alloc]init];
    
    // circule image
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.clipsToBounds = YES;
    
    
    
    
    
    // Method to get data
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated{
    
    //profilePicture.image = profileImageHome;
    
}

// unwinde method
- (IBAction) done:(UIStoryboardSegue*)segue{
    
    
}

//------------------------------------- Buttons ------------------------------------------

- (IBAction)onClick:(UIButton*)sender{
    // tag 0 is refresh
    if (sender.tag == 0) {
        // remove all objects in array
        [twitterPosts removeAllObjects];
        
        // run refreshTwitter method
        [self refreshTwitter];
        
        // reload data to table view
        [_myTableView reloadData];
        
        // tag 1 is post
    }if (sender.tag == 1) {
        //defining the service time "Twitter"
        SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        //Set default/initial text in a post
        [slComposeViewController setInitialText:@"Posted from #RedTweet"];
        
        //Set image in post
        //[slComposeViewController addImage:[UIImage imageNamed:@""]];
        
        //preset the twitter default box on screen
        [self presentViewController:slComposeViewController animated:false completion:nil];
    }if (sender.tag == 3) {
        
        if (segControl.selectedSegmentIndex == 0) {
            
            _myTableView.hidden = false;
            _myCollectionView.hidden = true;
            
        }else if (segControl.selectedSegmentIndex == 1){
            
            if ([followerInfo count] < 1) {
                [self refreshFriends];
            }
            
            _myTableView.hidden = true;
            _myCollectionView.hidden = false;
            
        }

    }
    
    
}
//-----------------------------------------------------------------------------------------------------------------

//------------------------------------ Twitter Refresh Method -----------------------------------------------------

- (void) refreshTwitter {
    
    // Loading alert view
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Loading" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    
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
            // Performs action in different thread to display information faster
            dispatch_async(dispatch_get_main_queue(), ^{
                // loops through all posts
                for (NSInteger i = 0; i < [twitterFeed count]; i++) {
                    
                    //creates a dictionary for each post
                    PostInformation *postInfo = [self createPostInfoFromDictionary: [twitterFeed objectAtIndex:i]];
                    //Adds object to array
                    if (postInfo != nil) {
                        //adds the post to the array
                        [twitterPosts addObject:postInfo];
                    }
                    // reloads the tableview
                    [_myTableView reloadData];
                }
                // dissmess the loading once its done
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
            });
        }else{
            // error alert view
            UIAlertView *errorMessage = [[UIAlertView alloc] initWithTitle:@"Connection Lost!" message:@"Please check internet connection and try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorMessage show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }];
}
//-----------------------------------------------------------------------------------------------------------------

//------------------------------------ Friends Refresh Method -----------------------------------------------------

- (void) refreshFriends {
    
    // Loading alert view
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Loading" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    
    //Twitter timeline url
    NSString *requestString = @"https://api.twitter.com/1.1/friends/list.json";
    
    //Social framework request
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:requestString] parameters:nil];
    
    // requesting info on current account
    [request setAccount:currentAccount];
    
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        //if there are no errors and code is 200 (which means good to go) then serialize
        if ((error == nil) && ([urlResponse statusCode] == 200)) {
            //serializing the responseData into twitterfeed
            NSArray *friendFeedJSON = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
            NSArray* friendFeed = [friendFeedJSON valueForKey:@"users"];
            // Performs action in different thread to display information faster
            dispatch_async(dispatch_get_main_queue(), ^{

                for (NSInteger i = 0; i < [friendFeed count]; i++) {

                    FriendInfo *postInfo = [self createFriendInfoFromDictionary: [friendFeed objectAtIndex:i]];
                    //Adds object to array
                    if (postInfo != nil) {
                        //adds the friend info to the array
                        [followerInfo addObject:postInfo];
                    }
                    // reloads the tableview
                    [_myCollectionView reloadData];
                }
                // dissmess the loading once its done
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
            });
        }else{
            // error alert view
            UIAlertView *errorMessage = [[UIAlertView alloc] initWithTitle:@"Connection Lost!" message:@"Please check internet connection and try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorMessage show];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }];
}
//-----------------------------------------------------------------------------------------------------------------

//------------------------------------- Creating Post Info From Dictionary ------------------------------------------

- (PostInformation*) createPostInfoFromDictionary: (NSDictionary*) postDictionary{
    
    // pull the data from dictionaries
    NSString* timeDateString = [postDictionary valueForKey:@"created_at"];
    NSDictionary* userDictionary = [postDictionary valueForKey:@"user"];
    NSString* userString = [userDictionary valueForKey:@"screen_name"];
    NSString* tweetTextString = [postDictionary valueForKey:@"text"];
    NSString* imageURl = [userDictionary valueForKey:@"profile_image_url"];
    NSString* imageOriginal = [imageURl substringToIndex:[imageURl length] - 12];
    NSMutableString* imageOriginalSize = [NSMutableString stringWithFormat:@"%@.jpeg", imageOriginal];
    UIImage* postImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: imageOriginalSize]]];
    profilePicture.image = postImage;
    UIImage* postBanner = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[userDictionary valueForKey:@"profile_banner_url"]]]];
    userScreenName.text = [NSString stringWithFormat:@"@%@", userString];
    
    //create the object and send in the data using the method
    PostInformation *postInfo = [[PostInformation alloc]initWithpostInfo:userString text:tweetTextString timeDateInfo:timeDateString postImage:postImage postBanner:postBanner];
    
    return postInfo;
}
//-----------------------------------------------------------------------------------------------------------------

//------------------------------------- Creating Friend Info From Dictionary ------------------------------------------

- (FriendInfo*) createFriendInfoFromDictionary: (NSDictionary*) friendDictionary{
    
    NSMutableString* profileImageOriginalSize = [[NSMutableString alloc] init];
    
    // pull the data from dictionaries
    NSString* nameString = [friendDictionary valueForKey:@"screen_name"];
    NSString* followersCount = [friendDictionary valueForKey:@"followers_count"];
    NSString* statusesCount = [friendDictionary valueForKey:@"statuses_count"];
    NSString* verified = [friendDictionary valueForKey:@"verified"];
    NSString* description = [friendDictionary valueForKey:@"description"];
    NSURL* profileBannerUrl = [NSURL URLWithString:[friendDictionary valueForKey:@"profile_banner_url"]];
    NSData* profileBannerData = [NSData dataWithContentsOfURL:profileBannerUrl];
    UIImage* profileBanner = [UIImage imageWithData:profileBannerData];
    NSString* profileImageUrlString = [friendDictionary valueForKey:@"profile_image_url"];
    NSString* imageFormatCheck = [profileImageUrlString substringFromIndex:[profileImageUrlString length] - 4];
    
    // checkes the image format
    if ([imageFormatCheck isEqualToString:@".png"]) {
        NSString* profileImageUrlEdit = [profileImageUrlString substringToIndex:[profileImageUrlString length] - 11];
        profileImageOriginalSize = [NSMutableString stringWithFormat:@"%@.png", profileImageUrlEdit];
    }else if ([imageFormatCheck isEqualToString:@"jpeg"]){
        NSString* profileImageUrlEdit = [profileImageUrlString substringToIndex:[profileImageUrlString length] - 12];
        profileImageOriginalSize = [NSMutableString stringWithFormat:@"%@.jpeg", profileImageUrlEdit];
    }else if ([imageFormatCheck isEqualToString:@".jpg"]){
        NSString* profileImageUrlEdit = [profileImageUrlString substringToIndex:[profileImageUrlString length] - 11];
        profileImageOriginalSize = [NSMutableString stringWithFormat:@"%@.jpg", profileImageUrlEdit];
    }
    
    NSURL* profileImageUrl = [NSURL URLWithString:profileImageOriginalSize];
    NSData* profileImageData = [NSData dataWithContentsOfURL:profileImageUrl];
    UIImage* profileImage = [UIImage imageWithData:profileImageData];
    
    //create the object and send in the data using the method
    FriendInfo *postInfo = [[FriendInfo alloc] initWithpostInfo:nameString folCount:followersCount statCount:statusesCount verif:verified pImage:profileImage bImage:profileBanner friendDesc:description];
    
    return postInfo;
}
//-----------------------------------------------------------------------------------------------------------------

#pragma mark tableview

//------------------------------------- Number of rows ------------------------------------------------------------

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        
    return [twitterPosts count];
}
//-----------------------------------------------------------------------------------------------------------------

//------------------------------------- Creating cells and populating data ----------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCell* cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    
    currentCell = [twitterPosts objectAtIndex:indexPath.row];
    [cell refreshCellWithInfo:currentCell.tweetText postDate:currentCell.timeDate postImage:currentCell.userImage];
    
    return cell;
}
//-----------------------------------------------------------------------------------------------------------------

#pragma mark collection View Methods

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [followerInfo count];
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"friendCell" forIndexPath:indexPath];
    currentFriend = [followerInfo objectAtIndex:indexPath.row];
    [cell refreshCellWithInfo:currentFriend.friendScreenName fImage:currentFriend.friendProfileImage];
    
    return cell;
}

#pragma mark segue
//------------------------------------- Segue methode -------------------------------------------------------------

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier  isEqual: @"toDetails"]){
        
        NSLog(@"segue %@", segue);
        NSLog(@"sender %@", sender);
        
        DetailsViewController* detailView = segue.destinationViewController;
        if (detailView != nil) {
            UITableViewCell *cell = (UITableViewCell*)sender;
            NSIndexPath *indexPath = [_myTableView indexPathForCell:cell];
            
            // get the string from the array based on the cell in the tabel view we clicked
            
            PostInformation *selectedString = [twitterPosts objectAtIndex:indexPath.row];
            
            detailView.currentCell = selectedString;
            
        }
    } if ([segue.identifier isEqual:@"toFriend"]) {
        
        FriendDetailsViewController* friendDetailView = segue.destinationViewController;
        if (friendDetailView != nil) {
            UICollectionViewCell *cell = (UICollectionViewCell*)sender;
            NSIndexPath *indexPath = [_myCollectionView indexPathForCell:cell];
            
            FriendInfo *selectedString = [followerInfo objectAtIndex:indexPath.row];
            
            friendDetailView.currentCell = selectedString;
        }
    }
}
//-----------------------------------------------------------------------------------------------------------------



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
