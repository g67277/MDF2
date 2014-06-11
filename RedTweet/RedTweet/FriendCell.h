//
//  FriendCell.h
//  RedTweet
//
//  Created by Nazir Shuqair on 6/9/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UICollectionViewCell{
    
    IBOutlet UILabel* screenName;
    //IBOutlet UIImageView* friendImage;
}

@property (nonatomic, weak) IBOutlet UIImageView* friendImage;

- (void) refreshCellWithInfo: (NSString*) sName fImage: (UIImage*) fImage;


@end
