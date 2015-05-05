//
//  SEFilterKnob.m
//  SEFilterControl_Test
//
//  Created by Shady A. Elyaski on 6/15/12.
//  Copyright (c) 2012 mash, ltd. All rights reserved.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "SEFilterKnob.h"

@implementation SEFilterKnob
static NSArray *observedValues = nil;
+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        observedValues = @[@"shadow", @"handlerColor", @"shadowColor"];
    });
}

#pragma mark - Constructors
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // Default configuration
        _shadow       = SEFilterKnob_DEFAULT_SHADOW;
        _shadowColor  = SEFilterKnob_DEFAULT_SHADOW_COLOR;
        _handlerColor = SEFilterKnob_DEFAULT_HANDLER_COLOR;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        for (NSString *keyPath in observedValues)
        {
            [self addObserver:self
                   forKeyPath:keyPath
                      options:0
                      context:nil];
        }
    }

    return self;
}

#pragma mark - Drawing code
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Save current state before applying modifications
    CGContextSaveGState(context);
    
    // Draw Main Circle
    if (_shadow)
    {
        CGColorRef shadowColor = _shadowColor.CGColor;
        CGContextSetShadowWithColor(context, CGSizeMake(0, 7), 10.f, shadowColor);
    }

    CGContextSetStrokeColorWithColor(context, _handlerColor.CGColor);
    CGContextSetLineWidth(context, 11);
    CGContextStrokeEllipseInRect(context, CGRectMake(6.5f, 6, 22, 22));
    
    CGContextRestoreGState(context);
    
    // Draw Outer Outline
    
    CGContextSaveGState(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:.5 alpha:.6f].CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextStrokeEllipseInRect(context, CGRectMake(rect.origin.x+1.5f, rect.origin.y+1.2f, 32, 32.f));
    
    CGContextRestoreGState(context);
    
    // Draw Inner Outline
    
    CGContextSaveGState(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:.5 alpha:.6f].CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextStrokeEllipseInRect(context, CGRectMake(rect.origin.x+12.5f, rect.origin.y+12, 10, 10));
    
    CGContextRestoreGState(context);
    
    
    CGFloat colors[8] = { 0, 0, 0,  0,
                          0, 0, 0, .6};

    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient    = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    
    CGContextSaveGState(context);
    CGContextAddEllipseInRect(context, CGRectMake(rect.origin.x+1.5f, rect.origin.y+1, 32, 32));
    CGContextClip(context);
    CGContextDrawLinearGradient (context, gradient, CGPointMake(0, 0), CGPointMake(0,rect.size.height), 0);
    
    // Memory
    CGGradientRelease(gradient);
    CGColorSpaceRelease(baseSpace);

    // Restore previous state
    CGContextRestoreGState(context);
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([observedValues containsObject:keyPath])
        [self setNeedsDisplay];
}

#pragma mark - Memory
- (void)dealloc
{
    // Remove bindings
    for (NSString *key in observedValues)
    {
        [self removeObserver:self
                  forKeyPath:key];
    }
}

@end
