iOS Filter Control
==================

An iOS Filter UIControl Subclass. Zero Graphics. Highly Customizable.

Inspired by National Geographics: Park Guides.

# Installation

1. In your XCode Project, take the *SEFilterControl.h and .m* & *SEFilterKnob.h and .m* from ios-filter-control folder and drag them into your project. 
2. Start using this new UIControl Subclass!

# SDK Support

It supports iOS 4 to iOS 6

# Screenshot

Here's a screenshot for different variations

![My image](http://blog.elyaski.com/wp-content/uploads/2012/06/iOS-Simulator-Screen-shot-Jun-16-2012-2.38.16-AM.png)

You may watch a demo video on [Youtube](http://www.youtube.com/watch?v=-lvvLnKPUk8)

# Documentation 

The class is not very well documented. I tried documenting drawing code as much as I could.

There are sample codes that illustrate various parameters.


# Usage

## Creating your filter

Somewhere, for example in your viewDidLoad, alloc and init the filter UIControl:

    SEFilterControl *filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(10, 20, 300, 70) Titles:[NSArray arrayWithObjects:@"Articles", @"News", @"Updates", @"Featured", @"Newest", @"Oldest", nil]];

This initializes our Filter Control using CGRect and Titles Array of NSStrings.

*Note That height of the control is predifined as 70 and can't be changed*

Then, add target for Value Change Event handling:

	[filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];

Don't forget to impelment the handler we specified later:

	-(void)filterValueChanged:(SEFilterControl *) sender{
    	NSLog(@"%@", [NSString stringWithFormat:@"%d", sender.SelectedIndex]);
	}
	
Adding to your UIView & releasing the object:

	[self.view addSubview:filter];
    [filter release];

## Customizing your filter

To change the track color:

	[filter setProgressColor:[UIColor lightGrayColor]];

To change the handler color:

	[filter setHandlerColor:[UIColor darkGrayColor]];

To change the Titles text color:

	[filter setTitlesColor:[UIColor blackColor]];

To change the Titles text font:

	[filter setTitlesFont:[UIFont fontWithName:@"Didot" size:14]];


# Acknowledgment

Special thanks to mash, Ltd. team for their support.
       
License
-------

This Code is released under the MIT License by [Shady Elyaski](http://www.elyaski.com)

Would love to hear from you when you use this custom UIControl in your project!

Cheers,

Shady A. Elyaski
  
http://www.elyaski.com
