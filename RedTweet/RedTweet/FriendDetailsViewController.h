//
//  FriendDetailsViewController.h
//  RedTweet
//
//  Created by Nazir Shuqair on 6/9/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendInfo.h"

@interface FriendDetailsViewController : UIViewController{
    
    IBOutlet UILabel* screenName;
    IBOutlet UILabel* followers;
    IBOutlet UILabel* statusCount;
    IBOutlet UILabel* description;
    IBOutlet UIImageView* banner;
}

@property (nonatomic, weak) IBOutlet UIImageView* profileImage;

@property (nonatomic, strong)FriendInfo* currentCell;


@end
