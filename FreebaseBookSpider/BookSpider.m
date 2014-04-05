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

@implementation BookSpider

- (id)init
{
    self = [super init];
    if (self) {
        bookTypesData = [[NSMutableData alloc] init];
        
        [[FBSApiManager getSharedInstance] getEntitiesByKeyword:@"orwell" forDelegate:self];
      //  [[FBSApiManager getSharedInstance] getEntitiesByKeyword:@"pasolini" forDelegate:self];
 
        
        
    }
    
    return self;
}

-(void)entitiesByKeywordDidReceived:(NSDictionary*)entities
{
    NSLog(@"testReceived() entities: %@", entities);
}

#pragma mark FBSApiManagerDelegate protocol
-(NSArray *)getAutocompleteSuggestionsByKeyword:(NSString * ) keyword
{
    return nil;
}

-(NSArray *)getEntitiesByKeyword: (NSString * ) keyword
{
    return nil;
}

-(NSDictionary *)getEntityByEntityId:(NSString * ) entityId
{
    return nil;
}


















- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    [bookTypesData appendData:data];
}



@end
