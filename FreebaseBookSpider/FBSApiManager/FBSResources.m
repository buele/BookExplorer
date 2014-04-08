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
static NSString *  FREEBASE_URLS_FILE_NAME                      = @"freebase_urls";
static NSString *  FREEBASE_URLS_FILE_EXT                       = @"plist";
static NSString *  MQL_QUERIES_FILE_NAME                        = @"mql_queries";
static NSString *  MQL_QUERIES_FILE_EXT                         = @"plist";
static NSString *  FREEBASE_API_BASE_URL_KEY                    = @"api_base_url";
static NSString *  FREEBASE_RUN_QUERY_URL_KEY                   = @"run_query_url";
static NSString *  FREEBASE_ENTITIES_BY_KEYWORD_PARAMETERS_KEY  = @"entities_by_keyword_parameters";
static NSString *  FREEBASE_LANGUAGE_PARAMETER_KEY              = @"lang";
static NSString *  FREEBASE_QUERY_PARAMETER_KEY                 = @"query";
static NSString *  FREEBASE_MQL_QUERIES_BOOK_DOMAIN_TYPES_KEY   = @"get_book_domain_all_types";
static NSString *  FREEBASE_RESULT_RESPONSE_KEY                 = @"result";
static NSString *  FREEBASE_TYPE_FILTER_ITEM_KEY                = @"type";
static NSString *  FREEBASE_RESULT_ITEM_ID_KEY                  = @"id";


-(id)init
{
    self = [super init];
    if(self)
        [self loadResources];
    return self;
}

-(void)loadResources
{
    freebaseUrls = [self getFreebaseBaseUrls];
    mqlQueries = [self getMQLQueries];
}

-(NSDictionary* )getFreebaseBaseUrls
{
    NSString* path =  [[NSBundle mainBundle] pathForResource:FREEBASE_URLS_FILE_NAME ofType:FREEBASE_URLS_FILE_EXT];
    
    return [[NSDictionary alloc] initWithContentsOfFile:path];
}

-(NSDictionary* )getMQLQueries
{
    NSString* path =  [[NSBundle mainBundle] pathForResource:MQL_QUERIES_FILE_NAME ofType:MQL_QUERIES_FILE_EXT];
    
    return [[NSDictionary alloc] initWithContentsOfFile:path];
}

-(NSString*) getBaseUrl
{
    return [freebaseUrls objectForKey:FREEBASE_API_BASE_URL_KEY];
}

-(NSString* )getRunMqlQueryUrl
{
    return [NSString stringWithFormat:@"%@%@",
            [self getBaseUrl],
            [freebaseUrls objectForKey:FREEBASE_RUN_QUERY_URL_KEY]];
}

-(NSString* )encodeUrl:(NSString*)url
{
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(NSString* )getEntitiesByKeywordParameters
{
    return  [NSString stringWithFormat:@"%@%@",[freebaseUrls objectForKey:FREEBASE_ENTITIES_BY_KEYWORD_PARAMETERS_KEY],[self getLanguageParameter]];
}

-(NSString* )getLanguageParameter
{
    return [NSString stringWithFormat: @"&%@=%@",FREEBASE_LANGUAGE_PARAMETER_KEY,[[NSLocale preferredLanguages] objectAtIndex:0]];

}

#pragma mark main protocol
-(NSURL *)getAllTypesOfBookDomainUrl
{
    NSString * allTypesOfBookDomainQueryString = [NSString stringWithFormat:@"%@?%@=%@",[self getRunMqlQueryUrl],FREEBASE_QUERY_PARAMETER_KEY,[mqlQueries objectForKey:FREEBASE_MQL_QUERIES_BOOK_DOMAIN_TYPES_KEY]];
    return [[NSURL alloc ]initWithString:[self encodeUrl:allTypesOfBookDomainQueryString]];
}

-(void)generateEntitiesByKeywordUrlByTypes:(NSDictionary *)types
{
    static NSString *  FREEBASE_START_FILTER_REQUEST_STRING = @"(any";
    static NSString *  FREEBASE_END_FILTER_REQUEST_STRING   = @")";
    static NSString *  FREEBASE_SEARCH_PARAMETER_KEY        = @"search";
    static NSString *  FREEBASE_FILTER_PARAMETER_KEY        = @"filter";
    
    NSMutableString* typesFilter = [[NSMutableString alloc ]initWithString:FREEBASE_START_FILTER_REQUEST_STRING];
    for (NSDictionary* item in [types objectForKey:FREEBASE_RESULT_RESPONSE_KEY])
        [typesFilter appendString:[NSString stringWithFormat:@"+%@:%@",FREEBASE_TYPE_FILTER_ITEM_KEY, [item objectForKey:FREEBASE_RESULT_ITEM_ID_KEY]]];
    [typesFilter appendString:FREEBASE_END_FILTER_REQUEST_STRING];
    entitiesByKeywordBaseUrl =  [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@?%@=%@%@&%@=",[self getBaseUrl],FREEBASE_SEARCH_PARAMETER_KEY, FREEBASE_FILTER_PARAMETER_KEY,[self encodeUrl:typesFilter],[self getEntitiesByKeywordParameters],FREEBASE_QUERY_PARAMETER_KEY] ];
}

-(NSURL *)getBookEntitiesUrlByKeyword:(NSString * )keyword 
{
    NSString * keywordValue = [self encodeUrl:[keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    return (entitiesByKeywordBaseUrl)?
        [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@",
                                      entitiesByKeywordBaseUrl,
                                      keywordValue]]:
        [[NSURL alloc]initWithString:keyword];
}

@end
