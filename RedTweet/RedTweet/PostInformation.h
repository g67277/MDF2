//
//  PostInformation.h
//  RedTweet
//
//  Created by Nazir Shuqair on 6/4/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PostInformation : NSObject{
    
    NSString *timeDate;
    NSString *userScreenName;
    NSString *tweetText;
}

@property (nonatomic, readonly) NSString *timeDate;
@property (nonatomic, readonly) NSString *userScreenName;
@property (nonatomic, readonly) NSString *tweetText;

- (id) initWithpostInfo: (NSString*)screenName text: (NSString*)text timeDateInfo: (NSString*) timeDateInfo;

@end
