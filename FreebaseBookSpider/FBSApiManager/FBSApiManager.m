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
        pendingRequests = [[NSMutableArray alloc]init];
        [self requestBookDomainTypes];
        self.typesReady = false;
    }
    return self;
}

#pragma mark FBSApiManagerDelegate protocol implementation
-(void)getEntitiesByKeyword:(NSString*)keyword forDelegate:(id)delegate
{
    if(!delegate) return;
    if(keyword){
        if(self.typesReady){
            if(resources)
                [self sendRequestWithUrl:[resources getBookEntitiesUrlByKeyword:keyword]  andAction:FBSApiActionRequestEntitiesByKeyword andTarget:delegate];
            else
                [delegate entitiesByKeywordDidReceived:nil];
        }
        else
            [pendingRequests addObject:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:FBSApiActionRequestEntitiesByKeyword] , ACTION_DICTIONARY_KEY , keyword, KEYWORD_DICTIONARY_KEY, delegate, ACTION_TARGET_KEY, nil ]];
    }else{
        [delegate entitiesByKeywordDidReceived:nil];
    }
}

#pragma mark requests managers
-(void)sendRequestWithUrl:(NSURL* )url andAction:(FBSApiAction)action andTarget:(id)target
{
    if(url && action && target && queue)
        [queue addOperation:[[FBSApiOperation alloc]initWithUrl:url  andDelegate:self forAction:action  andTarget:target]];
}

-(void)requestBookDomainTypes
{
    if(resources && queue){
        FBSApiOperation * op = [[FBSApiOperation alloc]initWithUrl:[resources getAllTypesOfBookDomainUrl]  andDelegate:self forAction:  FBSApiActionRequestBookDomainTypes andTarget:[NSNull null]];
        [queue addOperation:op];
    }
}

-(void)dispatchPendingRequestes
{
    if(pendingRequests && [pendingRequests count] > 0 && resources){
        NSString* keyword = nil;
        id target = nil;
        FBSApiAction action = 0;
        
        for(NSDictionary *pendingRequest in pendingRequests){
            action  = [[pendingRequest objectForKey:ACTION_DICTIONARY_KEY] intValue];
            switch(action){
                case FBSApiActionRequestEntitiesByKeyword:
                    keyword = [pendingRequest objectForKey:KEYWORD_DICTIONARY_KEY];
                    target  = [pendingRequest objectForKey:ACTION_TARGET_KEY];
                    if(target){
                        if(keyword) [self sendRequestWithUrl:[resources getBookEntitiesUrlByKeyword:keyword ] andAction:action  andTarget:target];
                        else [target entitiesByKeywordDidReceived:nil];
                    }
                break;
                default:
                break;
            }
        }
        pendingRequests = nil; //remove pending requestes
    }
}

#pragma mark static method
+ (FBSApiManager *) getSharedInstance {
    if (sharedSingleton_ == nil) {
        sharedSingleton_ = [[FBSApiManager alloc] init]; }
    return sharedSingleton_;
}

#pragma mark switch types of requestes
- (void) responseDidReceived:(NSDictionary*)response forAction:(FBSApiAction)action ofTarget:(id)target
{
    switch(action){
        case FBSApiActionRequestBookDomainTypes:
            [self manageBookDomainTypes:response];
            break;
        case FBSApiActionRequestEntitiesByKeyword:
            if(target && response)
                [target entitiesByKeywordDidReceived:[response objectForKey:RESULT_RESPONSE_KEY]];
            break;
        default:
            break;
    }
}

#pragma mark response managers
-(void)manageBookDomainTypes:(NSDictionary *)types
{
    if(resources && types && [types count]> 0){
        bookDomainTypes = types;
        [resources generateEntitiesByKeywordUrlByTypes:types];
        self.typesReady = true;
        [self dispatchPendingRequestes];
    }
}

@end



