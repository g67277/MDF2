//
//  TwitterPostInfo.h
//  MDF 2 Test 1
//
//  Created by Nazir Shuqair on 6/3/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterPostInfo : NSObject {
    
    NSString *timeDate;
    NSString *userScreenName;
    NSString *userDescription;
    NSString *tweetText;
    UIImage *userImage1;
}

@property (nonatomic, readonly) NSString *timeDate;
@property (nonatomic, readonly) NSString *userScreenName;
@property (nonatomic, readonly) NSString *userDescription;
@property (nonatomic, readonly) NSString *tweetText;
@property (nonatomic, retain) UIImage *userImage1;


- (id) initWithpostInfo: (NSString*)screenName userDesc: (NSString*)userDesc text: (NSString*)text timeDateInfo: (NSString*) timeDateInfo userImage2:(UIImage*)userImage2;

@end
