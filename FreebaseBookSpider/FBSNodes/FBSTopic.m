//
//  FBSNode.m
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

#import "FBSTopic.h"

@implementation FBSTopic
@synthesize alias;
@synthesize description;
@synthesize image;
@synthesize type;
//@synthesize summary;
//@synthesize details;

-(id)initWithFBSNode:(FBSNode *)aNode
{
    self = [super initWithId:aNode.nodeId lang:aNode.lang mid:aNode.mid name:aNode.name notableId:aNode.notableId notableName:aNode.notableName];
    if(self){
        summary = [[NSMutableDictionary alloc] init];
        details = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(id)initWithFBSNode:(FBSNode *)aNode type:(FBSNodeTypes)aType description:(FBSProperty *)aDescription
{
    self =  [super initWithFBSNode:aNode];
    if(self){
        type = aType;
        description = [aDescription retain];
        summary = [[NSMutableDictionary alloc] init];
        details = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

-(id)initWithAlias:(FBSProperty *)anAlias description:(FBSProperty *)aDescription image:(UIImage *)anImage type:(FBSNodeTypes) aType
{
    self = [super  init];
    if(self){
        alias = [anAlias retain];
        description = [aDescription retain];
        image = [anImage retain];
        type = aType;
        summary = [[NSMutableDictionary alloc] init];
        details = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(NSDictionary *)summary
{    
    NSDictionary * localeSummary = [[[NSDictionary alloc] initWithDictionary:summary] autorelease];
    return localeSummary;
}
-(NSDictionary *)details
{
    NSDictionary * localeDetails = [[[NSDictionary alloc] initWithDictionary:details] autorelease];
    return localeDetails;
}

// to override by child
+(id)topicWithFBSNode:(FBSNode *)aNode properties:(NSDictionary *)properties
{
    return nil;
}
-(id)initWithFBSNode:(FBSNode *)aNode properties:(NSDictionary *)properties
{
    return nil;
}

-(void)dealloc
{
    [summary release];
    [details release];
    [alias release];
    [description release];
    [image release];
    [super dealloc];
}
@end
