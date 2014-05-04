//
//  FBSNodeGenerator.m
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

#import "FBSTopicGenerator.h"
#import "FBSPendingImageRequest.h"
#import "../FBSApiManager/FBSApiManager.h"

@implementation FBSTopicGenerator

-(id)init
{
    self = [super init];
    if(self){
        pendingImageRequests = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)requestImageWithId:(NSString *)anImageId forTopic:(FBSTopic *)aTopic toTarget:(id<FBSTopicGeneratorDelegate>)aTarget
{
    FBSPendingImageRequest * pendingRequest = [[FBSPendingImageRequest alloc]initWithNode:aTopic andTarget:aTarget];
    [pendingImageRequests addObject:pendingRequest];
    [[FBSApiManager getSharedInstance] getImageById:anImageId andForDelegate:self forRequestId:[NSNumber numberWithInt:[pendingImageRequests count] -1]];
}

-(void)imageByIdDidReceived:(UIImage*)image forKey:(NSNumber *)requestIndex
{
    FBSPendingImageRequest * pendingRequest = [pendingImageRequests objectAtIndex:[requestIndex intValue]];
    pendingRequest.node.image = image;
    [pendingImageRequests removeObjectAtIndex:[requestIndex intValue]];
    [pendingRequest.target topicDidGenerated:pendingRequest.node withId:pendingRequest.node.nodeId];

}


-(void)topicWithNode:(FBSNode *)aNode properties:(NSDictionary *)properties toDelegate:(id<FBSTopicGeneratorDelegate>)aDelegate
{
    
}

-(void)nodesByKeywordDidReceived:(NSArray*)nodes forKey:(NSString *)key
{
    
}
-(void)nodePropertiesByIdDidReceived:(NSDictionary*)properties forKey:(NSString *)key
{
    
}



@end
