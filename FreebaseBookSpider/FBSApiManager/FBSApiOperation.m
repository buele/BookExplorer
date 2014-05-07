//
//  FBSApiOperation.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 01/04/14.
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

@implementation FBSApiOperation
static NSString *  IS_FINISHED_KVO_KEY  = @"isFinished";
static NSString *  IS_EXECUTING_KVO_KEY = @"isExecuting";

-(id)initWithUrl:(NSURL * )aUrl andDelegate:(id)aDelegate forAction:(FBSApiAction)anAction andTarget:(id)aTarget forKey:(NSString *)aKey
{
    self = [super init];
    if (self){
        key = aKey;
        executing = NO;
        finished = NO;
        action = anAction;
        buffer = [[NSMutableData alloc] init];
        delegate = [aDelegate retain];
        target = [aTarget retain];
        connection =[[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:aUrl]
                                                    delegate:self
                                            startImmediately:NO];
    }
    return self;
}

- (void)start {
    if ([self isCancelled]){
        [self willChangeValueForKey:IS_FINISHED_KVO_KEY];
        finished = YES;
        [self didChangeValueForKey:IS_FINISHED_KVO_KEY];
        return;
    }
    [self willChangeValueForKey:IS_EXECUTING_KVO_KEY];
    executing = YES;
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                           forMode:NSDefaultRunLoopMode];
    [connection start];
    [self didChangeValueForKey:IS_EXECUTING_KVO_KEY];
}



-(void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    [buffer appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    [self willChangeValueForKey:IS_FINISHED_KVO_KEY];
    [self willChangeValueForKey:IS_EXECUTING_KVO_KEY];
    executing = NO;
    finished = YES;
    [delegate responseDidReceived:buffer forAction:action ofTarget:target forKey:key];
    [self didChangeValueForKey:IS_FINISHED_KVO_KEY];
    [self didChangeValueForKey:IS_EXECUTING_KVO_KEY];
}

- (BOOL)isConcurrent
{
    return NO;
}

- (BOOL)isExecuting
{
    return executing;
}

- (BOOL)isFinished
{
    return finished;
}

-(void)dealloc
{
    [buffer release];
    [connection release];
    [key release];
    [target release];
    [delegate release];
    [super dealloc];
}

@end

