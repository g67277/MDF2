//
//  ViewController.h
//  MDF2-Project1
//
//  Created by Nazir Shuqair on 6/3/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostInformation.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    //IBOutlet UITableView* myTableView;
    
    NSMutableArray* twitterPosts;
    
    PostInformation* currentCell;
}

@property (nonatomic, strong) IBOutlet UITableView* myTableView;

- (IBAction)onClick:(UIButton*)sender;


@end
