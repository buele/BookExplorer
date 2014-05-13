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
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor * searchBoxColor = [[UIColor alloc] initWithRed:255.0f green:255.0f blue:255.0f alpha:0.5];
        [self setBackgroundColor:(searchBoxColor)];
        [searchBoxColor release];
        searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(frame.origin.x * 0.70f +8, frame.size.height/2 - 20, frame.size.width * 0.8f - 40 , 40)]; //FIXME: clean dimensions
        [searchTextField setPlaceholder:@"George Orwell"];
        [searchTextField setBackgroundColor:[UIColor whiteColor]];
        [searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [searchTextField setDelegate:self];
        
        
        //-- back button
        // X button
        NSString * deleteIconImagePath = [[NSBundle mainBundle] pathForResource:@"delete_icon" ofType:@"png"];
        UIImage * removeImage = [[UIImage alloc] initWithContentsOfFile:deleteIconImagePath];
        _backFromListViewButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 40, 10.0f, 30.0f, 30.f)];
        
        [_backFromListViewButton setBackgroundImage:removeImage forState:UIControlStateNormal];
        [_backFromListViewButton setAlpha:0.0f];
        [removeImage release];
        // -- end back button
        searchButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width * 0.1f + frame.size.width * 0.8f - 40,  frame.size.height /2 - 20, 40.0f, 40.0f)]; //FIXME: clean dimensions
        [searchButton addTarget:self action:@selector(searchButtonDidPressed) forControlEvents:UIControlEventTouchUpInside];
        [_backFromListViewButton addTarget:self action:@selector(backFromListViewDidPressed) forControlEvents:UIControlEventTouchUpInside];
        NSString* searchImagePath = [ [ NSBundle mainBundle] pathForResource:@"search-icon" ofType:@"png"];
        UIImage * searchButtonImage = [ UIImage imageWithContentsOfFile: searchImagePath];
        [searchButton setImage:searchButtonImage forState:UIControlStateNormal];
        
        [self addSubview:searchButton];
        [self addSubview:searchTextField];
        [self addSubview:_backFromListViewButton];
    }
    return self;
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
    NSLog(@"by enter: %@",self.searchTextField.text);
    [self.searchTextField resignFirstResponder];
    if(self.searchTextField.text != nil && [self.searchTextField.text length]> 0){
        [delegate searchNodesByKeyword:self.searchTextField.text];
    }
    return NO;
}

#pragma button protocol
-(void)searchButtonDidPressed
{
    NSLog(@"%@", self.searchTextField.text);
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
