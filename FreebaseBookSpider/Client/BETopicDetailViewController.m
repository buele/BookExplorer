//
//  BETopicDetailViewController.m
//  FreebaseBookSpider
//

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

#import "BETopicDetailViewController.h"
#import "../FBSNodes/FBSTopic.h"
#import "../FBSNodes/FBSPropertyValue.h"
#import "../FBSNodes/FBSNodeTypes.h"
#import "AuthorView.h"
@interface BETopicDetailViewController ()

@end

@implementation BETopicDetailViewController

- (id)initWithTopic:(FBSTopic *)aTopic {
    self = [super init];
    if (self) {
        // determine topic type:
        
        FBSNodeTypes  type = aTopic.type;
        switch (type) {
            case FBSNodeAuthorType:
                //_view = [[AuthorView alloc] initWithAuthor:aTopic];
                [aTopic summary];
                break;
            case FBSNodeBookType:
                
                break;
            default:
                break;
        }
        
        
        FBSPropertyValue * description = [aTopic.description.values objectAtIndex:0];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello"
                                                        message:description.text
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setFrame:[[UIScreen mainScreen] bounds]];
	//[self.view addSubview:bueleView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
