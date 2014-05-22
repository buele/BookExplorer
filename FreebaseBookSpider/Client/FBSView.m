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

static CGFloat TITLE_Y = 60.0f;
static CGFloat SEARCH_BOX_PADDING_RATIO = 0.1f;
static CGFloat SEARCH_BOX_WIDTH_RATIO = 0.90f;
static CGFloat SEARCH_BOX_HEIGHT = 200.0f;
static CGFloat TITLE_FONT_SIZE = 30.0f;
static CGFloat TITLE_WIDTH = 188.0f;
static CGFloat TITLE_HEIGHT  = 40.0f;
static CGFloat SUGGESTION_PADDING = 50.0f;
static NSString * TITLE_TEXT = @"Book Explorer";
static NSString * BACKGROUND_IMAGE_NAME = @"Jacques_Charles_Luftschiff_landscape_portrait";
static NSString * BACKGROUND_IMAGE_TYPE = @"jpg";
static NSString * POLICIES_TEXT = @"Powered by www.freebase.com";
static NSString * DEVELOER_TEXT = @"Developed by Raffaele Bua";
static CGFloat  POLICY_SPACER = 5.0f;
static CGFloat POLICIES_FONT_SIZE = 20.0f;
static CGFloat POLICIES_WIDTH = 280.0f;
static CGFloat POLICIES_HEIGHT  = 30.0f;
static CGFloat POLICIES_BOTTOM  = 15.0f;


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // title
        UILabel * title = [[UILabel alloc]initWithFrame:[self titleFrame]];
        [title setText:TITLE_TEXT];
        [title setTextColor:[self titleColor]];
        [title setFont:[UIFont systemFontOfSize:TITLE_FONT_SIZE]];
        
        // search box
        searchBox = [[BESearchBox alloc] initWithFrame:[self searchBoxFrame]];
        [searchBox setDelegate:self];
        [self setPortraitLayout];
        UIImageView * backgroundImageView = [[UIImageView alloc] initWithImage:[self backgroundImage]] ;
        [backgroundImageView setFrame:[self bounds]];
        [self addSubview:backgroundImageView];
        [backgroundImageView release];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self addSubview:searchBox];
        [self addSubview:title];
        [title release];
        [searchBox release];
        
        // freebase policies
        UILabel * policies = [[UILabel alloc]initWithFrame:[self policiesFrame]];
        [policies setText:POLICIES_TEXT];
        [policies setTextColor:[self titleColor]];
        [policies setFont:[UIFont systemFontOfSize:POLICIES_FONT_SIZE]];
        [self addSubview:policies];
        [policies release];
        
        // developer
        UILabel * developer = [[UILabel alloc]initWithFrame:[self developerFrame]];
        [developer setText:DEVELOER_TEXT];
        [developer setTextColor:[self titleColor]];
        [developer setFont:[UIFont systemFontOfSize:POLICIES_FONT_SIZE]];
        [self addSubview:developer];
        [developer release];
    }
    return self;
}

-(UIImage *)backgroundImage
{
    NSString* imagePath = [ [ NSBundle mainBundle] pathForResource:BACKGROUND_IMAGE_NAME ofType:BACKGROUND_IMAGE_TYPE];
    return [UIImage imageWithContentsOfFile: imagePath];
}

-(UIColor *)titleColor
{
    return [[[UIColor alloc] initWithRed:14.0f/255.0f green:14.0f / 255.0f blue: 14.0f / 255.0f alpha:1.0f] autorelease];
}

-(CGRect)policiesFrame
{
    CGRect frame;
    frame.origin.x = [self screenWidth] * SEARCH_BOX_WIDTH_RATIO + [self screenWidth] * SEARCH_BOX_PADDING_RATIO / 2.0f - POLICIES_WIDTH - POLICY_SPACER;
    frame.origin.y = [self screenHeight] - POLICIES_HEIGHT - POLICIES_BOTTOM  - [self screenWidth] * SEARCH_BOX_PADDING_RATIO / 2.0f;
    frame.size.width = POLICIES_WIDTH;
    frame.size.height = POLICIES_HEIGHT;
    return frame;
}

