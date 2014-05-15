//
//  FreeBaseBookSpider.h
//  FreebaseBookSpider
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

#import <Foundation/Foundation.h>
#import "FBSApiManager.h"
#import "FBSEntityManager.h"
#import "FBSNode.h"
#import "FBSTopic.h"
#import "FBSBook.h"
#import "FBSAuthor.h"

@protocol FreebaseBookSpiderDelegate
-(void)nodesDidGenerated:(NSArray *)theNodes forKeyword:(NSString *)keyword;
-(void)topicDidGenerated:(FBSTopic *)theTopic;
-(void)authorDidGenerated:(FBSAuthor *)anAuthor;
-(void)bookDidGenerated:(FBSBook *)aBook;
@end

@interface FreebaseBookSpider : NSObject <FBSNodeManagerDelegate> //TODO: remove FreebaseBookSpiderDelegate after testing
{
    FBSEntityManager * nodeManager;
    id delegate;
}

-(id)init;

#pragma mark init
-(id)initWithDelegate:(id<FreebaseBookSpiderDelegate>)delegate;
-(id)initWithFreebaseApiKey:(NSString *)anApiKey delegate:(id<FreebaseBookSpiderDelegate>) aDelegate;

#pragma mark main interface
-(void)getNodesByKeyword: (NSString * ) aKeyword forDelegate:(id<FreebaseBookSpiderDelegate>)aDelegate;
-(void)getTopicByNode:(FBSNode * )aNode forDelegate:(id<FreebaseBookSpiderDelegate>)aDelegate;
-(void)getTopicById:(NSString *)anId name:(NSString *)aName forDelegate:(id<FreebaseBookSpiderDelegate>) aDelegate;
@end
