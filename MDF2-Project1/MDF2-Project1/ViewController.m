//
//  ViewController.m
//  MDF2-Project1
//
//  Created by Nazir Shuqair on 6/3/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "PostInformation.h"
#import "CustomCell.h"
#import "DetailsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    
    [self refreshTwitter];
    [_myTableView reloadData];

    //initializing array
    twitterPosts = [[NSMutableArray alloc]init];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//------------------------------------ Twitter Refresh Method -----------------------------------------------------

- (void) refreshTwitter {
    
    // Loading alert view
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
                                
                                // loops through all posts
                                for (NSInteger i = 0; i < [twitterFeed count]; i++) {
                                    
                                    //creates a dictionary for each post
                                    PostInformation *postInfo = [self createPostInfoFromDictionary: [twitterFeed objectAtIndex:i]];
                                    
                                    if (postInfo != nil) {
                                        
                                        //adds the post to the array
                                        [twitterPosts addObject:postInfo];
                                    }
                                }
                                //reloads data to populate tableview (must be a better way to do this**)
                                [_myTableView reloadData];
                                //Only calling first post
                                //NSDictionary *firstPost = [twitterFeed objectAtIndex:0];
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
}
//-----------------------------------------------------------------------------------------------------------------


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
        [slComposeViewController setInitialText:@"Posted from #DarkTweety"];
        
        //Set image in post
        //[slComposeViewController addImage:[UIImage imageNamed:@""]];
        
        //preset the twitter default box on screen
        [self presentViewController:slComposeViewController animated:false completion:nil];
    }
    
    
}
//-----------------------------------------------------------------------------------------------------------------


//------------------------------------- Creating Post Info From Dictionary ------------------------------------------

- (PostInformation*) createPostInfoFromDictionary: (NSDictionary*) postDictionary{
    
    // pull the data from dictionaries
    NSString* timeDateString = [postDictionary valueForKey:@"created_at"];
    NSDictionary* userDictionary = [postDictionary valueForKey:@"user"];
    NSString* userString = [userDictionary valueForKey:@"screen_name"];
    NSString* tweetTextString = [postDictionary valueForKey:@"text"];
    //NSString* userImageString = [userDictionary valueForKey:@"profile_image_url"];
    //UIImage* userImage3 = [UIImage imageNamed:userImageString];
    
    //create the object and send in the data using the method
    PostInformation *postInfo = [[PostInformation alloc]initWithpostInfo:userString text:tweetTextString timeDateInfo:timeDateString];
    
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
    [cell refreshCellWithInfo:currentCell.tweetText postDate:currentCell.timeDate];
    
    return cell;
}

#pragma mark segue
//------------------------------------- Segue methode -------------------------------------------------------------

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DetailsViewController* detailView = segue.destinationViewController;
    if (detailView != nil) {
        UITableViewCell *cell = (UITableViewCell*)sender;
        NSIndexPath *indexPath = [_myTableView indexPathForCell:cell];
        
        // get the string from the array based on the cell in the tabel view we clicked
        
        PostInformation *selectedString = [twitterPosts objectAtIndex:indexPath.row];
        
        detailView.currentCell = selectedString;
    }
    
    
}
//-----------------------------------------------------------------------------------------------------------------




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
