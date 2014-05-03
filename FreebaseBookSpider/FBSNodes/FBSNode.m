//
//  FBSNode.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 21/04/14.

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

#import "FBSNode.h"

@implementation FBSNode
@synthesize nodeId;
@synthesize lang;
@synthesize mid;
@synthesize name;
@synthesize notableId;
@synthesize notableName;


-(id)initWithId:(NSString *)anodeId lang:(NSString *)aLang mid:(NSString *)aMid name:(NSString *)aName notableId:(NSString *)aNotableId notableName:(NSString *)aNotableName
{
    self = [super init];
    if(self){
        nodeId = [[NSString alloc] initWithString:anodeId];
        lang = [[NSString alloc] initWithString:aLang];
        mid = [[NSString alloc] initWithString:aMid];
        name = [[NSString alloc] initWithString:aName];
        notableId = [[NSString alloc] initWithString:aNotableId];
        notableName = [[NSString alloc] initWithString:aNotableName];
    }
    return self;
}

@end
