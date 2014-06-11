//
//  ViewController.h
//  RedTweet
//
//  Created by Nazir Shuqair on 6/4/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostInformation.h"
#import "FriendInfo.h"
#import <Accounts/Accounts.h>
#import "DetailsViewController.h"
#import <Social/Social.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>{
    
    ACAccount *currentAccount;
    
    // Posts array
    NSMutableArray* twitterPosts;
    
    // Friends Array
    NSMutableArray* followerInfo;
    
    // NSObjects
    PostInformation* currentCell;
    FriendInfo* currentFriend;
    
    // Timeline vs followers control
    IBOutlet UISegmentedControl* segControl;
    
    //IBOutlet UIImageView* profilePicture;
    IBOutlet UILabel* userScreenName;    
    
}

@property (nonatomic, strong) IBOutlet UITableView* myTableView;
@property (nonatomic, strong) IBOutlet UICollectionView* myCollectionView;
@property (nonatomic, weak) IBOutlet UIImageView* profilePicture;
@property (nonatomic, strong) ACAccount* currentAccount;

- (IBAction)onClick:(UIButton*)sender;

@end
