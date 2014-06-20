//
//  ViewController.h
//  Activity: Practice Photo Picker
//
//  Created by Nazir Shuqair on 6/16/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    IBOutlet UIImageView* image;
    
}

- (IBAction)onClick:(id)sender;

@end
