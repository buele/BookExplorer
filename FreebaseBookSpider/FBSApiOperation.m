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

- (void)start {

    if ([self isCancelled]){
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    executing = YES;
    [_connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                           forMode:NSDefaultRunLoopMode];
    [_connection start];
    [self didChangeValueForKey:@"isExecuting"];
}

-(id)initWithUrl:(NSURL * )url andDelegate:(id)delegate forAction:(FBSApiAction)action andTarget:(id)target
{
    self = [super init];
    if (self){
        executing = NO;
        finished = NO;
        _action = action;
        buffer = [[NSMutableData alloc] init];
        _delegate = delegate;
        _target = target;
        _connection =[[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url]
                                                     delegate:self
                                             startImmediately:NO];
    }
    
    return self;
}

-(void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    [buffer appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    NSError* error;
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:buffer
                                                          options:kNilOptions
                                                            error:&error] ;

    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [_delegate responseDidReceived:json forAction:_action ofTarget:_target];
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isConcurrent {
    return NO;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

@end

