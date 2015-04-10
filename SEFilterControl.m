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

#define LEFT_OFFSET                 25
#define RIGHT_OFFSET                25
#define TITLE_SELECTED_DISTANCE     5
#define TITLE_FADE_ALPHA            .5f
#define TITLE_FONT                  [UIFont fontWithName:@"Optima" size:14]
#define TITLE_SHADOW_COLOR          [UIColor lightGrayColor]
#define TITLE_COLOR                 [UIColor blackColor]

#define KNOB_HEIGHT                 55
#define KNOB_WIDTH                  35

@interface SEFilterControl ()
{
    // Cached slot width
    CGFloat oneSlotSize;

    // Hold titles count, to allows a control without labels
    NSUInteger titlesCount;

    // Dragging management
    BOOL dragging;
    CGFloat dragOffset;
}

@property (nonatomic, strong) NSArray      *labels;
@property (nonatomic, weak)   SEFilterKnob *handler;
@end

@implementation SEFilterControl
#pragma mark - Constructors
- (id)initWithFrame:(CGRect) frame titles:(NSArray *) titles{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, SEFilterControl_HEIGHT)]) {

        // Create labels
        NSMutableArray *labels = [[NSMutableArray alloc] init];

        // Create labels
        for (NSString *title in titles)
            [labels addObject:[self buildDefaultLabel:title]];

        self.labels = labels;

        // Perform common inits
        [self commonInits:titles];
    }

    return self;
}

- (id)initWithFrame:(CGRect) frame titles:(NSArray *) titles labels:(NSArray *) labels{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, SEFilterControl_HEIGHT)]) {
        // Hold labels
        self.labels = [labels copy];

        // Perfom commn inits
        [self commonInits:titles];
    }

    return self;
}

- (void)commonInits:(NSArray *)titles
{
    // Hold titles counts
    titlesCount = titles.count;

    // Precompute slot size for futur use
    [self refreshSlotSize];

    [self setBackgroundColor:[UIColor clearColor]];
    [self setProgressColor:[UIColor colorWithRed:103/255.f green:173/255.f blue:202/255.f alpha:1]];

    [self configureKnob];
    [self configureGestures];
    [self configureLabels:titles];
}

- (void)configureLabels:(NSArray *)titles
{
    NSString *title;
    UILabel *lbl;

    for (NSInteger i = 0; i < titlesCount; i++) {
        title = [titles objectAtIndex:i];
        lbl   = [_labels objectAtIndex:i];

        [lbl setFrame:CGRectMake(0, 0, oneSlotSize, 25)];
        [lbl setLineBreakMode:NSLineBreakByTruncatingMiddle];
        [lbl setAdjustsFontSizeToFitWidth:YES];
        [lbl setMinimumScaleFactor:0.4];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setShadowOffset:CGSizeMake(0, 0.5)];
        [lbl setBackgroundColor:[UIColor clearColor]];

        if (i) {
            [lbl setAlpha:TITLE_FADE_ALPHA];
        }
        
        [lbl setCenter:[self centerPointForIndex:i]];
        
        [self addSubview:lbl];
    }
}

- (void)configureKnob
{
    SEFilterKnob *handler = [SEFilterKnob buttonWithType:UIButtonTypeCustom];

    [handler setFrame:CGRectMake(LEFT_OFFSET, 10, KNOB_WIDTH, KNOB_HEIGHT)];
    [handler setAdjustsImageWhenHighlighted:NO];
    [handler setCenter:CGPointMake(handler.center.x-(CGRectGetWidth(handler.frame)/2.f), CGRectGetHeight(self.frame)-19.5f)];

    [self addSubview:handler];
    
    // Hold handler
    self.handler = handler;
}

- (void)configureGestures
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureDetected:)];
    [self addGestureRecognizer:tapGesture];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [self addGestureRecognizer:panGesture];
}

#pragma mark - Drawing code
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef shadowColor = [UIColor colorWithRed:0 green:0
                                              blue:0 alpha:.9f].CGColor;
    
    
    //Fill Main Path
    
    CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
    
    CGContextFillRect(context, CGRectMake(LEFT_OFFSET, rect.size.height - KNOB_WIDTH, rect.size.width-RIGHT_OFFSET-LEFT_OFFSET, 10));
    
    CGContextSaveGState(context);
    
    //Draw Black Top Shadow
    
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1.f), 2.f, shadowColor);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0
                                                               blue:0 alpha:.6f].CGColor);
    CGContextSetLineWidth(context, .5f);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, LEFT_OFFSET, rect.size.height - KNOB_WIDTH);
    CGContextAddLineToPoint(context, rect.size.width-RIGHT_OFFSET, rect.size.height - KNOB_WIDTH);
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
    for (NSInteger i = 0; i < titlesCount; i++) {
        centerPoint = [self centerPointForIndex:i];
        
        //Draw Selection Circles
        
        CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
        
        CGContextFillEllipseInRect(context, CGRectMake(centerPoint.x-15, rect.size.height-42.5f, 25, 25));
        
        //Draw top Gradient
        
        CGFloat colors[12] = {0, 0, 0, 1,
                              0, 0, 0, 0,
                              0, 0, 0, 0};

        CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 3);
        
        CGContextSaveGState(context);
        CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x-15, rect.size.height-42.5f, 25, 25));
        CGContextClip(context);
        CGContextDrawLinearGradient (context, gradient, CGPointMake(0, 0), CGPointMake(0,rect.size.height), 0);
        
        CGGradientRelease(gradient);
        CGColorSpaceRelease(baseSpace);
        
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
        
        CGContextAddArc(context,centerPoint.x-2.5,rect.size.height-30.5f,12.f,(i==titlesCount-1?28:-20)*M_PI/180,(i==0?-208:-160)*M_PI/180,1);
        CGContextSetLineWidth(context, 1.f);
        CGContextDrawPath(context,kCGPathStroke);
        
    }
}

