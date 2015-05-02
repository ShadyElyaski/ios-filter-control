//
//  SYFilterKnob.h
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

#define SEFilterKnob_DEFAULT_SHADOW              YES
#define SEFilterKnob_DEFAULT_SHADOW_COLOR        [UIColor colorWithRed:0 green:0 blue:0 alpha:.4f]
#define SEFilterKnob_DEFAULT_HANDLER_COLOR       [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1]

@interface SEFilterKnob : UIButton

@property (nonatomic, strong) UIColor *handlerColor UI_APPEARANCE_SELECTOR;    // Configure handler color
@property (nonatomic, strong) UIColor *shadowColor UI_APPEARANCE_SELECTOR;     // Configure shadow color
@property (nonatomic, assign) BOOL shadow UI_APPEARANCE_SELECTOR;              // Enable / disable shadow. Default is YES
@end
