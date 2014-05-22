//
//  TopicPropertyView.m
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

#import "FBSTopicPropertyView.h"
#import "FBSProperty.h"
#import "FBSPropertyValue.h"

@implementation FBSTopicPropertyView
@synthesize lastY;
static CGFloat LABEL_FONT_SIZE = 20.0f;
static CGFloat VALUE_FONT_SIZE = 20.0f;
static NSString * VALUE_FONT_FAMILY = @"Helvetica";



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect )frame FBSProperty:(FBSProperty *)aProperty
{
    self = [super initWithFrame:frame];
    if(self){
        lastY = 1.0f;
        UILabel * label = [[UILabel alloc]init];
        [label setFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [label setText:[NSString stringWithFormat:@"%@: ",aProperty.label]];
        [label setFont:[UIFont boldSystemFontOfSize:LABEL_FONT_SIZE]];
        [label sizeToFit];
        [self addSubview:label];
        CGFloat valueX = label.frame.size.width;
        for (int i = 0; i < [aProperty.values count]; i++) {
            FBSPropertyValue * propertyValue = aProperty.values[i];
            UILabel * textValue = [[UILabel alloc]init];
            CGRect propertyValueFrame = CGRectMake(valueX , lastY, frame.size.width, 0);
            [textValue setFrame:propertyValueFrame];
            NSString * valueString = (i != ([aProperty.values count] -1))? [NSString stringWithFormat:@"%@, ",propertyValue.text]:propertyValue.text;
            [textValue setText:valueString];
            [textValue setFont:[UIFont fontWithName:VALUE_FONT_FAMILY size:VALUE_FONT_SIZE]];
            [textValue sizeToFit];
            valueX += textValue.frame.size.width;
            if(valueX > frame.size.width){
                propertyValueFrame.origin.x = 0.0f;
                lastY += label.frame.size.height;
                propertyValueFrame.origin.y = lastY;
                valueX = textValue.frame.size.width;
                propertyValueFrame.size.width = textValue.frame.size.width;
                propertyValueFrame.size.height = textValue.frame.size.height;
                [textValue setFrame:propertyValueFrame];
            }
            [self addSubview:textValue];
            [textValue release];            
        }
        lastY += label.frame.size.height;
        [label release];
        
    }
    return self;
}

@end
