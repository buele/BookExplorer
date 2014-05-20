//
//  BESearchBox.m
//  FreebaseBookSpider

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

#import "BESearchBox.h"

@implementation BESearchBox
@synthesize searchTextField;
@synthesize searchButton;
@synthesize delegate;

static NSString * PLACEHOLDER = @"George Orwell";
static CGFloat SEARCH_BOX_PADDING = 50.0f;
static CGFloat SEARCH_TEXT_FIELD_HEIGHT = 40.0f;
static CGFloat SEARCH_BUTTON_WIDTH = 40.0f;
static CGFloat SEARCH_BUTTON_HEIGHT = 40.0f;
static CGFloat X_BUTTON_WIDTH = 30.0f;
static CGFloat X_BUTTON_HEIGHT = 30.0f;
static CGFloat X_BUTTON_MARGIN = 10.0f;
static NSString * X_BUTTON_IMAGE_NAME = @"delete_icon";
static NSString * X_BUTTON_IMAGE_TYPE = @"png";

static NSString * SEARCH_BUTTON_IMAGE_NAME = @"search-icon";
static NSString * SEARCH_BUTTON_IMAGE_TYPE = @"png";


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[self searchBoxColor]];
        
        //text field
        searchTextField = [[UITextField alloc] initWithFrame:[self searchTextFieldFrame]];
        [searchTextField setPlaceholder:PLACEHOLDER];
        [searchTextField setBackgroundColor:[UIColor whiteColor]];
        [searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [searchTextField setDelegate:self];
        
        // search button
        searchButton = [[UIButton alloc]initWithFrame:[self searchButtonFrame]];
        [searchButton addTarget:self action:@selector(searchButtonDidPressed) forControlEvents:UIControlEventTouchUpInside];
        NSString* searchImagePath = [ [ NSBundle mainBundle] pathForResource:SEARCH_BUTTON_IMAGE_NAME ofType:SEARCH_BUTTON_IMAGE_TYPE];
        UIImage * searchButtonImage = [ UIImage imageWithContentsOfFile: searchImagePath];
        [searchButton setImage:searchButtonImage forState:UIControlStateNormal];
        
        
        // x button
        NSString * xButtonImagePath = [[NSBundle mainBundle] pathForResource:X_BUTTON_IMAGE_NAME ofType:X_BUTTON_IMAGE_TYPE];
        UIImage * xButtonImage = [[UIImage alloc] initWithContentsOfFile:xButtonImagePath];
        _backFromListViewButton = [[UIButton alloc] initWithFrame:[self xButtonFrame]];
        [_backFromListViewButton setBackgroundImage:xButtonImage forState:UIControlStateNormal];
        [_backFromListViewButton addTarget:self action:@selector(backFromListViewDidPressed) forControlEvents:UIControlEventTouchUpInside];
        [_backFromListViewButton setAlpha:0.0f];
        [xButtonImage release];
    
        [self addSubview:searchButton];
        [self addSubview:searchTextField];
        [self addSubview:_backFromListViewButton];
    }
    return self;
}

-(CGRect)xButtonFrame
{
    CGRect frame;
    frame.origin.x = self.frame.size.width - X_BUTTON_WIDTH - X_BUTTON_MARGIN;
    frame.origin.y = X_BUTTON_MARGIN;
    frame.size.width = X_BUTTON_WIDTH;
    frame.size.height = X_BUTTON_HEIGHT;
    return frame;
}

-(CGRect)searchTextFieldFrame
{
    CGRect frame;
    frame.origin.x = SEARCH_BOX_PADDING;
    frame.origin.y = self.frame.size.height / 2.0f - SEARCH_TEXT_FIELD_HEIGHT / 2.0f;
    frame.size.width = self.frame.size.width - SEARCH_BOX_PADDING * 2.0f - SEARCH_BUTTON_WIDTH;
    frame.size.height = SEARCH_TEXT_FIELD_HEIGHT;
    return frame;
}

-(CGRect)searchButtonFrame
{
    CGRect frame;
    frame.origin.x = searchTextField.frame.origin.x + searchTextField.frame.size.width ;
    frame.origin.y = searchTextField.frame.origin.y;
    frame.size.width = SEARCH_BUTTON_WIDTH;
    frame.size.height = SEARCH_BUTTON_HEIGHT;
    return frame;
}

-(UIColor *)searchBoxColor
{
    return [[[UIColor alloc] initWithRed:255.0f green:255.0f blue:255.0f alpha:0.5] autorelease];
}


#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self.searchTextField resignFirstResponder];
    if(self.searchTextField.text != nil && [self.searchTextField.text length]> 0){
        [delegate searchNodesByKeyword:self.searchTextField.text];
    }
    return NO;
}

#pragma button protocol
-(void)searchButtonDidPressed
{
    [self.searchTextField resignFirstResponder];
    if(self.searchTextField.text != nil && [self.searchTextField.text length]> 0){
        [delegate searchNodesByKeyword:self.searchTextField.text];
    }
}

-(void)backFromListViewDidPressed
{
    [delegate collapseSearchBox];
}
-(void)dealloc
{
    [_backFromListViewButton release];
    [searchTextField release];
    [searchButton release];
    [delegate release];
    [super dealloc];
}
@end
