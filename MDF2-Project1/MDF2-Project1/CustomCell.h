//
//  CustomCell.h
//  MDF2-Project1
//
//  Created by Nazir Shuqair on 6/4/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell{
    
    IBOutlet UILabel* postText;
    IBOutlet UILabel* postTimeDate;
    
}

- (void) refreshCellWithInfo: (NSString*) postTxt postDate: (NSString*) postDate;

@end
