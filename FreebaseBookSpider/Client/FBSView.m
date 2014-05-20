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
#import "BESearchBox.h"


@implementation FBSView
@synthesize delegate;
@synthesize searchBox;
@synthesize searchResultTableView;

const double PUSH_BUTTON_WIDTH = 100;
const double PUSH_BUTTON_HEIGHT = 50;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        NSString* imagePath = [ [ NSBundle mainBundle] pathForResource:@"Jacques_Charles_Luftschiff_landscape_portrait" ofType:@"jpg"];
        UIImage * image = [ UIImage imageWithContentsOfFile: imagePath];
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:image];
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeigth = [[UIScreen mainScreen] bounds].size.height;

        // title
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth * 0.8f + screenWidth  * 0.1f -188, 60, 400.0f, 40.0f)];
        [title setText:@"Book Explorer"];
        UIColor * titleColor =[[UIColor alloc] initWithRed:14.0f/255.0f green:14.0f / 255.0f blue: 14.0f / 255.0f alpha:1.0f];
        [title setTextColor:titleColor];
        [title setFont:[UIFont systemFontOfSize:30]];
        [titleColor release];
        
        
        // search box
        CGFloat searchBoxWidth = screenWidth  * 0.8f;
        CGFloat searchBoxHeigth = 200.00f;
        CGFloat searchBoxX = screenWidth  * 0.1f;
        CGFloat searchBoxY = screenHeigth * 0.5f - searchBoxHeigth * 0.9f ;
        searchBox = [[BESearchBox alloc] initWithFrame:CGRectMake(searchBoxX, searchBoxY , searchBoxWidth, searchBoxHeigth)];
        [searchBox setDelegate:self];
        [self setPortraitLayout];
        [backgroundImage setFrame:[self bounds]];
        [self addSubview:backgroundImage];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self addSubview:searchBox];
        [self addSubview:title];
        [title release];
        [searchBox release];
        [backgroundImage release];

    }
    
    return self;
}

-(void)setSearchResultTableViewFrame
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect tableViewFrame = self.searchBox.frame;
    tableViewFrame.size.width = tableViewFrame.size.width -120.0f;
    tableViewFrame.size.height = screenRect.size.height -270.0f;
    tableViewFrame.origin.y = 60.0f;
    tableViewFrame.origin.x = 60.0f;
    [searchResultTableView setFrame:tableViewFrame];
}


-(void)setPortraitLayout
{
    [self setFrame:[[UIScreen mainScreen] bounds]];
    [pushButton setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width/2) - PUSH_BUTTON_WIDTH/2, ([[UIScreen mainScreen] bounds].size.height/2 +200), PUSH_BUTTON_WIDTH, PUSH_BUTTON_HEIGHT)];
    [testRequestButton setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width/2) - PUSH_BUTTON_WIDTH/2,
                                            ([[UIScreen mainScreen] bounds].size.height/2 - PUSH_BUTTON_HEIGHT/2 + 400),
                                            PUSH_BUTTON_WIDTH,
                                            PUSH_BUTTON_HEIGHT)]; 
}

-(void)searchNodesByKeyword:(NSString *)aKeyword{
    [delegate searchNodesByKeyword:aKeyword];
}

-(void)expandSearchBox
{
    CGRect newFrame = searchBox.frame;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    newFrame.size.height = screenRect.size.height -150.0f;
    newFrame.origin.y = 100.0f;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [searchBox setFrame:newFrame];
    searchBox.searchButton.alpha = 0.0f;
    searchBox.searchTextField.alpha = 0.0f;
    searchBox.backFromListViewButton.alpha = 0.6f;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(expandSearchBoxAnimationStopped:finished:context:)];
    [UIView commitAnimations];
}
-(void)expandSearchBoxAnimationStopped:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    NSLog(@"expandSearchBoxAnimationFinishe");
    [delegate searchBoxDidExpanded];
    [searchResultTableView setContentOffset:CGPointZero animated:NO];
    [searchResultTableView reloadData];
    
    [searchResultTableView setHidden:NO];
}

-(void)collapseSearchBoxAnimationStopped:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    NSLog(@"collapseSearchBoxAnimationFinished");
    [delegate searchBoxDidCollapsed];
}

-(void)collapseSearchBox
{
    [searchResultTableView setHidden:YES]; //TODO: clean it
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeigth = [[UIScreen mainScreen] bounds].size.height;
    CGFloat searchBoxWidth = screenWidth  * 0.8f;
    CGFloat searchBoxHeigth = 200.00f;
    CGFloat searchBoxX = screenWidth  * 0.1f;
    CGFloat searchBoxY = screenHeigth * 0.5f - searchBoxHeigth * 0.9f ;
    
    [searchBox.searchTextField setText:@""];
    CGRect newFrame = searchBox.frame;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    newFrame.size.height = screenRect.size.height -150.0f;
    newFrame.origin.y = 100.0f;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
     [UIView setAnimationDidStopSelector:@selector(collapseSearchBoxAnimationStopped:finished:context:)];
    [searchBox setFrame:CGRectMake(searchBoxX, searchBoxY , searchBoxWidth, searchBoxHeigth)];
    searchBox.searchButton.alpha = 1.0f;
    searchBox.searchTextField.alpha = 1.0f;
    searchBox.backFromListViewButton.alpha = 0.0f;
    
    [UIView commitAnimations];
}
- (void)dealloc {
    [delegate release];
    [searchResultTableView release];
    [testRequestButton release];
	[pushButton release];
    [searchBox release];
    [super dealloc];
}

@end
