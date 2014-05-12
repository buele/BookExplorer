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
        NSString* imagePath = [ [ NSBundle mainBundle] pathForResource:@"Jacques_Charles_Luftschiff_landscape_portrait" ofType:@"jpg"];
        UIImage * image = [ UIImage imageWithContentsOfFile: imagePath];
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:image];
        //----//
        
        // ** title
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeigth = [[UIScreen mainScreen] bounds].size.height;
        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth * 0.8f + screenWidth  * 0.1f -188, screenHeigth * 0.5f  - 200.00f * 0.9f - 127, 400.0f, 40.0f)];
        [title setText:@"Book Explorer"];
        UIColor * titleColor =[[UIColor alloc] initWithRed:14.0f/255.0f green:14.0f / 255.0f blue: 14.0f / 255.0f alpha:1.0f];
        [title setTextColor:titleColor];
        [title setFont:[UIFont systemFontOfSize:30]];
        [titleColor release];
        
        
        // ** search box
        CGFloat searchBoxWidth = screenWidth  * 0.8f;
        CGFloat searchBoxHeigth = 200.00f;
        CGFloat searchBoxX = screenWidth  * 0.1f;
        CGFloat searchBoxY = screenHeigth * 0.5f - searchBoxHeigth * 0.9f ;
        
        UIView * searchBox = [[UIView alloc] initWithFrame:CGRectMake(searchBoxX, searchBoxY , searchBoxWidth, searchBoxHeigth)];
        UIColor * searchBoxColor = [[UIColor alloc] initWithRed:255.0f green:255.0f blue:255.0f alpha:0.5];
        [searchBox setBackgroundColor:(searchBoxColor)];
        [searchBoxColor release];
        
        // add text field
        UITextField * searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(searchBoxWidth * 0.1f, searchBoxHeigth /2 - 20, searchBoxWidth * 0.8f - 40 , 40)];
        [searchTextField setPlaceholder:@"George Orwell"];
        [searchTextField setBackgroundColor:[UIColor whiteColor]];
        [searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        // TODO: for padding subclass text field
        [searchBox addSubview:searchTextField];
        [searchTextField release];
        
        //search button
        UIButton * searchButton = [[UIButton alloc]initWithFrame:CGRectMake(searchBoxWidth * 0.1f + searchBoxWidth * 0.8f - 40,  searchBoxHeigth /2 - 20, 40.0f, 40.0f)];
        UIColor * searchButtonColor = [[UIColor alloc] initWithRed:231.0f/255.0f green:76.0f / 255.0f blue: 60.0f / 255.0f alpha:1.0f];
        [searchButton setBackgroundColor:searchButtonColor];
        [searchButtonColor release];
        [searchBox addSubview:searchButton];
        [searchButton release];
        
        
        
        //----//
        
        
        pushButton = [[FBSButton buttonWithType:UIButtonTypeRoundedRect ]retain];
        testRequestButton = [[FBSButton buttonWithType:UIButtonTypeRoundedRect ]retain];
        [pushButton addTarget:self action:@selector(pushButtonDidPressed) forControlEvents:UIControlEventTouchUpInside];
        [testRequestButton addTarget:self action:@selector(testRequestButtonDidPressed) forControlEvents:UIControlEventTouchUpInside];
        [testRequestButton setTitle:@"orwell request" forState:UIControlStateNormal]; // TODO: remove this workaround
        [self setPortraitLayout];
        [backgroundImage setFrame:[self bounds]];
        [self addSubview:backgroundImage];
		//[self addSubview:pushButton];
        //[self addSubview:testRequestButton];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        //
        [self addSubview:searchBox];
        [self addSubview:title];
        
        [title release];
        [searchBox release];
        //
        [backgroundImage release];

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


-(void)setPortraitLayout
{
    [self setFrame:[[UIScreen mainScreen] bounds]];
    [pushButton setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width/2) - PUSH_BUTTON_WIDTH/2, ([[UIScreen mainScreen] bounds].size.height/2 +200), PUSH_BUTTON_WIDTH, PUSH_BUTTON_HEIGHT)];
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
