//
//  ProfileInfo.m
//  RedTweet
//
//  Created by Nazir Shuqair on 6/5/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "ProfileInfo.h"
#import "ProfileViewController.h"

@implementation ProfileInfo
@synthesize userName, userDisc, userNumOfFollowers2, userNumOfFriends2;

- (id) initWithProfileInfo: (NSString*)userNameString userDiscString: (NSString*)userDiscString numFollowers: (NSString*) numFollowers numFriends: (NSString *)numFriends{
    
    if (self = [super init]) {
        
        userName = [userNameString copy];
        userDisc = [userDiscString copy];
        userNumOfFollowers2 = [numFollowers copy];
        userNumOfFriends2 = [numFriends copy];
        
    }
    
    return self;
    
}




@end
