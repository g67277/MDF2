//
//  CustomCell.m
//  MDF2-Project1
//
//  Created by Nazir Shuqair on 6/4/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) refreshCellWithInfo: (NSString*) postTxt postDate: (NSString*) postDate{
    
    postText.text = postTxt;
    postTimeDate.text = postDate;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
