//
//  SEFilterControl.m
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

#import "SEFilterControl.h"

#define LEFT_OFFSET 25
#define RIGHT_OFFSET 25
#define TITLE_SELECTED_DISTANCE 5
#define TITLE_FADE_ALPHA .5f
#define TITLE_FONT [UIFont fontWithName:@"Optima" size:14]
#define TITLE_SHADOW_COLOR [UIColor lightGrayColor]
#define TITLE_COLOR [UIColor blackColor]

@interface SEFilterControl (){
    SEFilterKnob *handler;
    CGPoint diffPoint;
    NSArray *titlesArr;
    float oneSlotSize;
}

@end

@implementation SEFilterControl
@synthesize SelectedIndex, progressColor;

-(CGPoint)getCenterPointForIndex:(int) i{
    return CGPointMake((i/(float)(titlesArr.count-1)) * (self.frame.size.width-RIGHT_OFFSET-LEFT_OFFSET) + LEFT_OFFSET, i==0?self.frame.size.height-55-TITLE_SELECTED_DISTANCE:self.frame.size.height-55);
}

-(CGPoint)fixFinalPoint:(CGPoint)pnt{
    if (pnt.x < LEFT_OFFSET-(handler.frame.size.width/2.f)) {
        pnt.x = LEFT_OFFSET-(handler.frame.size.width/2.f);
    }else if (pnt.x+(handler.frame.size.width/2.f) > self.frame.size.width-RIGHT_OFFSET){
        pnt.x = self.frame.size.width-RIGHT_OFFSET- (handler.frame.size.width/2.f);
    }
    return pnt;
}

-(id) initWithFrame:(CGRect) frame Titles:(NSArray *) titles{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 70)]) {
        [self setBackgroundColor:[UIColor clearColor]];
        titlesArr = [[NSArray alloc] initWithArray:titles];
        
        [self setProgressColor:[UIColor colorWithRed:103/255.f green:173/255.f blue:202/255.f alpha:1]];
        
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ItemSelected:)];
        [self addGestureRecognizer:gest];
        [gest release];
        
        handler = [[SEFilterKnob buttonWithType:UIButtonTypeCustom] retain];
        [handler setFrame:CGRectMake(LEFT_OFFSET, 10, 35, 55)];
        [handler setAdjustsImageWhenHighlighted:NO];
        [handler setCenter:CGPointMake(handler.center.x-(handler.frame.size.width/2.f), self.frame.size.height-19.5f)];
        [handler addTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
        [handler addTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        [handler addTarget:self action:@selector(TouchMove:withEvent:) forControlEvents: UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
        [self addSubview:handler];
        
        int i;
        NSString *title;
        UILabel *lbl;
        
        oneSlotSize = 1.f*(self.frame.size.width-LEFT_OFFSET-RIGHT_OFFSET-1)/(titlesArr.count-1);
        for (i = 0; i < titlesArr.count; i++) {
            title = [titlesArr objectAtIndex:i];
            lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, oneSlotSize, 25)];
            [lbl setText:title];
            [lbl setFont:TITLE_FONT];
            [lbl setShadowColor:TITLE_SHADOW_COLOR];
            [lbl setTextColor:TITLE_COLOR];
            [lbl setLineBreakMode:UILineBreakModeMiddleTruncation];
            [lbl setAdjustsFontSizeToFitWidth:YES];
            [lbl setMinimumFontSize:8];
            [lbl setTextAlignment:UITextAlignmentCenter];
            [lbl setShadowOffset:CGSizeMake(0, 1)];
            [lbl setBackgroundColor:[UIColor clearColor]];
            [lbl setTag:i+50];
            
            if (i) {
                [lbl setAlpha:TITLE_FADE_ALPHA];
            }
            
            [lbl setCenter:[self getCenterPointForIndex:i]];
            
            
            [self addSubview:lbl];
            [lbl release];
        }
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef shadowColor = [UIColor colorWithRed:0 green:0 
                                              blue:0 alpha:.9f].CGColor;
    
    
    //Fill Main Path
    
    CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
    
    CGContextFillRect(context, CGRectMake(LEFT_OFFSET, rect.size.height-35, rect.size.width-RIGHT_OFFSET-LEFT_OFFSET, 10));
    
    CGContextSaveGState(context);
    
    //Draw Black Top Shadow
    
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1.f), 2.f, shadowColor);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0 
                                                               blue:0 alpha:.6f].CGColor);
    CGContextSetLineWidth(context, .5f);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, LEFT_OFFSET, rect.size.height-35);
    CGContextAddLineToPoint(context, rect.size.width-RIGHT_OFFSET, rect.size.height-35);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    
    //Draw White Bottom Shadow
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1 green:1
                                                               blue:1 alpha:1.f].CGColor);
    CGContextSetLineWidth(context, .4f);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, LEFT_OFFSET, rect.size.height-25);
    CGContextAddLineToPoint(context, rect.size.width-RIGHT_OFFSET, rect.size.height-25);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
    
    CGPoint centerPoint;
    int i;
    for (i = 0; i < titlesArr.count; i++) {
        centerPoint = [self getCenterPointForIndex:i];
        
        //Draw Selection Circles
        
        CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
        
        CGContextFillEllipseInRect(context, CGRectMake(centerPoint.x-15, rect.size.height-42.5f, 25, 25));
        
        //Draw top Gradient
        
        CGFloat colors[12] =   {0, 0, 0, 1,
                                0, 0, 0, 0,
                                0, 0, 0, 0};
        CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 3);
        
        CGContextSaveGState(context);
        CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x-15, rect.size.height-42.5f, 25, 25));
        CGContextClip(context);
        CGContextDrawLinearGradient (context, gradient, CGPointMake(0, 0), CGPointMake(0,rect.size.height), 0);
        CGContextRestoreGState(context);
        
        //Draw White Bottom Shadow
        
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1 green:1
                                                                   blue:1 alpha:.4f].CGColor);
        CGContextSetLineWidth(context, .8f);
        CGContextAddArc(context,centerPoint.x-2.5,rect.size.height-30.5f,12.5f,24*M_PI/180,156*M_PI/180,0);
        CGContextDrawPath(context,kCGPathStroke);
        
        //Draw Black Top Shadow
        
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0
                                                                   blue:0 alpha:.2f].CGColor);
        
        CGContextAddArc(context,centerPoint.x-2.5,rect.size.height-30.5f,12.f,(i==titlesArr.count-1?28:-20)*M_PI/180,(i==0?-208:-160)*M_PI/180,1);
        CGContextSetLineWidth(context, 1.f);
        CGContextDrawPath(context,kCGPathStroke);
        
    }
}

