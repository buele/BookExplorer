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
        freebaseUrls = [self getFreebaseBaseUrls];
        mqlQueries = [self getMQLQueries];
        // NSString * allTypesOfBookDomainUrl = [self getAllTypesOfBookDomainUrl];
        // NSLog(@"url: %@", [self encodeUrl:allTypesOfBookDomainUrl]);
        
        
        [[FBSApiManager getSharedInstance] requestBookDomainTypesForDelegate:self]; //!!! DONE
        
    }
    
    return self;
}

- (void) bookDomainTypesDidReceived:(NSDictionary*)types{
    NSLog(@"bette giru: %@",types);
}

-(void)manageBookDomainTypes:(NSDictionary *)types
{
    NSLog(@"%@",types);
}

-(NSString * )getAllTypesOfBookDomainUrl
{
    NSString * allTypesOfBookDomainQuery = [mqlQueries objectForKey:@"get_book_domain_all_types"];
    
    return [NSString stringWithFormat:@"%@?query=%@",[self getRunMqlQueryUrl],allTypesOfBookDomainQuery];
}

-(NSString* )encodeUrl:(NSString*)url
{
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(NSString* )getRunMqlQueryUrl
{
    return [NSString stringWithFormat:@"%@%@",
           [self getBaseUrl],
           [freebaseUrls objectForKey:@"run_query_url"]];
}

-(NSDictionary* )getFreebaseBaseUrls
{
    NSString* path =  [[NSBundle mainBundle] pathForResource:@"freebase_urls" ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:path];
}


-(NSString*) getBaseUrl
{
    return [freebaseUrls objectForKey:@"api_base_url"];
}


-(NSDictionary* )getMQLQueries
{
    NSString* path =  [[NSBundle mainBundle] pathForResource:@"mql_queries" ofType:@"plist"];
    
    return [[NSDictionary alloc] initWithContentsOfFile:path];
}

-(void)getBookDomainTypes
{

}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    [bookTypesData appendData:data];
}



@end
