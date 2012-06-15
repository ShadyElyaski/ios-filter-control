//
//  SEFilterControl.h
//  SEFilterControl_Test
//
//  Created by Shady A. Elyaski on 6/13/12.
//  Copyright (c) 2012 mash, ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEFilterKnob.h"

@interface SEFilterControl : UIControl{

}
-(id) initWithFrame:(CGRect) frame Titles:(NSArray *) titles;
-(void) setSelectedIndex:(int)index;
-(void) setTitlesColor:(UIColor *)color;
-(void) setTitlesFont:(UIFont *)font;
-(void) setHandlerColor:(UIColor *)color;

@property(nonatomic, retain) UIColor *progressColor;
@property(nonatomic, readonly) int SelectedIndex;
@end
