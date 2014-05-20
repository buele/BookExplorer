//
//  BEAuthorView.m
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

#import "BEAuthorView.h"
#import "FBSAuthor.h"
#import "FBSProperty.h"
#import "FBSPropertyValue.h"
#import "TopicPropertyView.h"
#import "BETopicPropertyVerticalView.h"
#import "BETopicDatePropertyView.h"



@implementation BEAuthorView

-(id)initWithTopic:(FBSTopic *)aTopic frame:(CGRect)aFrame 
{
    self = [super initWithTopic:aTopic frame:aFrame];
    if(self){
        [self populateAuthorViewWithTopic:aTopic];
    }
    return  self;
}




-(void)populateAuthorViewWithTopic:(FBSTopic *)aTopic
{
    // ** DATES ** //
    // date of birth
    [self addDatePropertyViewByKey:FB_DATE_OF_BIRTH_KEY withLine:YES];
    // place of birth
    [self addPropertyViewByKey:FB_PLACE_OF_BIRTH_KEY withLine:NO];
    // date of birth
    [self addDatePropertyViewByKey:FB_DATE_OF_DEATH_KEY withLine:NO];
    // place of birth
    [self addPropertyViewByKey:FB_PLACE_OF_DEATH_KEY withLine:NO];
    
    // ** GENERAL INFORMATIONS ** //
    // cause of death
    [self addPropertyViewByKey:FB_CAUSE_OF_DEATH_KEY withLine:YES];
    // nationality
    [self addPropertyViewByKey:FB_NATIONALITY_KEY withLine:NO];
    // gender
    [self addPropertyViewByKey:FB_GENDER_KEY withLine:NO];
    // languages
    [self addPropertyViewByKey:FB_LANGUAGES_KEY withLine:NO];
    // places lived
    //[self addVerticalPropertyListViewByKey:FB_PLACES_LIVED_KEY withLine:NO];
    
    // ** WORKS WRITTEN ** //
    [self addPropertyViewByKey:FB_WORKS_WRITTEN_KEY withLine:YES];

    // ** QUOTATIONS ** //
    [self addVerticalPropertyListViewByKey:FB_QUOTATIONS_KEY withLine:YES];

    // ** INFLUENCES ** //
    // influenced by
    [self addPropertyViewByKey:FB_INFLUENCED_BY_KEY withLine:YES];
    // influenced
    [self addPropertyViewByKey:FB_INFLUENCED_KEY withLine:NO];

    // ** EXPERIENCES AND LANGUAGES **//
    // employment history
    //[self addVerticalPropertyListViewByKey:FB_EMPLOYMENT_HISTORY_KEY withLine:YES];
    // education
    //[self addVerticalPropertyListViewByKey:FB_EDUCATION_KEY withLine:YES];
   
    
    // ** PROFESSIONS AND RELIGION ** //
    // professions
    [self addPropertyViewByKey:FB_PROFESSION_KEY withLine:YES];
    // religions
    [self addPropertyViewByKey:FB_REGION_KEY withLine:NO];
    
    // ** FAMILY ** //
    // parents
    [self addPropertyViewByKey:FB_PARENTS_KEY withLine:YES];
    // children
    [self addPropertyViewByKey:FB_CHILDREN_KEY withLine:NO];
    // spouses
    //[self addVerticalPropertyListViewByKey:FB_SPOUSES_KEY withLine:NO];
    
    // define content scroll view content size
    [self setContentSize:CGSizeMake(self.frame.size.width, lastY + VIEW_PADDING)];

}

@end
