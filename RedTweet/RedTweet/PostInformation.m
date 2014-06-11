//
//  PostInformation.m
//  RedTweet
//
//  Created by Nazir Shuqair on 6/4/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "PostInformation.h"

@implementation PostInformation

@synthesize timeDate, tweetText, userScreenName, userImage, userBanner;

- (id) initWithpostInfo: (NSString*)screenName text: (NSString*)text timeDateInfo: (NSString*) timeDateInfo postImage: (UIImage*) postImage postBanner: (UIImage*) postBanner{
    
    if (self = [super init]) {
        timeDate = [timeDateInfo copy];
        tweetText = [text copy];
        userScreenName = [screenName copy];
        userImage = [postImage copy];
        userBanner = [postBanner copy];
    }
    
    return self;
    
}


@end