-(void) setHandlerColor:(UIColor *)color{
    [handler setHandlerColor:color];
}

- (void) TouchDown: (UIButton *) btn withEvent: (UIEvent *) ev{
    CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];
    diffPoint = CGPointMake(currPoint.x - btn.frame.origin.x, currPoint.y - btn.frame.origin.y);
    [self sendActionsForControlEvents:UIControlEventTouchDown];
}

-(void) setTitlesColor:(UIColor *)color{
    int i;
    UILabel *lbl;
    for (i = 0; i < titlesArr.count; i++) {
        lbl = (UILabel *)[self viewWithTag:i+50];
        [lbl setTextColor:color];
    }
}

-(void) setTitlesFont:(UIFont *)font{
    int i;
    UILabel *lbl;
    for (i = 0; i < titlesArr.count; i++) {
        lbl = (UILabel *)[self viewWithTag:i+50];
        [lbl setFont:font];
    }
}

-(void) animateTitlesToIndex:(int) index{
    int i;
    UILabel *lbl;
    for (i = 0; i < titlesArr.count; i++) {
        lbl = (UILabel *)[self viewWithTag:i+50];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        if (i == index) {
            [lbl setCenter:CGPointMake(lbl.center.x, self.frame.size.height-55-TITLE_SELECTED_DISTANCE)];
            [lbl setAlpha:1];
        }else{
            [lbl setCenter:CGPointMake(lbl.center.x, self.frame.size.height-55)];
            [lbl setAlpha:TITLE_FADE_ALPHA];
        }
        [UIView commitAnimations];
    }
}

-(void) animateHandlerToIndex:(int) index{
    CGPoint toPoint = [self getCenterPointForIndex:index];
    toPoint = CGPointMake(toPoint.x-(handler.frame.size.width/2.f), handler.frame.origin.y);
    toPoint = [self fixFinalPoint:toPoint];
    
    [UIView beginAnimations:nil context:nil];
    [handler setFrame:CGRectMake(toPoint.x, toPoint.y, handler.frame.size.width, handler.frame.size.height)];
    [UIView commitAnimations];
}

-(void) setSelectedIndex:(int)index{
    SelectedIndex = index;
    [self animateTitlesToIndex:index];
    [self animateHandlerToIndex:index];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(int)getSelectedTitleInPoint:(CGPoint)pnt{
    return round((pnt.x-LEFT_OFFSET)/oneSlotSize);
}

-(void) ItemSelected: (UITapGestureRecognizer *) tap {
    SelectedIndex = [self getSelectedTitleInPoint:[tap locationInView:self]];
    [self setSelectedIndex:SelectedIndex];
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void) TouchUp: (UIButton*) btn{
    
    SelectedIndex = [self getSelectedTitleInPoint:btn.center];
    [self animateHandlerToIndex:SelectedIndex];
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) TouchMove: (UIButton *) btn withEvent: (UIEvent *) ev {
    CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];
    
    CGPoint toPoint = CGPointMake(currPoint.x-diffPoint.x, handler.frame.origin.y);
    
    toPoint = [self fixFinalPoint:toPoint];
    
    [handler setFrame:CGRectMake(toPoint.x, toPoint.y, handler.frame.size.width, handler.frame.size.height)];
    
    int selected = [self getSelectedTitleInPoint:btn.center];
    
    [self animateTitlesToIndex:selected];
    
    [self sendActionsForControlEvents:UIControlEventTouchDragInside];
}

-(void)dealloc{
    [handler removeTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
    [handler removeTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [handler removeTarget:self action:@selector(TouchMove:withEvent: ) forControlEvents: UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
    [handler release];
    [titlesArr release];
    [progressColor release];
    [super dealloc];
}

@end