#pragma mark - Animations
- (void)animateTitlesToIndex:(NSInteger)index{
    [_labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        if (idx == index) {
            [label setCenter:CGPointMake(CGRectGetMidX(label.frame), self.frame.size.height-KNOB_HEIGHT-TITLE_SELECTED_DISTANCE)];
            [label setAlpha:1];
        }else{
            [label setCenter:CGPointMake(CGRectGetMidX(label.frame), self.frame.size.height-KNOB_HEIGHT)];
            [label setAlpha:TITLE_FADE_ALPHA];
        }
        [UIView commitAnimations];
    }];
}

- (void)animateHandlerToIndex:(NSInteger) index{
    CGPoint toPoint = [self centerPointForIndex:index];
    toPoint = CGPointMake(toPoint.x-(_handler.frame.size.width/2.f), _handler.frame.origin.y);
    toPoint = [self fixFinalPoint:toPoint];
    
    [UIView beginAnimations:nil context:nil];
    [_handler setFrame:CGRectMake(toPoint.x, toPoint.y, _handler.frame.size.width, _handler.frame.size.height)];
    [UIView commitAnimations];
}

#pragma mark - UIGestureRecognizer callbacks
- (void)tapGestureDetected:(UITapGestureRecognizer *)tapGesture {
    _selectedIndex = [self selectedTitleInPoint:[tapGesture locationInView:self]];
    [self setSelectedIndex:_selectedIndex];
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)panGestureDetected:(UIPanGestureRecognizer *)panGesture {
    CGPoint point = [panGesture locationInView:self];
    if (panGesture.state == UIGestureRecognizerStateBegan)
    {
        if (CGRectContainsPoint(CGRectInset(_handler.frame, -40, -40) , point))
        {
            dragOffset = point.x - CGRectGetMinX(_handler.frame);
            dragging = YES;
            [self moveToPoint:CGPointMake(point.x - dragOffset, point.y)];
        }

        return;
    }

    // If no dragging, nothing to do
    if (!dragging)
        return;
    
    if (panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateChanged || panGesture.state == UIGestureRecognizerStateCancelled)
    {
        [self moveToPoint:CGPointMake(point.x - dragOffset, point.y)];

        if (panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled)
        {
            _selectedIndex = [self selectedTitleInPoint:_handler.center];
            [self animateHandlerToIndex:_selectedIndex];
            [self sendActionsForControlEvents:UIControlEventTouchUpInside];
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            dragging = NO;
        }
    }
}

- (void)moveToPoint:(CGPoint)point
{
    CGPoint toPoint = CGPointMake(point.x, _handler.frame.origin.y);
    
    toPoint = [self fixFinalPoint:toPoint];
    
    [_handler setFrame:CGRectMake(toPoint.x, toPoint.y, _handler.frame.size.width, _handler.frame.size.height)];
    
    NSInteger selectedIndex = [self selectedTitleInPoint:_handler.center];
    
    [self animateTitlesToIndex:selectedIndex];
    
    [self sendActionsForControlEvents:UIControlEventTouchDragInside];
}

#pragma mark - Utils
- (UILabel *)buildDefaultLabel:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];

    [label setText:title];
    [label setFont:TITLE_FONT];
    [label setShadowColor:TITLE_SHADOW_COLOR];
    [label setTextColor:TITLE_COLOR];

    return label;
}

- (void)refreshSlotSize
{
    // Compute slot size
    oneSlotSize = 1.f * (CGRectGetWidth(self.frame) - LEFT_OFFSET-RIGHT_OFFSET-1)/(titlesCount-1);
}

- (NSInteger)selectedTitleInPoint:(CGPoint)pnt {
    return round((pnt.x-LEFT_OFFSET)/oneSlotSize);
}

- (CGPoint)centerPointForIndex:(NSInteger)i {
    return CGPointMake((i/(float)(titlesCount-1)) * (CGRectGetWidth(self.frame)-RIGHT_OFFSET-LEFT_OFFSET) + LEFT_OFFSET, i==0 ? CGRectGetHeight(self.frame) - KNOB_HEIGHT - TITLE_SELECTED_DISTANCE:CGRectGetHeight(self.frame) - KNOB_HEIGHT);
}

- (CGPoint)fixFinalPoint:(CGPoint)pnt {
    if (pnt.x < LEFT_OFFSET-(_handler.frame.size.width/2.f)) {
        pnt.x = LEFT_OFFSET-(_handler.frame.size.width/2.f);
    }else if (pnt.x+(_handler.frame.size.width/2.f) > self.frame.size.width-RIGHT_OFFSET){
        pnt.x = self.frame.size.width-RIGHT_OFFSET- (_handler.frame.size.width/2.f);
    }
    return pnt;
}

#pragma mark - Setters
- (void) setSelectedIndex:(NSUInteger)index {
    _selectedIndex = index;
    [self animateTitlesToIndex:index];
    [self animateHandlerToIndex:index];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) setHandlerColor:(UIColor *)color{
    [_handler setHandlerColor:color];
}

- (void) setTitlesColor:(UIColor *)color{
    for (UILabel *label in _labels)
        [label setTextColor:color];
}

- (void) setTitlesFont:(UIFont *)font{
    for (UILabel *label in _labels)
        [label setFont:font];
}

@end