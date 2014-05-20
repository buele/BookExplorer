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

NSString * const FB_DESCRIPTION_KEY          = @"/common/topic/description";
NSString * const FB_DESCRIPTION_LABEL        = @"Description";
NSString * const FB_QUOTATIONS_KEY           = @"/people/person/quotations";
NSString * const FB_QUOTATIONS_LABEL         = @"Quotations";
NSString * const FB_INFLUENCED_BY_KEY        = @"/influence/influence_node/influenced_by";
NSString * const FB_INFLUENCED_BY_LABEL      = @"Influenced by";
NSString * const FB_INFLUENCED_KEY           = @"/influence/influence_node/influenced";
NSString * const FB_INFLUENCED_LABEL         = @"Influenced";

@implementation FBSTopic
@synthesize alias;
@synthesize description;
@synthesize image;
@synthesize type;


-(id)initWithFBSNode:(FBSNode *)aNode
{
    return [super initWithId:aNode.nodeId lang:aNode.lang mid:aNode.mid name:aNode.name notableId:aNode.notableId notableName:aNode.notableName];
}

-(id)initWithFBSNode:(FBSNode *)aNode type:(FBSNodeTypes)aType description:(FBSProperty *)aDescription
{
    self =  [super initWithFBSNode:aNode];
    if(self){
        type = aType;
        description = [aDescription retain];
        properties = [[NSMutableDictionary alloc] init];
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
        properties = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(NSDictionary *)properties
{
    return properties;
}


-(id)initWithFBSNode:(FBSNode *)aNode properties:(NSDictionary *)properties
{
    return nil;
}

-(void)dealloc
{
    [properties release];
    [alias release];
    [description release];
    [image release];
    [super dealloc];
}
@end
