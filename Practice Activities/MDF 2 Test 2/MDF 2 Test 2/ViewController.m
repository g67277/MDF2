//
//  ViewController.m
//  MDF 2 Test 2
//
//  Created by Nazir Shuqair on 6/8/14.
//  Copyright (c) 2014 Me Time Studios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:10];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = date;
    
    notification.timeZone = [NSTimeZone localTimeZone];
    
    notification.alertBody = @"cool";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
