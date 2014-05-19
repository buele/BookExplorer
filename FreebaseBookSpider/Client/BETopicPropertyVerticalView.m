//
//  BETopicPropertyVerticalView.m
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

#import "BETopicPropertyVerticalView.h"
#import "FBSProperty.h"
#import "FBSPropertyValue.h"

@implementation BETopicPropertyVerticalView
@synthesize lastY;

static CGFloat LABEL_FONT_SIZE = 20.0f;
static CGFloat VALUE_FONT_SIZE = 20.0f;
static NSString * VALUE_FONT_FAMILY = @"Helvetica";

-(id)initWithFrame:(CGRect )frame FBSProperty:(FBSProperty *)aProperty
{
    self = [super initWithFrame:frame];
    if(self){
        UIColor * textColor = [[UIColor alloc] initWithRed:14.0f/255.0f green:14.0f / 255.0f blue: 14.0f / 255.0f alpha:1.0f]; //TODO union 
        lastY = 1.0f;
        UILabel * label = [[UILabel alloc]init];
        [label setFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [label setText:[NSString stringWithFormat:@"%@: ",aProperty.label]];
        [label setFont:[UIFont boldSystemFontOfSize:LABEL_FONT_SIZE]];
        [label sizeToFit];
        lastY += label.frame.size.height;
        [self addSubview:label];
        for (int i = 0; i < [aProperty.values count]; i++) {
            FBSPropertyValue * propertyValue = aProperty.values[i];
            UITextView * quotation = [[UITextView alloc] init];
            CGRect quotationFrame = CGRectMake(0, lastY, frame.size.width, 0);
            [quotation setFrame:quotationFrame];
            [quotation setText:propertyValue.text];
            [quotation setEditable:NO];
            [quotation setTextColor:textColor];
            [quotation setFont:[UIFont fontWithName:VALUE_FONT_FAMILY size:VALUE_FONT_SIZE]];
            [quotation sizeToFit];
            [self addSubview:quotation];
            lastY = quotation.frame.origin.y + quotation.frame.size.height;
            [quotation release];
        }
        //lastY += label.frame.size.height;
        [label release];
        
    }
    return self;
}

@end
