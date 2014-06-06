//
//  PostInformation.m
//  RedTweet
//
//  Created by Nazir Shuqair on 6/4/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "PostInformation.h"

@implementation PostInformation

@synthesize timeDate, tweetText, userScreenName;

- (id) initWithpostInfo: (NSString*)screenName text: (NSString*)text timeDateInfo: (NSString*) timeDateInfo{
    
    if (self = [super init]) {
        timeDate = [timeDateInfo copy];
        tweetText = [text copy];
        userScreenName = [screenName copy];
    }
    
    return self;
    
}


@end
