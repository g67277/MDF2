//
//  DetailsViewController.h
//  MDF2-Project1
//
//  Created by Nazir Shuqair on 6/4/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "PostInformation.h"

@interface DetailsViewController : UIViewController{
    
    IBOutlet UILabel* screenName;
    IBOutlet UILabel* dateNTime;
    IBOutlet UILabel* tweetPost;
}

@property (nonatomic, strong)PostInformation* currentCell;


@end
