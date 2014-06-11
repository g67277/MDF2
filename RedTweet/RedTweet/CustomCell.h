//
//  CustomCell.h
//  RedTweet
//
//  Created by Nazir Shuqair on 6/4/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell{
    
    IBOutlet UILabel* postText;
    IBOutlet UILabel* postTimeDate;
    
}

@property (nonatomic, weak) IBOutlet UIImageView* cellImage;

- (void) refreshCellWithInfo: (NSString*) postTxt postDate: (NSString*) postDate postImage: (UIImage*) postImage;

@end
