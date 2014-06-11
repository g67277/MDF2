//
//  FriendCell.m
//  RedTweet
//
//  Created by Nazir Shuqair on 6/9/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell
@synthesize friendImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void) refreshCellWithInfo: (NSString*) sName fImage: (UIImage*) fImage{
    
    
    screenName.text = sName;
    friendImage.image = fImage;
    // circule image
    self.friendImage.layer.cornerRadius = self.friendImage.frame.size.width / 2;
    self.friendImage.clipsToBounds = YES;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
