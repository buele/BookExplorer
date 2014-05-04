//
//  BookSpider.m
//  Freebase interface object to look topics about books
//
//  Created by Raffaele Bua on 28/03/14.

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


#import "BookSpider.h"
#import "FBSNodes/FBSEntityManager.h"
#import "FBSNode.h"

@implementation BookSpider

- (id)init
{
    self = [super init];
    if (self) {
        nodeManager = [[FBSEntityManager alloc] init];
        [self getNodesByKeyword: @"Siddharta" forDelegate:self];
    }
    return self;
}

-(void)topicDidGenerated:(FBSTopic *)theNode withId:(NSString *)theNodeId
{
    NSLog(@"description: %@",[[theNode.description.values objectAtIndex:0] text] );
}

-(void)nodesByKeywordDidReceived:(NSArray*)nodes forKey:(NSString *)key
{
    [self getTopicByNode:[nodes objectAtIndex:0] forDelegate:self]; //test
}


// -- debugging
-(void)nodeDidGenerated:(FBSTopic *)node withId:(NSString *)nodeId
{
    
}

-(void)nodesDidGenerated:(NSArray *)theNodes forKeyword:(NSString *)keyword
{
    
}
-(void)topicDidGenerated:(FBSTopic *)theTopic
{
    
}
#pragma mark main interface
-(id)initWithFreebaseApiKey:(NSString *)anApiKey
{
    return nil;
}
-(void)getNodesByKeyword: (NSString * ) aKeyword forDelegate:(id<FreebaseBookSpiderDelegate>)aDelegate
{
    [nodeManager nodesByKeyword:aKeyword forDelegate:self];
}

-(void)getTopicByNode:(FBSNode *)aNode forDelegate:(id<FreebaseBookSpiderDelegate>)aDelegate
{
    [nodeManager topicWithNode:aNode forDelegate:self];
}





@end
