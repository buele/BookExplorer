//
//  BEBookView.m
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

#import "BEBookView.h"
#import "FBSTopic.h"
#import "FBSBook.h"
#import "FBSAuthor.h"
@implementation BEBookView

-(id)initWithTopic:(FBSTopic *)aTopic frame:(CGRect)aFrame
{
    self = [super initWithTopic:aTopic frame:aFrame];
    if(self){
        [self populateBookViewWithTopic:aTopic];
    }
    return  self;
}

-(void)populateBookViewWithTopic:(FBSTopic *)aTopic
{

    // ** GENERAL INFORMATIONS ** //
    // author
    [self addPropertyViewByKey:FB_AUTHOR_KEY withLine:YES];
    // genre
    [self addPropertyViewByKey:FB_GENRE_KEY withLine:NO];
    //subjects
    [self addPropertyViewByKey:FB_SUBJECTS_KEY withLine:NO];
    
    // ** DATES ** //
    // first pubblication
    [self addDatePropertyViewByKey:FB_DATE_OF_FIRST_PUBBLICATION_KEY withLine:YES];
    // date written
    [self addDatePropertyViewByKey:FB_DATE_WRITTEN_KEY withLine:NO];
    // copyright date
    [self addDatePropertyViewByKey:FB_COPYRIGHT_DATE_KEY withLine:NO];
    
    // ** QUOTATIONS ** //
    [self addVerticalPropertyListViewByKey:FB_QUOTATIONS_KEY withLine:YES];
    
    // ** CHARACTERS AND LANGUAGES ** //
    // characters
    [self addPropertyViewByKey:FB_CHARACTERS_KEY withLine:YES];
    // original language
    [self addPropertyViewByKey:FB_ORIGINAL_LANGUAGE_KEY withLine:NO];
    
    // ** NEXT AND PREVIOUS IN SERIES ** //
    // previous in series
    [self addPropertyViewByKey:FB_PREVIOUS_IN_SERIES_KEY withLine:YES];
    // next in series
    [self addPropertyViewByKey:FB_NEXT_IN_SERIES_KEY withLine:NO];
    
    // ** INFLUENCES ** //
    // influenced by
    [self addPropertyViewByKey:FB_INFLUENCED_BY_KEY withLine:YES];
    // influenced
    [self addPropertyViewByKey:FB_INFLUENCED_KEY withLine:NO];
    
    [self addFreebaseTopicLinkWithNodeId:aTopic.nodeId];
    
    // define content scroll view content size
    [self setContentSize:CGSizeMake(self.frame.size.width, lastY + VIEW_PADDING)];
}


@end
