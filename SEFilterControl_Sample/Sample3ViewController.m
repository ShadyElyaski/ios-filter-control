//
//  Sample3ViewController.m
//  SEFilterControl_Sample
//
//  Created by Nicolas Goutaland on 02/05/15.
//  Copyright (c) 2015 Shady Elyaski. All rights reserved.
//
//  This sample demonstrates how to get notified by value change and the use of continuous property

#import "Sample3ViewController.h"

@interface Sample3ViewController ()
// Outlets
@property (nonatomic, weak) IBOutlet SEFilterControl *firstFilterControl;
@property (nonatomic, weak) IBOutlet SEFilterControl *secondFilterControl;
@property (nonatomic, weak) IBOutlet SEFilterControl *thirdFilterControl;

@property (nonatomic, weak) IBOutlet UILabel *firstFilterLabel;
@property (nonatomic, weak) IBOutlet UILabel *secondFilterLabel;
@property (nonatomic, weak) IBOutlet UILabel *thirdFilterLabel;
@end

@implementation Sample3ViewController
#pragma mark - Constructor
- (id)init
{
    if (self = [super initWithNibName:@"Sample3ViewController" bundle:nil])
    {
        
    }
    
    return self;
}

#pragma mark - View management
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create a filter by code
    SEFilterControl *filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(10, 80, 300, 70) titles:[NSArray arrayWithObjects:@"Articles", @"News", @"Updates", @"Featured", @"Newest", @"Oldest", nil]];
    [filter addTarget:self action:@selector(firstFilterValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:filter];

    // Hold filter
    _firstFilterControl = filter;
}

#pragma mark - Slider events
- (IBAction)firstFilterValueChanged:(SEFilterControl *) sender
{
    [_firstFilterLabel setText:[NSString stringWithFormat:@"Selected index : %ld", sender.selectedIndex]];
}

- (IBAction)secondFilterValueChanged:(SEFilterControl *) sender
{
    [_secondFilterLabel setText:[NSString stringWithFormat:@"Selected index : %ld", sender.selectedIndex]];
}

- (IBAction)thirdFilterValueChanged:(SEFilterControl *) sender
{
    [_thirdFilterLabel setText:[NSString stringWithFormat:@"Selected index continuous : %ld", sender.selectedIndex]];
}

@end
