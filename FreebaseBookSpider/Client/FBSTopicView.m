//
//  BETopicView.m
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

#import "FBSTopicView.h"
#import "FBSTopic.h"
#import "FBSProperty.h"
#import "FBSPropertyValue.h"
#import "FBSTopicPropertyView.h"
#import "BETopicDatePropertyView.h"
#import "BETopicPropertyVerticalView.h"

CGFloat  const VIEW_PADDING = 40.0f;
static CGFloat PROPERTY_PADDING = 5.0f;
static CGFloat POLICY_FONT_SIZE = 20.0f;

@implementation FBSTopicView
@synthesize topic;


static CGFloat NAME_HEIGTH = 32.0f;
static CGFloat LINE_PADDING = 5.0f;
static CGFloat NAME_FONT_SIZE = 25.0f;
static NSString * NAME_FONT_FAMILY = @"Helvetica";
static NSString * POLICY_LABEL = @"Topic link: ";
static NSString * POLICY_TOPIC_ID_LABEL = @"Topic ID: ";
static NSString * TOPIC_BASE_URL = @"http://www.freebase.com%@";

static CGFloat DESCRIPTION_FONT_SIZE = 20.0f;
static CGFloat LINE_HEIGHT = 1.0f;
static CGFloat FREEBASE_LINK_HEIGHT = 40.0f;

static NSString * DESCRIPTION_FONT_FAMILY = @"Helvetica";
static NSString * WIKIPEDIA_SIGNATURE = @"(Wikipedia)";

-(id)initWithTopic:(FBSTopic *)aTopic frame:(CGRect)aFrame
{
    self = [super init];
    if(self){
        topic = [aTopic retain];
        [self setFrame:aFrame];
        lastY = 0.0f;
        [self setContentSize:CGSizeMake(aFrame.size.width, aFrame.size.height)];
        [self populateViewByTopic:aTopic];
    }
    return  self;
}

-(void)populateViewByTopic:(FBSTopic *)aTopic
{
    viewWidth = self.bounds.size.width;
    UIColor * textColor = [[UIColor alloc] initWithRed:14.0f/255.0f green:14.0f / 255.0f blue: 14.0f / 255.0f alpha:1.0f];
    
    // image
    CGFloat imageHeight = (aTopic.image && aTopic.image.size.height > 0)?aTopic.image.size.height : 0.0f;
    CGFloat imageWidth  = (aTopic.image && aTopic.image.size.width > 0)?aTopic.image.size.width : 0.0f;
    if(aTopic.image){
        UIImageView * image = [[UIImageView alloc] initWithImage:aTopic.image];
        [image setFrame:CGRectMake(self.bounds.size.width - VIEW_PADDING - imageWidth, VIEW_PADDING, imageWidth, imageHeight )];
        [self addSubview:image];
        [image release];
    }
    
    // name
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_PADDING, VIEW_PADDING, (imageWidth)?self.bounds.size.width - imageWidth - (3 * VIEW_PADDING): self.bounds.size.width - (2 * VIEW_PADDING), NAME_HEIGTH)];
    [name setText:aTopic.name];
    [name setTextColor:textColor];
    [name setFont:[UIFont fontWithName:NAME_FONT_FAMILY size:NAME_FONT_SIZE]];
    [self addSubview:name];
    lastY = name.frame.origin.y + name.frame.size.height;
    [name release];
    
    // description
    if(aTopic.description && [aTopic.description.values count]>0){
        CGFloat descriptionY = (imageHeight > (VIEW_PADDING + NAME_HEIGTH))?imageHeight + 2 *  VIEW_PADDING: 2 * VIEW_PADDING + NAME_HEIGTH  ;
        UITextView * description = [[UITextView alloc] init];
        FBSPropertyValue * mainDescription = [aTopic.description.values objectAtIndex:0 ];
        NSString * mainDescriptionText = [NSString stringWithString:mainDescription.value];
        CGRect frame = CGRectMake(VIEW_PADDING, descriptionY, self.bounds.size.width - (2 * VIEW_PADDING ), 0);
        [description setFrame:frame];
        [description setText:[NSString stringWithFormat:@"%@ %@", mainDescriptionText,WIKIPEDIA_SIGNATURE]];
        [description setEditable:NO];
        [description setTextColor:textColor];
        [description setFont:[UIFont fontWithName:DESCRIPTION_FONT_FAMILY size:DESCRIPTION_FONT_SIZE]];
        [description sizeToFit];
        [self addSubview:description];
        lastY = description.frame.origin.y + description.frame.size.height ;
        [description release];
    }
    [textColor release];
}

