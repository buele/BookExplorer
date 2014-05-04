//
//  FBSProperty.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 17/04/14.

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

#import "FBSProperty.h"
#import "FBSPropertyValue.h"

@implementation FBSProperty
@synthesize label;
@synthesize values;

-(id)initWithFreebaseProperty:(NSDictionary *)aProperty label:(NSString *)aLabel
{
    static NSString * VALUES_KEY = @"values";
    static NSString * FBPROPERTY_ID_KEY = @"id";
    static NSString * FBPROPERTY_LANG_KEY = @"lang";
    static NSString * FBPROPERTY_TEXT_KEY = @"text";
    
    self = [super init];
    
    if(self){
        label = aLabel;
        values = [[NSMutableArray alloc] init];
        for (NSDictionary * item in [aProperty objectForKey:VALUES_KEY]) {
            FBSPropertyValue * value = [[FBSPropertyValue alloc] initWithId:[item objectForKey:FBPROPERTY_ID_KEY] lang:[item objectForKey:FBPROPERTY_LANG_KEY] text:[item objectForKey:FBPROPERTY_TEXT_KEY]];
            [values addObject:value];
        }
    }
    
    return self;
}
@end
