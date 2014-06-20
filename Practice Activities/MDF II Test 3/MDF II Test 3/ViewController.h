//
//  ViewController.h
//  MDF II Test 3
//
//  Created by Nazir Shuqair on 6/16/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    IBOutlet UIImageView* image;
    UIPopoverController* popoverController;
    UIImagePickerController* picker;
    NSURL* pathURL;
    IBOutlet UIView* vidView;
    MPMoviePlayerViewController *moviePlayer;
}

- (IBAction)onClick:(id)sender;
- (IBAction)play:(UIButton*)sender;

@end
