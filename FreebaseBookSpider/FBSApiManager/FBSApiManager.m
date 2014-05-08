//
//  HttpManager.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 31/03/14.
//

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


#import "FBSURLConnection.h"
#import "FBSApiManager.h"
#import "FBSApiPendingRequest.h"

@implementation FBSApiManager
@synthesize requestCounter;
static FBSApiManager *sharedSingleton_      = nil;
static NSString *  RESULT_RESPONSE_KEY      = @"result";
static NSString *  PROPERTY_KEY             = @"property";

-(id)init
{
    self = [super init];
    if(self){
        requests = [NSMutableDictionary new];
        requestCounter = [[NSNumber alloc] initWithInt:0];
    }
    
    
    return self;
}

#pragma mark FBSApiManagerDelegate protocol implementation
//
-(void)getNodesByKeyword:(NSString*)aKeyword andForDelegate:(id<FBSNodeRequiring>)aDelegate
{
    if(!aDelegate) return;
    if(aKeyword && [aKeyword length] != 0){
        if([FBSResources getSharedInstance])
            [self sendRequestWithUrl:[[FBSResources getSharedInstance] bookNodesUrlByKeyword:aKeyword]  andAction:FBSApiActionRequestNodesByKeyword andTarget:aDelegate forKey:aKeyword];
        else
            [aDelegate nodesByKeywordDidReceived:nil forKey:aKeyword];
    }else
        [aDelegate nodesByKeywordDidReceived:nil forKey:aKeyword];
}

//
-(void)getNodePropertiesById:(NSString*)aNodeId andForDelegate:(id<FBSNodeRequiring>)aDelegate
{
    if(!aDelegate) return;
    if(aNodeId && [aNodeId length] != 0){
        if([FBSResources getSharedInstance])
            [self sendRequestWithUrl:[[FBSResources getSharedInstance] nodePropertiesUrlById:aNodeId]  andAction:FBSApiActionRequestNodePropertiesById andTarget:aDelegate forKey:aNodeId];
        else
            [aDelegate nodePropertiesByIdDidReceived:nil forKey:aNodeId];
    }else
        [aDelegate nodePropertiesByIdDidReceived:nil forKey:aNodeId];
}

//
-(void)getImageById:(NSString*)anImageId andForDelegate:(id<FBSNodeRequiring>)aDelegate
{
    if(!aDelegate) return;
    if(anImageId && [anImageId length] != 0){
        if([FBSResources getSharedInstance])
            [self sendRequestWithUrl:[[FBSResources getSharedInstance] imageUrlById:anImageId]  andAction:FBSApiActionRequestImageById andTarget:aDelegate forKey:anImageId];
        else
            [aDelegate imageByIdDidReceived:nil forKey:anImageId];
    }else
        [aDelegate imageByIdDidReceived:nil forKey:anImageId];
}

#pragma mark utilities
-(NSDictionary *)dataToJson:(NSData *)data
{
    NSError* error;
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data
                                                          options:kNilOptions
                                                            error:&error];
    //if(error)
      //  NSLog(@"%@", error);
    return json;
}

-(void)increaseRequestCounter
{
    int value = [requestCounter intValue];
    self.requestCounter = [NSNumber numberWithInt:value + 1];
}

#pragma mark requests managers
-(void)sendRequestWithUrl:(NSURL* )anUrl andAction:(FBSApiAction)anAction andTarget:(id<FBSNodeRequiring>)aTarget forKey:(NSString *)aKey
{
    if(anUrl && anAction && aTarget && requests){
        FBSURLConnection * connection = [[FBSURLConnection alloc] initWithUrl:anUrl delegate:self requestId:self.requestCounter];
        FBSApiPendingRequest * apiRequest = [[FBSApiPendingRequest alloc] initWithURLConnection:connection action:anAction key:aKey delegate:self target:aTarget];
        [requests setObject:apiRequest forKey:self.requestCounter];
        [self increaseRequestCounter];
        [connection start];
        [connection release];
        [apiRequest release];
    }
}

#pragma mark static method
+ (FBSApiManager *) getSharedInstance {
    if (sharedSingleton_ == nil) 
        sharedSingleton_ = [[FBSApiManager alloc] init];
    return sharedSingleton_;
}

#pragma mark switch types of requestes
- (void) responseDidReceived:(NSData *)response forRequest:(NSNumber *) aRequestId
{
    FBSApiPendingRequest * apiRequest = [requests objectForKey:aRequestId] ;
  
    if(apiRequest.target && response)
        switch(apiRequest.action){
            case FBSApiActionRequestNodesByKeyword:
                [apiRequest.target nodesByKeywordDidReceived:[[self dataToJson:response] objectForKey:RESULT_RESPONSE_KEY] forKey:apiRequest.key];
                break;
            case FBSApiActionRequestNodePropertiesById:
                [apiRequest.target nodePropertiesByIdDidReceived:[[self dataToJson:response] objectForKey:PROPERTY_KEY] forKey:apiRequest.key];
                break;
            case FBSApiActionRequestImageById:
                [apiRequest.target imageByIdDidReceived:[UIImage imageWithData:response] forKey:apiRequest.key];
                break;
            default:
            break;
        }
   [requests removeObjectForKey:aRequestId];
}

-(void)dealloc
{
    [requestCounter release];
    [requests release];
    [super dealloc];
}

@end



