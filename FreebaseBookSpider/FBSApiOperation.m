//
//  FBSApiOperation.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 01/04/14.
//

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

