//
//  SEFilterControl.h
//  SEFilterControl_Test
//
//  Created by Shady A. Elyaski on 6/13/12.
//  Copyright (c) 2012 mash, ltd. All rights reserved.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "SEFilterKnob.h"

#define SEFilterControl_HEIGHT                              70

#define SEFilterControl_DEFAULT_TITLE_FONT                  [UIFont fontWithName:@"Optima" size:14]
#define SEFilterControl_DEFAULT_TITLE_SHADOW_COLOR          [UIColor lightGrayColor]
#define SEFilterControl_DEFAULT_TITLE_COLOR                 [UIColor blackColor]
#define SEFilterControl_DEFAULT_PROGRESS_COLOR              [UIColor colorWithRed:103/255.f green:173/255.f blue:202/255.f alpha:1]

IB_DESIGNABLE
@interface SEFilterControl : UIControl

/* Default constructor */
- (id) initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/* Constructor with preconfigured labels */
- (id) initWithFrame:(CGRect)frame titles:(NSArray *)titles labels:(NSArray *)labels;

/* Update titles data */
- (void) setTitles:(NSArray *)titles;

/* Update titles data, providing labels to use */
- (void) setTitles:(NSArray *)titles labels:(NSArray *)labels;

/* Set selected index, animated or not */
- (void) setSelectedIndex:(NSUInteger)index animated:(BOOL) animated;

@property (nonatomic, strong)           UIFont        *titlesFont UI_APPEARANCE_SELECTOR;               // Update all titles font
@property (nonatomic, strong)           UIColor       *titlesColor UI_APPEARANCE_SELECTOR;              // Update all titles color
@property (nonatomic, strong)           UIColor       *titlesShadowColor UI_APPEARANCE_SELECTOR;        // Update all titles shadow color
@property (nonatomic, strong, readonly) NSArray       *labels;                                          // All titltes array, for a per title customization
@property (nonatomic, readonly)         NSUInteger    selectedIndex;                                    // Not animated by default
@property (nonatomic, weak, readonly)   SEFilterKnob  *handler;                                         // Knob
@property (nonatomic, assign)           IBInspectable BOOL continuous;                                  // If YES, slider will send updates its times selected index is updated, without waiting for a touch Up. Default is NO
@property (nonatomic, retain)           IBInspectable UIColor *progressColor UI_APPEARANCE_SELECTOR;    // Progress color

// Old methods
/*! @abstract Use initWithFrame:titles: instead */
- (id) initWithFrame:(CGRect)frame Titles:(NSArray *) titles NS_UNAVAILABLE;

/*! @abstract Use initWithFrame:titles:labels: instead */
- (id) initWithFrame:(CGRect)frame Titles:(NSArray *) titles Labels:(NSArray *) labels NS_UNAVAILABLE;

/*! @abstract Use selectedIndex */
@property (nonatomic, readonly) NSInteger SelectedIndex NS_UNAVAILABLE;
@end
