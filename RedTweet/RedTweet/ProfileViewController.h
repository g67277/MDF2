//
//  ProfileViewController.h
//  RedTweet
//
//  Created by Nazir Shuqair on 6/5/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProfileViewController : UIViewController{
        
    NSString* userName;
    NSString* userDisc;
    NSString* userNumOfFollowers;
    NSString* userNumOfFriends;
    UIImage* userImage;
    UIImage* userBanner;
    
    IBOutlet UILabel* userNameLabel;
    IBOutlet UILabel* userDiscLabel;
    IBOutlet UILabel* userNumOfFollowersLabel;
    IBOutlet UILabel* userNumOfFriendsLabel;
    IBOutlet UIImageView* userBannerImage;

    
}

@property (nonatomic, weak) IBOutlet UIImageView* userImageView;
@property (nonatomic, weak) IBOutlet UIView* popUpView;

@property (nonatomic, readonly) NSString* userName;



@end
