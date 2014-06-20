//
//  ViewController.m
//  CAM
//
//  Created by Nazir Shuqair on 6/18/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [self UIStyleChange:button1];
    [self UIStyleChange:button2];
    [self UIStyleChange:button3];
    [self UIStyleChange:editBtn1];
    [self UIStyleChange:editBtn2];
    [self UIStyleChange:editBtn3];
    [self UIStyleChange:cancleBtn];
    [self UIStyleChange:saveBtn];
    [self UIStyleChange:saveVidBtn];
    [self UIStyleChange:cancelVidBtn];
    
    [self dropShadow:button1 option:1];
    [self dropShadow:button2 option:1];
    [self dropShadow:button3 option:1];
    
    topView.layer.shadowColor = [[UIColor blackColor] CGColor];
    topView.layer.shadowOffset = CGSizeMake(0,2);
    topView.layer.shadowOpacity = 0.3;
    topView.layer.shadowRadius = 3.5f;
    
    bottomView.hidden = true;

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) dropShadow: (UIView*) dropShadow option: (int) option{
    
    if (option == 1) {
        dropShadow.layer.shadowColor = [[UIColor blackColor] CGColor];
        dropShadow.layer.shadowOffset = CGSizeMake(0,0);
        dropShadow.layer.shadowOpacity = 0.4;
        dropShadow.layer.shadowRadius = 3.5f;
        dropShadow.layer.masksToBounds = NO;
    }else if (option == 2){
        dropShadow.layer.shadowOpacity = 0.0f;
    }
    
}

- (IBAction)onClick:(UIButton*)sender{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = true;
    
    if (sender.tag == 0) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        UIViewController *containerController = [[UIViewController alloc] init];
        [containerController.view addSubview:picker.view];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            Class cls = NSClassFromString(@"UIPopoverController");
            if (cls != nil) {
                popoverController = [[UIPopoverController alloc] initWithContentViewController:containerController];
                
                [popoverController presentPopoverFromRect:CGRectMake(130, 650, 30, 30) inView:self.view permittedArrowDirections:4 animated:YES];
                
                [picker.view setFrame:containerController.view.frame];
            }
        }
    }else if (sender.tag == 1){
        //camera, photo, or album
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:true completion:nil];
        
    }else if (sender.tag == 2){
        //camera, photo, or album
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = @[(NSString*)kUTTypeMovie];
        [self presentViewController:picker animated:true completion:nil];
    }
    
}

- (IBAction)editingNSaving:(UIButton*)sender{
    switch (sender.tag) {
        case 0:
            [self UIStyleChange:editedImage];
            break;
        case 1:
            editedImage.layer.cornerRadius = 30;
            editedImage.layer.masksToBounds = YES;
            break;
        case 2:
            editedImage.layer.cornerRadius = 0;
            editedImage.layer.masksToBounds = YES;
            break;
        case 3:
            editedImage.image = [UIImage imageNamed:@"placeholder.jpg"];
            originalImage.image = [UIImage imageNamed:@"placeholder.jpg"];
            bottomView.hidden = true;
            topView.hidden = false;
            [self cancelAlert];
            break;
        case 4:
            UIImageWriteToSavedPhotosAlbum(originalImage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            UIImageWriteToSavedPhotosAlbum(editedImage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            [self successAlert];
            break;
        case 5:
            UISaveVideoAtPathToSavedPhotosAlbum(pathString, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            [self successAlert];
            break;
        case 6:
            [moviePlayer.view removeFromSuperview];
            bottomView.hidden = true;
            topView.hidden = false;
            [self cancelAlert];
            break;
        default:
            break;
    }
    
}

- (void) UIStyleChange: (UIView*) newView{
    newView.layer.cornerRadius = newView.frame.size.width /2;
    newView.clipsToBounds = YES;
}

- (void) cancelAlert{
    UIAlertView* alerview = [[UIAlertView alloc] initWithTitle:@"Canceled" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alerview show];
}

- (void) successAlert{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    bottomView.hidden = false;
    topView.hidden = true;

    
    if ([[info valueForKey:@"UIImagePickerControllerMediaType"]  isEqual: @"public.image"]) {
        picView.hidden = false;
        saveVidBtn.hidden = true;
        cancelVidBtn.hidden = true;
        [moviePlayer.view removeFromSuperview];
        //displaying and saving an image
        UIImage* original = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage* edited = [info valueForKey:@"UIImagePickerControllerEditedImage"];
        
        originalImage.image = original;
        editedImage.image = edited;
        editBtn1.enabled = YES;
        editBtn2.enabled = YES;
        editBtn3.enabled = YES;
        cancleBtn.enabled = YES;
        saveBtn.enabled = YES;
    }else{
        //saving video
        NSURL* pathURL = [info valueForKey:@"UIImagePickerControllerMediaURL"];
        pathString = [pathURL path];
        picView.hidden = true;
        saveVidBtn.hidden = false;
        cancelVidBtn.hidden = false;
        moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:pathURL];
        moviePlayer.view.frame = CGRectMake(250, 80, 535, 400);
        moviePlayer.moviePlayer.shouldAutoplay=NO;
        moviePlayer.moviePlayer.controlStyle = MPMediaTypeMusicVideo;
        [moviePlayer.moviePlayer setFullscreen:YES animated:YES];
        [self.view addSubview:moviePlayer.view];
        [moviePlayer.moviePlayer play];
    }
    

    [popoverController dismissPopoverAnimated:YES];
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [picker.view setFrame:picker.view.superview.frame];
}

- (void) image: (UIImage*) image didFinishSavingWithError: (NSError*) error contextInfo: (void *) contextInfo{
    
    if (error == nil) {
        
    }
    
}

- (void) video: (NSString*) video didFinishSavingWithError: (NSError*) error contextInfo: (void *) contextInfo{
    
    if (error == nil) {
       
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
