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

#import "BETopicView.h"
#import "FBSTopic.h"
#import "FBSProperty.h"
#import "FBSPropertyValue.h"


CGFloat  const VIEW_PADDING = 40.0f;


@implementation BETopicView


static CGFloat NAME_HEIGTH = 32.0f;
static CGFloat NAME_FONT_SIZE = 25.0f;
static CGFloat TYPE_FONT_SIZE = 15.0f;
static NSString * NAME_FONT_FAMILY = @"Helvetica";
static NSString * TYPE_FONT_FAMILY = @"Helvetica";
static CGFloat DESCRIPTION_FONT_SIZE = 20.0f;
static CGFloat LINE_HEIGHT = 1.0f;
static NSString * DESCRIPTION_FONT_FAMILY = @"Helvetica";
static NSString * WIKIPEDIA_SIGNATURE = @"(Wikipedia)";

-(id)initWithTopic:(FBSTopic *)aTopic frame:(CGRect)aFrame
{
    self = [super init];
    if(self){
        [self setFrame:aFrame];
        lastY = 0.0f;
        [self populateViewByTopic:aTopic];
    }
    return  self;
}

-(void)populateViewByTopic:(FBSTopic *)aTopic
{
    viewWidth =self.bounds.size.width;
    
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
    CGFloat nameY =  VIEW_PADDING + ((imageHeight)?(imageHeight/2.0f) - NAME_HEIGTH /2.0f : 0.0f);
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_PADDING, nameY, (imageWidth)?self.bounds.size.width - imageWidth - (3 * VIEW_PADDING): self.bounds.size.width - (2 * VIEW_PADDING), NAME_HEIGTH)];
    [name setText:aTopic.name];
    
    [name setTextColor:textColor];
   
    [name setFont:[UIFont fontWithName:NAME_FONT_FAMILY size:NAME_FONT_SIZE]];
    [self addSubview:name];
    lastY = name.frame.origin.y + name.frame.size.height;
    [name release];
    
    // type
    CGFloat typeY =  nameY + NAME_HEIGTH + VIEW_PADDING/3.3333f ;
    UILabel * typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_PADDING, typeY, (imageWidth)?self.bounds.size.width - imageWidth - (3 * VIEW_PADDING): self.bounds.size.width - (2 * VIEW_PADDING), NAME_HEIGTH)];
    switch (aTopic.type) {
        case FBSNodeAuthorType:
            [typeLabel setText:@"Author"];
            break;
        case FBSNodeBookType:
            [typeLabel setText:@"Book"];
            break;
        default:
            break;
    }
    
    [typeLabel setTextColor:textColor];
    
    [typeLabel setFont:[UIFont fontWithName:TYPE_FONT_FAMILY size:TYPE_FONT_SIZE]];
    [self addSubview:typeLabel];
    lastY = typeLabel.frame.origin.y + typeLabel.frame.size.height;
    [typeLabel release];
    
    // description
    if(aTopic.description && [aTopic.description.values count]>0){
        CGFloat descriptionY = (imageHeight > (VIEW_PADDING + NAME_HEIGTH))?imageHeight + 2 *  VIEW_PADDING: 2 * VIEW_PADDING + NAME_HEIGTH  ;
       // [self addSubview:[self lineAtY:descriptionY]];
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
        lastY = description.frame.origin.y + description.frame.size.height;
        [description release];
        
    }
    
    [textColor release];
    
}

-(UIView *)lineAtY:(CGFloat)y
{
    UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(VIEW_PADDING, y - LINE_HEIGHT, self.bounds.size.width - 2 * VIEW_PADDING, 1)] autorelease];
    [lineView setBackgroundColor:[UIColor orangeColor]];
    return lineView;
}
@end
