//
//  Sample4ViewController.m
//  SEFilterControl_Sample
//
//  Created by Nicolas Goutaland on 02/05/15.
//  Copyright (c) 2015 Shady Elyaski. All rights reserved.
//
//  This sample demonstrates how to update labels at runtime

#import "Sample4ViewController.h"

#define DATA_ARRAY              @[@"Articles", @"News", @"Updates", @"Featured", @"Newest", @"Oldest"]

@interface Sample4ViewController ()
// Outlets
@property (nonatomic, weak) IBOutlet UILabel         *filterLabel;
@property (nonatomic, weak) IBOutlet SEFilterControl *filterControl;
@end

@implementation Sample4ViewController
#pragma mark - Constructor
- (id)init
{
    if (self = [super initWithNibName:@"Sample4ViewController" bundle:nil])
    {
        
    }
    
    return self;
}

#pragma mark - View management
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set initial data
    [_filterControl setTitles:DATA_ARRAY];
}

#pragma mark - UI Actions
- (IBAction)filterValueChanged:(SEFilterControl *)sender
{
    [_filterLabel setText:[NSString stringWithFormat:@"Selected index : %ld", sender.selectedIndex]];
}

- (IBAction)refreshData
{
     NSMutableArray *titles = [DATA_ARRAY mutableCopy];
 
     // Generate a new array
     NSInteger count = arc4random_uniform((int)titles.count - 2);
     for (NSInteger i=0; i<count; i++)
         [titles removeObjectAtIndex:arc4random_uniform((int)titles.count)];

     [_filterControl setTitles:titles];
}

@end
