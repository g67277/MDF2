//
//  CustomCell.m
//  RedTweet
//
//  Created by Nazir Shuqair on 6/4/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize cellImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code  
        
    }
    return self;
}

- (void) refreshCellWithInfo: (NSString*) postTxt postDate: (NSString*) postDate postImage: (UIImage*) postImage{
    
    postText.text = postTxt;
    postTimeDate.text = postDate;
    cellImage.image = postImage;
    self.cellImage.layer.cornerRadius = self.cellImage.frame.size.width / 2;
    self.cellImage.clipsToBounds = YES;
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
