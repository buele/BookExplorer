//
//  FBSPropertyValue.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 11/04/14.

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

#import "FBSPropertyValue.h"

@implementation FBSPropertyValue
@synthesize propertyId;
@synthesize lang;
@synthesize text;
@synthesize value;

-(id)initWithId:(NSString *)aPropertyId lang:(NSString *)aLang text:(NSString *)aText value:(NSString *)aValue
{
    self = [super init];
    if(self){
        propertyId = (aPropertyId)?[aPropertyId retain]: nil;
        lang = (aLang)?[aLang retain]:nil;
        text = (aText)?[aText retain]:nil;
        value = (aValue)?[aValue retain]:nil;
        
    }
    return self;
}

-(void)dealloc
{
    if(propertyId)[propertyId release];
    if(lang)[lang release];
    if(text)[text release];
    if(value)[value release];
    [super dealloc];
}
@end