-(CGRect)developerFrame
{
    CGRect frame;
    frame.origin.x =  [self screenWidth] * SEARCH_BOX_PADDING_RATIO / 2.0f + POLICY_SPACER;
    frame.origin.y = [self screenHeight] - POLICIES_HEIGHT - POLICIES_BOTTOM  - [self screenWidth] * SEARCH_BOX_PADDING_RATIO / 2.0f;
    frame.size.width = POLICIES_WIDTH;
    frame.size.height = POLICIES_HEIGHT;
    return frame;
}

-(CGRect)titleFrame
{
    CGRect frame;
    frame.origin.x = [self screenWidth] * SEARCH_BOX_WIDTH_RATIO + [self screenWidth] * SEARCH_BOX_PADDING_RATIO / 2.0f - TITLE_WIDTH;
    frame.origin.y = TITLE_Y;
    frame.size.width = TITLE_WIDTH;
    frame.size.height = TITLE_HEIGHT;
    return frame;
}

-(CGRect)searchBoxFrame
{
    CGRect frame;
    frame.origin.x = [self screenWidth] * SEARCH_BOX_PADDING_RATIO / 2.0f;
    frame.origin.y = [self screenHeight] / 2.0f - SEARCH_BOX_HEIGHT ;
    frame.size.width = [self screenWidth] * SEARCH_BOX_WIDTH_RATIO;
    frame.size.height = SEARCH_BOX_HEIGHT;
    return frame;
}

-(CGFloat)searchBoxPadding
{
    return [self screenWidth] * SEARCH_BOX_PADDING_RATIO;
}

-(CGFloat)screenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

-(CGFloat)screenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

-(void)setSearchResultTableViewFrame
{
    CGRect frame;
    frame.origin.x = [self screenWidth] * SEARCH_BOX_PADDING_RATIO / 2.0f + SUGGESTION_PADDING;
    frame.origin.y = TITLE_Y +  TITLE_HEIGHT + SUGGESTION_PADDING;
    frame.size.width = [self screenWidth] * SEARCH_BOX_WIDTH_RATIO - SUGGESTION_PADDING * 2.0f;
    frame.size.height = [self screenHeight] - TITLE_Y - TITLE_HEIGHT - SUGGESTION_PADDING * 3.0f;
    [searchResultTableView setFrame:frame];
}

-(void)expandSearchBox
{
    static CGFloat animationDuration = 1.0f;
    static CGFloat searchButtonAlpha = 0.0f;
    static CGFloat searchTextFieldAlpha = 0.0f;
    static CGFloat backFromListViewButtonAlpha = 0.6f;
    
    CGRect frame = [self searchBoxFrame];
    frame.size.height = [self screenHeight] - TITLE_Y - TITLE_HEIGHT - SUGGESTION_PADDING;
    frame.origin.y = TITLE_Y + TITLE_HEIGHT;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [searchBox setFrame:frame];
    searchBox.searchButton.alpha = searchButtonAlpha;
    searchBox.searchTextField.alpha = searchTextFieldAlpha;
    searchBox.backFromListViewButton.alpha = backFromListViewButtonAlpha;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(expandSearchBoxAnimationStopped:finished:context:)];
    [UIView commitAnimations];
}

-(void)collapseSearchBox
{
    static CGFloat animationDuration = 1.0f;
    static CGFloat searchButtonAlpha = 1.0f;
    static CGFloat searchTextFieldAlpha = 1.0f;
    static CGFloat backFromListViewButtonAlpha = 0.0f;
    
    [searchResultTableView setHidden:YES];
    [searchBox.searchTextField setText:@""];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDidStopSelector:@selector(collapseSearchBoxAnimationStopped:finished:context:)];
    [searchBox setFrame:[self searchBoxFrame]];
    searchBox.searchButton.alpha = searchButtonAlpha;
    searchBox.searchTextField.alpha = searchTextFieldAlpha;
    searchBox.backFromListViewButton.alpha = backFromListViewButtonAlpha;
    [UIView commitAnimations];
}

-(void)setPortraitLayout
{
    [self setFrame:[[UIScreen mainScreen] bounds]];
}

-(void)searchNodesByKeyword:(NSString *)aKeyword{
    [delegate searchNodesByKeyword:aKeyword];
}


-(void)expandSearchBoxAnimationStopped:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [delegate searchBoxDidExpanded];
    [searchResultTableView setContentOffset:CGPointZero animated:NO];
    [searchResultTableView reloadData];
    [searchResultTableView setHidden:NO];
}

-(void)collapseSearchBoxAnimationStopped:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [delegate searchBoxDidCollapsed];
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
