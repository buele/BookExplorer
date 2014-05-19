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

static CGFloat PROPERTY_PADDING = 5.0f;

@implementation BEAuthorView

-(id)initWithTopic:(FBSTopic *)aTopic frame:(CGRect)aFrame 
{
    self = [super initWithTopic:aTopic frame:aFrame];
    if(self){
        [self populateAuthorViewWithTopic:aTopic];
    }
    return  self;
}

-(void)addTopicPropertyViewByPropertyKey:(NSString * )aPropertyKey withLine:(BOOL)line
{
    FBSProperty * property = [[self.topic properties] objectForKey:aPropertyKey];
    if(property && [property.values count] > 0 ){
        if(line) [self addLine];
        CGRect frame = CGRectMake(VIEW_PADDING, lastY, self.bounds.size.width - 2 * VIEW_PADDING, 0);
        TopicPropertyView * topicPropertyView = [[TopicPropertyView alloc] initWithFrame:frame
                                                                             FBSProperty:property];
        [self addSubview:topicPropertyView];
        lastY += topicPropertyView.lastY + PROPERTY_PADDING;
        [topicPropertyView release];
    }
}

-(void)addTopicDatePropertyViewByPropertyKey:(NSString * )aPropertyKey withLine:(BOOL)line
{
    FBSProperty * property = [[self.topic properties] objectForKey:aPropertyKey];
    if(property && [property.values count] > 0 ){
        if(line) [self addLine];
        CGRect frame = CGRectMake(VIEW_PADDING, lastY, self.bounds.size.width - 2 * VIEW_PADDING, 0);
        BETopicDatePropertyView * topicPropertyView = [[BETopicDatePropertyView alloc] initWithFrame:frame
                                                                             FBSProperty:property];
        [self addSubview:topicPropertyView];
        lastY += topicPropertyView.lastY + PROPERTY_PADDING;
        [topicPropertyView release];
    }
}

-(void)addTopicPropertyVerticalViewByPropertyKey:(NSString * )aPropertyKey withLine:(BOOL)line
{
    FBSProperty * property = [[self.topic properties] objectForKey:aPropertyKey];
    if(property && [property.values count] > 0 ){
        if(line) [self addLine];
        CGRect frame = CGRectMake(VIEW_PADDING, lastY, self.bounds.size.width - 2 * VIEW_PADDING, 0);
        BETopicPropertyVerticalView * topicPropertyView = [[BETopicPropertyVerticalView alloc] initWithFrame:frame
                                                                             FBSProperty:property];
        [self addSubview:topicPropertyView];
        lastY += topicPropertyView.lastY + PROPERTY_PADDING;
        [topicPropertyView release];
    }
}

-(void)addLine
{
    lastY += VIEW_PADDING;
    [self addSubview:[self lineAtY:lastY]];
}



-(void)populateAuthorViewWithTopic:(FBSTopic *)aTopic
{
    
    // date of birth
    [self addTopicDatePropertyViewByPropertyKey:FB_DATE_OF_BIRTH_KEY withLine:YES];
    // place of birth
    [self addTopicPropertyViewByPropertyKey:FB_PLACE_OF_BIRTH_KEY withLine:NO];
    // date of birth
    [self addTopicDatePropertyViewByPropertyKey:FB_DATE_OF_DEATH_KEY withLine:NO];
    // place of birth
    [self addTopicPropertyViewByPropertyKey:FB_PLACE_OF_DEATH_KEY withLine:NO];
    
    // quotations
    [self addTopicPropertyVerticalViewByPropertyKey:FB_QUOTATIONS_KEY withLine:YES];

    // works written
    [self addTopicPropertyViewByPropertyKey:FB_WORKS_WRITTEN_KEY withLine:YES];
    
    // influenced by
    [self addTopicPropertyViewByPropertyKey:FB_INFLUENCED_BY_KEY withLine:YES];
    
    // influenced
    [self addTopicPropertyViewByPropertyKey:FB_INFLUENCED_KEY withLine:NO];

    
    
    /*
    FBSProperty * dateOfDeath = [summary objectForKey:FB_DATE_OF_DEATH_KEY];
    if(dateOfDeath && [dateOfDeath.values count] > 0){
        FBSPropertyValue * dateOfDeathFirstItem =[dateOfDeath.values objectAtIndex:0];
        NSDateFormatter *  deathDateFormatter= [[[NSDateFormatter alloc] init] autorelease];
        [deathDateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate * deathDate = [deathDateFormatter dateFromString:dateOfDeathFirstItem.text];
        NSDateFormatter * testFormatter = [[[NSDateFormatter alloc]init]autorelease];
        [testFormatter setDateFormat:@"dd MMMM yyyy"];
        
        [self addSubview:[self lineAtY:lastY + VIEW_PADDING]];
        lastY += VIEW_PADDING + CONTENT_SPACER;
        
        // date of death
        UILabel * deathDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_PADDING, lastY, DEATH_DATE_LABEL_WIDTH, PROPERTY_HEIGTH)];
        [deathDateLabel setText:DEATH_DATE_LABEL];
        [deathDateLabel setFont:[UIFont boldSystemFontOfSize:PROPERTY_LABEL_FONT_SIZE]];
        [self addSubview:deathDateLabel];
        [deathDateLabel release];
        
        UILabel * deathDateValue = [[UILabel alloc] initWithFrame:CGRectMake(DEATH_DATE_LABEL_WIDTH + PROPERTY_SPACER, lastY + 2, (viewWidth / 4.0f), PROPERTY_HEIGTH)];
        [deathDateValue setText:[testFormatter stringFromDate:deathDate]];
        [deathDateValue setFont:[UIFont fontWithName:DEFAULT_FONT_FAMILY size:PROPERTY_VALUE_FONT_SIZE]];
        [self addSubview:deathDateValue];
        [deathDateValue release];
    }
     */
    
    
    
    
    //--
    // place of death
    /*
     FBSProperty * placeOfDeath = [summary objectForKey:FB_PLACE_OF_DEATH_KEY];
    if(placeOfDeath && [placeOfDeath.values count] > 0){
        static NSString *  DEATH_PLACE_LABEL = @"Place of death:";
        static CGFloat DEATH_PLACE_LABEL_WIDTH = 150.0f;
        FBSPropertyValue * placeOfDeathFirstItem =[placeOfDeath.values objectAtIndex:0];
        
        UILabel * placeOfDeathLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_PADDING + viewWidth / 2.0f, lastY, DEATH_PLACE_LABEL_WIDTH, PROPERTY_HEIGTH)];
        [placeOfDeathLabel setText:DEATH_PLACE_LABEL];
        [placeOfDeathLabel setFont:[UIFont boldSystemFontOfSize:PROPERTY_LABEL_FONT_SIZE]];
        [self addSubview:placeOfDeathLabel];
        [placeOfDeathLabel release];
    
        UILabel * deathDateValue = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_PADDING + viewWidth / 2.0f + DEATH_PLACE_LABEL_WIDTH + PROPERTY_SPACER, lastY + 2, (viewWidth / 4.0f), PROPERTY_HEIGTH)];
        [deathDateValue setText:placeOfDeathFirstItem.text]; // place
        [deathDateValue setFont:[UIFont fontWithName:DEFAULT_FONT_FAMILY size:PROPERTY_VALUE_FONT_SIZE]];
        [self addSubview:deathDateValue];
        [deathDateValue release];
    }
    */
    [self setContentSize:CGSizeMake(self.frame.size.width, lastY + VIEW_PADDING)];

    
    
    
}

@end
