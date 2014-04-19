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
        bookTypesData = [[NSMutableData alloc] init];
        //[[FBSApiManager getSharedInstance] getNodesByKeyword:nil andForDelegate:self];
        //[[FBSApiManager getSharedInstance] getNodesByKeyword:@"Nineteen eighty-four" andForDelegate:self];
        [self nodeManagerTest];
    }
    
    return self;
}

-(void)nodesByKeywordDidReceived:(NSArray*)nodes forKey:(NSString *)key
{
    //NSLog(@"nodesByKeywordDidReceived, for key: %@", key);
    //NSLog(@"nodesByKeywordDidReceived, nodes: %@", nodes );
    if ([nodes count] !=0) {
        NSDictionary * node = [nodes objectAtIndex:0];
        NSString * nodeId = [node objectForKey:@"id"];
        NSLog(@"---->Node: %@",node);
        [[FBSApiManager getSharedInstance] getNodePropertiesById:nodeId andForDelegate:self];
    }
}

-(void)nodePropertiesByIdDidReceived:(NSDictionary*)response forKey:(NSString *)key
{
    //NSLog(@"nodePropertiesByIdDidReceived, for key: %@", key);
    static NSString *  FREEBASE_PROPERTY_KEY = @"property";
    //NSDictionary* properties = [response objectForKey:FREEBASE_PROPERTY_KEY];
   // NSLog(@"properties: %@", properties);
    //NSLog(@"author: %@", [[[[ properties objectForKey:@"/book/written_work/author"]         objectForKey:@"values"] objectAtIndex:0] objectForKey:@"text"]);
   // NSLog(@"date: %@",   [[[[ properties objectForKey:@"/book/written_work/copyright_date"] objectForKey:@"values"] objectAtIndex:0] objectForKey:@"text"]);
}

//--- node manager test ---//

-(void)nodeManagerTest
{
    FBSNodeManager * nodeManager = [[FBSNodeManager alloc] init];
    [nodeManager nodeWithId:@"/en/nineteen_eighty-four" andWithName:@"Nineteen Eighty-Four" forDelegate:self];
}

-(void)nodeDidGenerated:(FBSNode *)node withId:(NSString *)nodeId
{
    NSLog(@"test node: %@", node);
}

//-------------------------//



#pragma mark FBSApiManagerDelegate protocol
-(NSArray *)getAutocompleteSuggestionsByKeyword:(NSString * ) keyword
{
    return nil;
}




@end
