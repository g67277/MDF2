//
//  ViewController.m
//  MDF II Test 3
//
//  Created by Nazir Shuqair on 6/16/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)onClick:(UIButton*)sender{
    
    if (sender.tag == 0) {
        picker = [[UIImagePickerController alloc] init];
        //camera, photo, or album
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = @[(NSString*)kUTTypeMovie];
        
        UIViewController *containerController = [[UIViewController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = true;
        
        [containerController.view addSubview:picker.view];
        /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         Class cls = NSClassFromString(@"UIPopoverController");
         if (cls != nil) {
         popoverController = [[UIPopoverController alloc] initWithContentViewController:containerController];
         
         [popoverController presentPopoverFromRect:CGRectMake(20, 500, 30, 30) inView:self.view permittedArrowDirections:4 animated:YES];
         
         
         [picker.view setFrame:containerController.view.frame];
         }
         }*/
        
        
        [self presentViewController:picker animated:true completion:nil];
    }
    
    
}
- (IBAction)play: (UIButton*)sender{
    
    if (sender.tag == 1) {
        moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:pathURL];
        moviePlayer.view.frame = CGRectMake(0, 0, 600, 350);
        moviePlayer.moviePlayer.shouldAutoplay=NO;
        moviePlayer.moviePlayer.controlStyle = MPMediaTypeMusicVideo;
        [moviePlayer.moviePlayer setFullscreen:YES animated:YES];
        [self.view addSubview:moviePlayer.view];
        [moviePlayer.moviePlayer play];
    }else if (sender.tag == 2){
        [moviePlayer.view removeFromSuperview];
    }
    
    
    
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    //displaying and saving an image
    //UIImage* test1 = [info valueForKey:@"UIImagePickerControllerEditedImage"];
    
    //image.image = test1;
    
    //[popoverController dismissPopoverAnimated:YES];
    
    //NSLog(@"info: %@", info);
    
    //UIImageWriteToSavedPhotosAlbum(test1, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    //saving video
    pathURL = [info valueForKey:@"UIImagePickerControllerMediaURL"];
    NSString* pathString = [pathURL path];
    UISaveVideoAtPathToSavedPhotosAlbum(pathString, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    [picker dismissViewControllerAnimated:true completion:nil];
    NSLog(@"info: %@", info);
    


    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [picker.view setFrame:picker.view.superview.frame];
}

- (void) image: (UIImage*) image didFinishSavingWithError: (NSError*) error contextInfo: (void *) contextInfo{
    
    
    
}

- (void) video: (NSString*) video didFinishSavingWithError: (NSError*) error contextInfo: (void *) contextInfo{
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
