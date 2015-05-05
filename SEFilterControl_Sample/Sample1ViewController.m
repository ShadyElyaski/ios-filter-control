//
//  Sample1ViewController.m
//  SEFilterControl_Sample
//
//  Created by Nicolas Goutaland on 02/05/15.
//  Copyright (c) 2015 Shady Elyaski. All rights reserved.
//
//  This sample demonstrates how to create filters by code

#import "Sample1ViewController.h"

@interface Sample1ViewController ()
// Outlets
@property (nonatomic, weak) IBOutlet UILabel *captionLabel;
@end

@implementation Sample1ViewController
#pragma mark - Constructor
- (id)init
{
    if (self = [super initWithNibName:@"Sample1ViewController" bundle:nil])
    {
        
    }
    
    return self;
}

#pragma mark - View management
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Simple filter
    SEFilterControl *filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(10, 80, 300, 70) titles:[NSArray arrayWithObjects:@"Articles", @"News", @"Updates", @"Featured", @"Newest", @"Oldest", nil]];
    [self.view addSubview:filter];
    
    // Simple filter, updating knob color, titles color, titles font
    filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(filter.frame) + 20, 260, 60) titles:[NSArray arrayWithObjects:@"Articles", @"Latest", @"Featured", @"Oldest", nil]];
    [filter setProgressColor:[UIColor lightGrayColor]];
    filter.handler.handlerColor = [UIColor darkGrayColor];
    [filter setTitlesColor:[UIColor blackColor]];
    [filter setTitlesFont:[UIFont fontWithName:@"Didot" size:14]];
    [self.view addSubview:filter];
    
    filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(filter.frame) + 20, 200, 80) titles:[NSArray arrayWithObjects:@"Articles", @"Latest", @"Featured", @"Oldest", nil]];
    [filter setProgressColor:[UIColor magentaColor]];
    filter.handler.handlerColor = [UIColor yellowColor];
    [filter setTitlesColor:[UIColor purpleColor]];
    [self.view addSubview:filter];
    
    // Filter with custom labels
    UILabel * labelRed = [[UILabel alloc] init];
    [labelRed setText:[NSString stringWithFormat:@"Red label"]];
    [labelRed setTextColor:[UIColor redColor]];
    
    UILabel * labelGreen = [[UILabel alloc] init];
    [labelGreen setText:[NSString stringWithFormat:@"Green label"]];
    [labelGreen setTextColor:[UIColor greenColor]];

    filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(filter.frame) + 20, 200, 80) titles:[NSArray arrayWithObjects:@"Articles", @"Latest", nil] labels:
              [NSArray arrayWithObjects:labelRed, labelGreen, nil]];
    [filter setProgressColor:[UIColor magentaColor]];
    filter.handler.handlerColor = [UIColor yellowColor];
    [self.view addSubview:filter];

    // Filter without labels
    filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(filter.frame) + 20, 200, 80) titles:[NSArray arrayWithObjects:@"", @"", @"", @"", nil]];
    [filter setProgressColor:[UIColor purpleColor]];
    filter.handler.handlerColor = [UIColor yellowColor];
    [self.view addSubview:filter];
}

@end
