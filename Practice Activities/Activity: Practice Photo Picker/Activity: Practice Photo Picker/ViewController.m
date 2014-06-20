//
//  ViewController.m
//  Activity: Practice Photo Picker
//
//  Created by Nazir Shuqair on 6/16/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onClick:(id)sender{
    
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    picker.allowsEditing = true;
    
    [self presentViewController:picker animated:true completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage* picture = [info valueForKey:@"UIImagePickerControllerEditedImage"];
    
    image.image = picture;
    
    [picker dismissViewControllerAnimated:true completion:nil];
    
    UIImageWriteToSavedPhotosAlbum(picture, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void) image: (UIImage*) image didFinishSavingWithError: (NSError*) error contextInfo: (void *) contextInfo{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
