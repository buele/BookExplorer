//
//  BETopicDatePropertyView.m
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

#import "BETopicDatePropertyView.h"
#import "FBSProperty.h"
#import "FBSPropertyValue.h"

@implementation BETopicDatePropertyView
@synthesize lastY;

static CGFloat LABEL_FONT_SIZE = 20.0f;
static CGFloat VALUE_FONT_SIZE = 20.0f;

static NSString * VALUE_FONT_FAMILY = @"Helvetica";

-(id)initWithFrame:(CGRect )frame FBSProperty:(FBSProperty *)aProperty
{
    self = [super initWithFrame:frame];
    if(self){
        FBSPropertyValue * firstDate =[aProperty.values objectAtIndex:0];
     
        // label
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, lastY, frame.size.width, 0)];
        [label setText:[NSString stringWithFormat:@"%@: ",aProperty.label]];
        [label setFont:[UIFont boldSystemFontOfSize:LABEL_FONT_SIZE]];
        [label sizeToFit];
        [self addSubview:label];
        
        // value
        NSDateFormatter *  dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate * date = [dateFormatter dateFromString:firstDate.text];
        NSDateFormatter * valueFormatter = [[[NSDateFormatter alloc]init]autorelease];
        [valueFormatter setDateFormat:@"dd MMMM yyyy"];
        UILabel * value = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.size.width , lastY + 1, frame.size.width, 0)];
        [value setText:[valueFormatter stringFromDate:date]];
        [value setFont:[UIFont fontWithName:VALUE_FONT_FAMILY size:VALUE_FONT_SIZE]];
        [value sizeToFit];
        [self addSubview:value];
        lastY += label.frame.size.height;
        
        
        [label release];
        [value release];
        
    }
    return self;
}
@end
