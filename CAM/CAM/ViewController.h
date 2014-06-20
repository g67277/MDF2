//
//  ViewController.h
//  CAM
//
//  Created by Nazir Shuqair on 6/18/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    IBOutlet UIView* topView;
    IBOutlet UIView* bottomView;
    IBOutlet UIView* picView;
    IBOutlet UIButton* button1;
    IBOutlet UIButton* button2;
    IBOutlet UIButton* button3;
    IBOutlet UIButton* editBtn1;
    IBOutlet UIButton* editBtn2;
    IBOutlet UIButton* editBtn3;
    IBOutlet UIButton* cancleBtn;
    IBOutlet UIButton* saveBtn;
    IBOutlet UIButton* saveVidBtn;
    IBOutlet UIButton* cancelVidBtn;
    
    IBOutlet UIImageView* originalImage;
    IBOutlet UIImageView* editedImage;
    
    NSString* pathString;
    
    UIPopoverController* popoverController;
    UIImagePickerController* picker;
    
    MPMoviePlayerViewController *moviePlayer;
}

- (IBAction)onClick:(UIButton*)sender;
- (IBAction)editingNSaving:(UIButton*)sender;

@end
