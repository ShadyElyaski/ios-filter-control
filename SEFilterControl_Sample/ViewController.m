//
//  ViewController.m
//  SEFilterControl_Sample
//
//  Created by Shady A. Elyaski on 6/15/12.
//  Copyright (c) 2012 Shady Elyaski. All rights reserved.
//

#import "ViewController.h"
#import "SEFilterControl.h"

@interface ViewController ()
// Outlets
@property (nonatomic, weak) IBOutlet UILabel *selectedIndex;
@end

@implementation ViewController
#pragma mark - Constructor
- (id)init
{
    if (self = [super initWithNibName:@"ViewController" bundle:nil])
    {
        
    }
    
    return self;
}

#pragma mark - View management
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    SEFilterControl *filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(10, 20, 300, 70) titles:[NSArray arrayWithObjects:@"Articles", @"News", @"Updates", @"Featured", @"Newest", @"Oldest", nil]];
    [filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:filter];

    filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(30, 120, 260, 60) titles:[NSArray arrayWithObjects:@"Articles", @"Latest", @"Featured", @"Oldest", nil]];
    [filter setProgressColor:[UIColor lightGrayColor]];
    filter.handler.handlerColor = [UIColor darkGrayColor];
    [filter setTitlesColor:[UIColor blackColor]];
    [filter setTitlesFont:[UIFont fontWithName:@"Didot" size:14]];
    [filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:filter];
    
    filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(60, 220, 200, 80) titles:[NSArray arrayWithObjects:@"Articles", @"Latest", @"Featured", @"Oldest", nil]];
    [filter setProgressColor:[UIColor magentaColor]];
    filter.handler.handlerColor = [UIColor yellowColor];
    [filter setTitlesColor:[UIColor purpleColor]];
    [filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:filter];
    
    
    UILabel * labelRed = [[UILabel alloc] init];
    [labelRed setText:[NSString stringWithFormat:@"Red label"]];
    [labelRed setTextColor:[UIColor redColor]];
    
    UILabel * labelGreen = [[UILabel alloc] init];
    [labelGreen setText:[NSString stringWithFormat:@"Green label"]];
    [labelGreen setTextColor:[UIColor greenColor]];
    
    filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(60, 320, 200, 80) titles:[NSArray arrayWithObjects:@"Articles", @"Latest", nil] labels:
              [NSArray arrayWithObjects:labelRed, labelGreen, nil]];
    [filter setProgressColor:[UIColor magentaColor]];
    filter.handler.handlerColor = [UIColor yellowColor];
    [filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:filter];

    filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(60, 420, 200, 80) titles:[NSArray arrayWithObjects:@"", @"", @"", @"", nil] labels:nil];
    [filter setProgressColor:[UIColor purpleColor]];
    filter.handler.handlerColor = [UIColor yellowColor];
    [filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:filter];
}

#pragma mark - Slider events
-(void)filterValueChanged:(SEFilterControl *) sender
{
    [_selectedIndex setText:[NSString stringWithFormat:@"%ld", sender.selectedIndex]];
}

#pragma mark - Rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
