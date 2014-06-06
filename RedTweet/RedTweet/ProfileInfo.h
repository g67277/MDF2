//
//  ProfileInfo.h
//  RedTweet
//
//  Created by Nazir Shuqair on 6/5/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileInfo : NSObject{
    
    NSString* userName;
    NSString* userDisc;
    NSString* userNumOfFollowers2;
    NSString* userNumOfFriends2;
    
}

@property (nonatomic, readonly) NSString* userName;
@property (nonatomic, readonly) NSString* userDisc;
@property (nonatomic, readonly) NSString* userNumOfFollowers2;
@property (nonatomic, readonly) NSString* userNumOfFriends2;

- (id) initWithProfileInfo: (NSString*)userNameString userDiscString: (NSString*)userDiscString numFollowers: (NSString*) numFollowers numFriends: (NSString *)numFriends;


@end
