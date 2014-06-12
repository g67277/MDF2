//
//  FriendInfo.h
//  RedTweet
//
//  Created by Nazir Shuqair on 6/9/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendInfo : NSObject{
    
    NSString *friendScreenName;
    NSString *friendFollowerCount;
    NSString *friendStatusesCount;
    NSString *friendVerified;
    NSString *friendDescription;
    UIImage *friendProfileImage;
    UIImage *friendBannerImage;
}

@property (nonatomic, readonly) NSString *friendScreenName;
@property (nonatomic, readonly) NSString *friendFollowerCount;
@property (nonatomic, readonly) NSString *friendStatusesCount;
@property (nonatomic, readonly) NSString *friendVerified;
@property (nonatomic, readonly) NSString *friendDescription;
@property (nonatomic, readonly) UIImage *friendProfileImage;
@property (nonatomic, readonly) UIImage *friendBannerImage;


- (id) initWithpostInfo: (NSString*)screenName folCount: (NSString*) folCount statCount: (NSString*) statCount verif: (NSString*) verif pImage: (UIImage*)pImage bImage: (UIImage*) bImage friendDesc: (NSString*) friendDesc;


@end
