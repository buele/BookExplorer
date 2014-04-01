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
        [self createQueue];
        
    }
    return self;
}

-(void)createQueue
{
    queue = [[NSOperationQueue alloc] init];
}

-(id)initWithDelegate:(id<FBSApiManagerDelegate>)delegate
{
    self = [super init];
    if(self){
        [self createQueue];
        [self set_delegate:delegate];
    }
    return self;
}



-(void)requestBookDomainTypesForDelegate:(id)delegate
{
    NSURL * url = [NSURL URLWithString:@"https://www.googleapis.com/freebase/v1/mqlread?query=%5B%7B%22id%22:%20null,%22name%22:%20null,%22type%22:%20%22/type/type%22,%22domain%22:%20%22/book%22%7D%5D"];
    FBSApiOperation * op = [[FBSApiOperation alloc]initWithUrl:url andDelegate:self forAction:FBSApiActionRequestBookDomainTypes andTarget:delegate];
    [queue addOperation:op];
}

- (void) responseDidReceived:(NSDictionary*)json forAction:(FBSApiAction)action ofTarget:(id)target
{
    switch(action){
        case FBSApiActionRequestBookDomainTypes:
            [target  bookDomainTypesDidReceived:json];
            break;
        default:
            break;
    }
    
}

+ (FBSApiManager *) getSharedInstance {
    if (sharedSingleton_ == nil) {
        sharedSingleton_ = [[FBSApiManager alloc] init]; }
    return sharedSingleton_;
}

@end



