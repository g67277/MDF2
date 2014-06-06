//
//  TwitterPostInfo.m
//  Activity 3 Practice: Twitter Posting
//
//  Created by Nazir Shuqair on 6/3/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "TwitterPostInfo.h"

@implementation TwitterPostInfo
@synthesize timeDate, tweetText, retweetCount, statusCount, userName;

- (id) initPostWithInfo: (NSString*)name text:(NSString*)text timeDateInfo:(NSString*)timeDateInfo retweets:(NSString*)retweets statusCountInt:(NSString *) statusCountInt{
    
    if (self = [super init]) {
        
        timeDate = [timeDateInfo copy];
        tweetText = [text copy];
        retweetCount = [retweets copy];
        statusCount = [statusCountInt copy];
        userName = [name copy];
    }
    
    return self;
}

@end
