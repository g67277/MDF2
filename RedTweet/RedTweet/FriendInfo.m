//
//  FriendInfo.m
//  RedTweet
//
//  Created by Nazir Shuqair on 6/9/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "FriendInfo.h"

@implementation FriendInfo
@synthesize friendProfileImage, friendScreenName, friendBannerImage, friendFollowerCount, friendStatusesCount, friendVerified;

- (id) initWithpostInfo: (NSString*)screenName folCount: (NSString*) folCount statCount: (NSString*) statCount verif: (NSString*) verif pImage: (UIImage*)pImage bImage: (UIImage*) bImage{
    
    if (self = [super init]) {
        
        friendScreenName = [screenName copy];
        friendFollowerCount = [folCount copy];
        friendStatusesCount = [statCount copy];
        friendVerified = [verif copy];
        friendProfileImage = [pImage copy];
        friendBannerImage = [bImage copy];

    }
    
    return self;
}

@end
