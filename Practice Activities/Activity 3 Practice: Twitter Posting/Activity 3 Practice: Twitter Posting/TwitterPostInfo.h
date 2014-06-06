//
//  TwitterPostInfo.h
//  Activity 3 Practice: Twitter Posting
//
//  Created by Nazir Shuqair on 6/3/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterPostInfo : NSObject{
    
    NSString *timeDate;
    NSString *userName;
    NSString *retweetCount;
    NSString *tweetText;
    NSString *statusCount;
    
}

@property (nonatomic, readonly) NSString* timeDate;
@property (nonatomic, readonly) NSString* userName;
@property (nonatomic, readonly) NSString* tweetText;
@property (nonatomic, readonly) NSString* retweetCount;
@property (nonatomic, readonly) NSString* statusCount;


- (id) initPostWithInfo: (NSString*)name text:(NSString*)text timeDateInfo:(NSString*)timeDateInfo retweets:(NSString*)retweets statusCountInt:(NSString *) statusCountInt;

@end
