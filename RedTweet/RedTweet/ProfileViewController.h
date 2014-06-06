//
//  ProfileViewController.h
//  RedTweet
//
//  Created by Nazir Shuqair on 6/5/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileInfo.h"

@interface ProfileViewController : UIViewController{
    
    ProfileInfo *profile;
    
}

@property (nonatomic, strong)IBOutlet UILabel* userName;
@property (nonatomic, strong)IBOutlet UILabel* userDisc;
@property (nonatomic, strong)IBOutlet UILabel* userNumOfFollowers;
@property (nonatomic, strong)IBOutlet UILabel* userNumOfFriends;


@end
