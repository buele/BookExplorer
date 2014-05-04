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


#import "FreebaseBookSpider.h"
#import "FBSNodes/FBSEntityManager.h"
#import "FBSNode.h"

@implementation FreebaseBookSpider

#pragma mark init
- (id)init
{
    self = [super init];
    if (self) {
        nodeManager = [[FBSEntityManager alloc] init];        
    }
    return self;
}

-(id)initWithDelegate:(id<FreebaseBookSpiderDelegate>)aDelegate{
    self = [self init];
    if(self){
        delegate = aDelegate;
    }
    return self;
}

-(id)initWithFreebaseApiKey:(NSString *)anApiKey delegate:(id<FreebaseBookSpiderDelegate>) aDelegate
{
    self  = [self initWithDelegate:aDelegate];
    if(self){
        [[FBSResources getSharedInstance]setFreebaseApiKey:anApiKey];
    }
    return self;
}


#pragma mark main interface

-(void)getNodesByKeyword: (NSString * ) aKeyword forDelegate:(id<FreebaseBookSpiderDelegate>)aDelegate
{
    [nodeManager nodesByKeyword:aKeyword forDelegate:self];
}

-(void)getTopicByNode:(FBSNode *)aNode forDelegate:(id<FreebaseBookSpiderDelegate>)aDelegate
{
    [nodeManager topicWithNode:aNode forDelegate:self];
}



#pragma mark FBSNodeManagerDelegate protocol


-(void)nodesByKeywordDidReceived:(NSArray*)nodes forKey:(NSString *)key
{
    [delegate nodesDidGenerated:nodes forKeyword:key];
}
-(void)topicDidGenerated:(FBSTopic *)aTopic withId:(NSString *)anId
{
     [delegate topicDidGenerated:aTopic];
}

@end
