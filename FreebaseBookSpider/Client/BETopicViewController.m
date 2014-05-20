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

#import "BETopicViewController.h"
#import "../FBSNodes/FBSTopic.h"
#import "../FBSNodes/FBSPropertyValue.h"
#import "../FBSNodes/FBSNodeTypes.h"
#import "BETopicView.h"
#import "BEAuthorView.h"
#import "BEBookView.h"

@interface BETopicViewController ()

@end

@implementation BETopicViewController


-(id)initWithTopic:(FBSTopic *)aTopic
{
    self = [super init];
    if(self){
        [self.navigationController setToolbarHidden:YES animated:NO];
        topic = [aTopic retain];
        switch (aTopic.type) {
            case FBSNodeAuthorType:
                topicView = [[BEAuthorView alloc] initWithTopic:aTopic frame:[[UIScreen mainScreen] bounds]];
                break;
            case FBSNodeBookType:
                topicView = [[BEBookView alloc] initWithTopic:aTopic frame:[[UIScreen mainScreen] bounds]];
                break;
            default:
                break;
        }
    }
    return self;
}




- (void)loadView {
	[super loadView];
	[self.view setFrame:[[UIScreen mainScreen] bounds]];
    [topicView  setFrame:[[UIScreen mainScreen] bounds]];
    [topicView setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:topicView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [topicView release];
    [topic release];
    [super dealloc];
}

@end
