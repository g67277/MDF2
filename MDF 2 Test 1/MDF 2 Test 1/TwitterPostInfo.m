//
//  TwitterPostInfo.m
//  MDF 2 Test 1
//
//  Created by Nazir Shuqair on 6/3/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "TwitterPostInfo.h"

@implementation TwitterPostInfo
@synthesize timeDate, userDescription, userScreenName, tweetText, userImage1;


- (id) initWithpostInfo: (NSString*)screenName userDesc: (NSString*)userDesc text: (NSString*)text timeDateInfo: (NSString*) timeDateInfo userImage2:(UIImage*)userImage2{
    
    if (self = [super init]) {
        userScreenName = [screenName copy];
        userDescription = [userDesc copy];
        tweetText = [text copy];
        timeDate = [timeDateInfo copy];
        userImage2 = [userImage1 copy];
    }
    return self;
    
}
@end