-(UIView *)lineAtY:(CGFloat)y
{
    UIColor * lineColor = [[UIColor alloc] initWithRed:213.0f/255.0f green:85.0f / 255.0f blue: 54.0f / 255.0f alpha:1.0f];
    UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(VIEW_PADDING, y - LINE_HEIGHT, self.bounds.size.width - 2 * VIEW_PADDING, 1)] autorelease];
    [lineView setBackgroundColor: lineColor];
    lastY += LINE_PADDING;
    [lineColor release];
    return lineView;
    
}


-(void)addPropertyViewByKey:(NSString * )aPropertyKey withLine:(BOOL)line
{
    FBSProperty * property = [[self.topic properties] objectForKey:aPropertyKey];
    if(property && [property.values count] > 0 ){
        if(line) [self addLine];
        CGRect frame = CGRectMake(VIEW_PADDING, lastY, self.bounds.size.width - 2 * VIEW_PADDING, 0);
        FBSTopicPropertyView * topicPropertyView = [[FBSTopicPropertyView alloc] initWithFrame:frame
                                                                             FBSProperty:property];
        [self addSubview:topicPropertyView];
        lastY += topicPropertyView.lastY + PROPERTY_PADDING;
        [topicPropertyView release];
    }
}

-(void)addDatePropertyViewByKey:(NSString * )aPropertyKey withLine:(BOOL)line
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

-(void)addVerticalPropertyListViewByKey:(NSString * )aPropertyKey withLine:(BOOL)line
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

-(void)addFreebaseTopicLinkWithNodeId:(NSString *)aNodeId
{
    [self addLine];
    // label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_PADDING, lastY, self.frame.size.width, 0)];
    [label setText:POLICY_LABEL];
    [label setFont:[UIFont boldSystemFontOfSize:POLICY_FONT_SIZE]];
    [label sizeToFit];
    [self addSubview:label];
    lastY += label.frame.size.height;
    
    // value
    UILabel * value = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_PADDING , lastY , self.frame.size.width - VIEW_PADDING * 2.0f, FREEBASE_LINK_HEIGHT)];
    [value setText:[NSString stringWithFormat:TOPIC_BASE_URL,aNodeId]];
    [value setFont:[UIFont systemFontOfSize:POLICY_FONT_SIZE]];
    //[value sizeToFit];
    [self addSubview:value];
    lastY += value.frame.size.height;
    
    // label
    UILabel * topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_PADDING, lastY, self.frame.size.width, 0)];
    [topicLabel setText:POLICY_TOPIC_ID_LABEL];
    [topicLabel setFont:[UIFont boldSystemFontOfSize:POLICY_FONT_SIZE]];
    [topicLabel sizeToFit];
    [self addSubview:topicLabel];
    lastY += topicLabel.frame.size.height;
    
    // value
    UILabel * topicValue = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_PADDING , lastY , self.frame.size.width - VIEW_PADDING * 2.0f, FREEBASE_LINK_HEIGHT)];
    [topicValue setText:aNodeId];
    [topicValue setFont:[UIFont systemFontOfSize:POLICY_FONT_SIZE]];
    //[value sizeToFit];
    [self addSubview:topicValue];
    lastY += topicValue.frame.size.height;
    
    [value release];
    [label release];
    [topicLabel release];
    [topicValue release];
    
}


-(void)addLine
{
    lastY += VIEW_PADDING;
    [self addSubview:[self lineAtY:lastY]];
}

-(void)dealloc
{
    [topic release];
    [super dealloc];
}
@end
