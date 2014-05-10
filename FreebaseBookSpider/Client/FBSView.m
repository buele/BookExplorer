//
//  FBSView.m
//
//  Created by Raffaele Bua on 04/05/14.

/*****************************************************************************
 The MIT License (MIT)
 
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 *****************************************************************************/

#import "FBSButton.h"
#import "FBSView.h"


@implementation FBSView
@synthesize delegate;


const double PUSH_BUTTON_WIDTH = 100;
const double PUSH_BUTTON_HEIGHT = 50;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[self getRandomColor]];
        pushButton = [[FBSButton buttonWithType:UIButtonTypeRoundedRect ]retain];
        testRequestButton = [[FBSButton buttonWithType:UIButtonTypeRoundedRect ]retain];
        [pushButton addTarget:self action:@selector(pushButtonDidPressed) forControlEvents:UIControlEventTouchUpInside];
        [testRequestButton addTarget:self action:@selector(testRequestButtonDidPressed) forControlEvents:UIControlEventTouchUpInside];
        [testRequestButton setTitle:@"orwell request" forState:UIControlStateNormal]; // TODO: remove this workaround
        [self setPortraitLayout];
		[self addSubview:pushButton];
        [self addSubview:testRequestButton];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    
    return self;
}

-(void)pushButtonDidPressed
{
	[delegate pushButtonDidPressed];
}

-(void)testRequestButtonDidPressed
{
	[delegate testRequestButtonDidPressed];
}

-(UIColor*)getRandomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}


-(void)setPortraitLayout
{
    [self setFrame:[[UIScreen mainScreen] bounds]];
    [pushButton setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width/2) - PUSH_BUTTON_WIDTH/2, ([[UIScreen mainScreen] bounds].size.height/2 - PUSH_BUTTON_HEIGHT/2), PUSH_BUTTON_WIDTH, PUSH_BUTTON_HEIGHT)];
    [testRequestButton setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width/2) - PUSH_BUTTON_WIDTH/2,
                                            ([[UIScreen mainScreen] bounds].size.height/2 - PUSH_BUTTON_HEIGHT/2 + 400),
                                            PUSH_BUTTON_WIDTH,
                                            PUSH_BUTTON_HEIGHT)]; //TODO: remove hard coded
}

- (void)dealloc {
    [testRequestButton release];
	[pushButton release];
    [super dealloc];
}

@end
