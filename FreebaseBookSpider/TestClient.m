//
//  TestClient.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 04/05/14.

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

#import "TestClient.h"

@implementation TestClient

-(id)init
{
    self = [super init];
    if(self){
        freebaseBookSpider = [[FreebaseBookSpider alloc] initWithFreebaseApiKey:nil delegate:self];
        [self test];
    }
    return self;
}

#pragma mark private methods
-(void)test
{
    [freebaseBookSpider getNodesByKeyword: @"Siddharta" forDelegate:self];
    [freebaseBookSpider getTopicById:@"/m/034bs" name:@"George Orwell" forDelegate:self];
}

#pragma mark freebase book spider protocol

-(void)nodesDidGenerated:(NSArray *)theNodes forKeyword:(NSString *)keyword
{
  //  [freebaseBookSpider getTopicByNode:[theNodes objectAtIndex:0] forDelegate:self];
    NSLog(@"log");
}

-(void)topicDidGenerated:(FBSTopic *)theTopic
{
   // NSLog(@"name: %@", theTopic.name);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Author name"
                                                    message:theTopic.name
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    
}



-(void)dealloc
{
    [freebaseBookSpider release];
    [super dealloc];
}


@end
