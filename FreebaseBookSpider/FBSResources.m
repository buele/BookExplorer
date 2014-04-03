//
//  UrlRepository.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 03/04/14.
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

#import "FBSResources.h"


@implementation FBSResources

-(id)init
{
    self = [super init];
    if(self){
        [self loadResources];
    }
    return self;
}

-(void)loadResources
{
    freebaseUrls = [self getFreebaseBaseUrls];
    mqlQueries = [self getMQLQueries];
}

-(NSDictionary* )getFreebaseBaseUrls
{
    NSString* path =  [[NSBundle mainBundle] pathForResource:@"freebase_urls" ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:path];
}

-(NSDictionary* )getMQLQueries
{
    NSString* path =  [[NSBundle mainBundle] pathForResource:@"mql_queries" ofType:@"plist"];
    
    return [[NSDictionary alloc] initWithContentsOfFile:path];
}

-(NSString*) getBaseUrl
{
    return [freebaseUrls objectForKey:@"api_base_url"];
}

-(NSString* )getRunMqlQueryUrl
{
    return [NSString stringWithFormat:@"%@%@",
            [self getBaseUrl],
            [freebaseUrls objectForKey:@"run_query_url"]];
}

-(NSString* )encodeUrl:(NSString*)url
{
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark main protocol
-(NSURL *)getAllTypesOfBookDomainUrl
{
    NSString * allTypesOfBookDomainMQLQuery = [mqlQueries objectForKey:@"get_book_domain_all_types"];
    NSString * allTypesOfBookDomainQueryString = [NSString stringWithFormat:@"%@?query=%@",[self getRunMqlQueryUrl],allTypesOfBookDomainMQLQuery];
    NSURL* url =  [[NSURL alloc ]initWithString:[self encodeUrl:allTypesOfBookDomainQueryString]];
    return url;
}


@end
