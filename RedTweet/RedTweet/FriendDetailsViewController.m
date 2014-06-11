//
//  FriendDetailsViewController.m
//  RedTweet
//
//  Created by Nazir Shuqair on 6/9/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "FriendDetailsViewController.h"

@interface FriendDetailsViewController ()

@end

@implementation FriendDetailsViewController
@synthesize profileImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    self.profileImage.clipsToBounds = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    
    screenName.text = self.currentCell.friendScreenName;
    profileImage.image = self.currentCell.friendProfileImage;
    //followers.text = self.currentCell.friendFollowerCount;
    //statusCount.text = self.currentCell.friendStatusesCount;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
