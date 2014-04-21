//
//  BookSpider.m
//  Freebase interface object to look topics about books
//
//  Created by Raffaele Bua on 28/03/14.

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


#import "FBSApiManager.h"
#import "BookSpider.h"
#import "FBSNodes/FBSNodeManager.h"

@implementation BookSpider

- (id)init
{
    self = [super init];
    if (self) {
        nodeManager = [[FBSNodeManager alloc] init];

        //test 1 book
        [self getEntityById:@"/en/nineteen_eighty-four" withName:@"Nineteen Eighty-Four"];
        // test 2 author
        [self getEntityById:@"/m/034bs" withName:@"George Orwell"];
    }
    
    return self;
}


-(void)nodeDidGenerated:(FBSNode *)node withId:(NSString *)nodeId
{
    NSLog(@"test node" );
}


#pragma mark FBSApiManagerDelegate protocol
-(void)getAutocompleteSuggestionsByKeyword:(NSString * ) aKeyword
{
    
}
-(void)getEntitiesByKeyword: (NSString * ) aKeyword
{
    
}
-(void)getEntityById:(NSString * ) anId withName:(NSString *)aName{
    [nodeManager nodeWithId:anId andWithName:aName forDelegate:self];
}




@end
