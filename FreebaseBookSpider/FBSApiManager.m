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
static FBSApiManager *sharedSingleton_ = nil;

-(id)init
{
    self = [super init];
    if(self){
        queue = [[NSOperationQueue alloc] init];
        resources = [[FBSResources alloc]init];
        [self requestBookDomainTypes];
        self.typesReady = false;
        pendingRequests = [[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark FBSApiManagerDelegate protocol implementation
-(void)getEntitiesByKeyword:(NSString*)keyword forDelegate:(id)delegate
{
    [self sendRequestOfAction:FBSApiActionRequestEntitiesByKeyword withUrl:[NSURL URLWithString:@"http://www.google.it"] forTarget:delegate];
}

#pragma mark requests managers
-(void)sendRequestOperation:(NSDictionary*)parameters
{
    if(self.typesReady){
        FBSApiOperation * op = [[FBSApiOperation alloc]initWithUrl:[parameters objectForKey:@"url"]  andDelegate:self forAction: [[parameters objectForKey:@"action"]intValue ]  andTarget:[parameters objectForKey:@"target"]];
        [queue addOperation:op];
    }else{
        [pendingRequests addObject:parameters];
    }
}

-(void)sendRequestOfAction:(FBSApiAction)action  withUrl:(NSURL*)url forTarget:(id)target
{
    NSOperation * sendOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(sendRequestOperation:) object:[[NSDictionary alloc] initWithObjectsAndKeys:  url,@"url" , target,@"target" ,  [NSNumber numberWithInt:action], @"action" , nil ]];
    [queue addOperation:sendOperation];
}

-(void)requestBookDomainTypes
{
    FBSApiOperation * op = [[FBSApiOperation alloc]initWithUrl:[resources getAllTypesOfBookDomainUrl]  andDelegate:self forAction:  FBSApiActionRequestBookDomainTypes andTarget:[NSNull null]];
    [queue addOperation:op];
}

-(void)dispatchPendingRequestes
{
    for(NSDictionary *parameters in pendingRequests)
        [queue addOperation:[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(sendRequestOperation:) object:parameters]];
    pendingRequests = nil; //remove pending requestes
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
            [target entitiesByKeywordDidReceived:response];
            break;
        default:
            break;
    }
}

#pragma mark response managers
-(void)manageBookDomainTypes:(NSDictionary *)types
{
    bookDomainTypes = types;
    //manage your types here
    NSLog(@"manageBookDomainTypes()");
    self.typesReady = true;
    [self dispatchPendingRequestes];
}

@end



