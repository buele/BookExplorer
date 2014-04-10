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

#import "FBSApiOperation.h"
#import "FBSApiManager.h"

@implementation FBSApiManager
static FBSApiManager *sharedSingleton_      = nil;
static NSString *  ACTION_DICTIONARY_KEY    = @"action";
static NSString *  KEYWORD_DICTIONARY_KEY   = @"keyword";
static NSString *  ACTION_TARGET_KEY        = @"target";
static NSString *  RESULT_RESPONSE_KEY      = @"result";

-(id)init
{
    self = [super init];
    if(self){
        queue = [[NSOperationQueue alloc] init];
        resources = [[FBSResources alloc]init];
    }
    return self;
}

#pragma mark FBSApiManagerDelegate protocol implementation
-(void)getNodesByKeyword:(NSString*)keyword forDelegate:(id)delegate
{
    if(!delegate) return;
    if(keyword && [keyword length] != 0){
        if(resources) [self sendRequestWithUrl:[resources getBookNodesUrlByKeyword:keyword]  andAction:FBSApiActionRequestNodesByKeyword andTarget:delegate];
        else [delegate nodesByKeywordDidReceived:nil];
    }else
        [delegate nodesByKeywordDidReceived:nil];
}

-(void)getNodePropertiesById:(NSString*)nodeId forDelegate:(id)delegate
{
    if(!delegate) return;
    if(nodeId && [nodeId length] != 0){
        if(resources) [self sendRequestWithUrl:[resources getNodePropertiesUrlById:nodeId]  andAction:FBSApiActionRequestNodePropertiesById andTarget:delegate];
        else [delegate nodePropertiesByIdDidReceived:nil];
    }else
        [delegate nodePropertiesByIdDidReceived:nil];
}

-(void)getImageById:(NSString*)imageId forDelegate:(id)delegate
{
    if(!delegate) return;
    if(imageId && [imageId length] != 0){
        if(resources) [self sendRequestWithUrl:[resources getImageUrlById:imageId]  andAction:FBSApiActionRequestImageById andTarget:delegate];
        else [delegate imageByIdDidReceived:nil];
    }else
        [delegate imageByIdDidReceived:nil];
}

#pragma mark utilities
-(NSDictionary *)dataToJson:(NSData *)data
{
    NSError* error;
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data
                                                          options:kNilOptions
                                                            error:&error];
    if(error)  NSLog(@"%@", error);
    return json;
}


#pragma mark requests managers
-(void)sendRequestWithUrl:(NSURL* )url andAction:(FBSApiAction)action andTarget:(id)target
{
    if(url && action && target && queue)
        [queue addOperation:[[FBSApiOperation alloc]initWithUrl:url  andDelegate:self forAction:action  andTarget:target]];
}

#pragma mark static method
+ (FBSApiManager *) getSharedInstance {
    if (sharedSingleton_ == nil) 
        sharedSingleton_ = [[FBSApiManager alloc] init];
    return sharedSingleton_;
}

#pragma mark switch types of requestes
- (void) responseDidReceived:(NSData*)response forAction:(FBSApiAction)action ofTarget:(id)target
{
    if(target && response)
        switch(action){
            case FBSApiActionRequestNodesByKeyword:
                [target nodesByKeywordDidReceived:[[self dataToJson:response] objectForKey:RESULT_RESPONSE_KEY]];
                break;
            case FBSApiActionRequestNodePropertiesById:
                [target nodePropertiesByIdDidReceived:[self dataToJson:response]];
                break;
            case FBSApiActionRequestImageById:
                [target imageByIdDidReceived:[UIImage imageWithData:response]];
                break;
            default:
            break;
        }
}

@end



