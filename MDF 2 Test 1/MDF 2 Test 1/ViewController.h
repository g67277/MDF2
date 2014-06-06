//
//  ViewController.h
//  MDF 2 Test 1
//
//  Created by Nazir Shuqair on 6/2/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    IBOutlet UIView* myBox;
    IBOutlet UIImageView* testView;
    
    NSMutableArray *twitterPosts;
}

- (IBAction)onClick:(id)sender;

@end
