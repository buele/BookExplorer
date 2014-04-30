//
//  FBSNodeManager.h
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 14/04/14.

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
#import "FBSTopic.h"

@protocol FBSNodeManagerDelegate
-(void)nodeDidGenerated:(FBSTopic *)node withId:(NSString *)nodeId;
@end

@interface FBSNodeManager : NSObject
{
    NSMutableDictionary * pendingNodeRequests;
    NSMutableDictionary * pendingNodesRequestsByKeyword;
    NSMutableDictionary * pendingTopicRequests;
    
}
-(void)nodeWithId:(NSString *)aNodeId andWithName:(NSString *)name forDelegate:(id)delegate;//FIXME: naming and declare the protocol
-(void)topicWithNode:(FBSNode *)aNode forDelegate:(id)aDelegate; //FIXME: naming and declare the protocol
-(void)nodesByKeyword:(NSString *)aKeyword forDelegate:(id)delegate; //FIXME: declare the protocol

@end
