//
//  FBSNodeManager.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 14/04/14.

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

#import "FBSNodeManager.h"
#import "FBSBookTopicGenerator.h"
#import "FBSAuthorTopicGenerator.h"
#import "../FBSApiManager/FBSApiManager.h"
#import "FBSNodeTypes.h"
#import "FBSPedingNodeRequest.h"
#import "FBSPendingTopicRequest.h"
#import "FBSPendingNodesRequestsByKeyword.h"

@implementation FBSNodeManager


-(id)init
{
    self = [super init];
    if(self){
        pendingNodeRequests = [[NSMutableDictionary alloc]init];
        pendingTopicRequests = [[NSMutableDictionary alloc]init];
        pendingNodesRequestsByKeyword = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void)nodeWithId:(NSString *)aNodeId andWithName:(NSString *)aNodeName forDelegate:(id)delegate
{
    FBSPedingNodeRequest * nodeRequest = [[FBSPedingNodeRequest alloc]initWithNodeId:aNodeId andNodeName:aNodeName forTarget:delegate];
    [pendingNodeRequests setObject:nodeRequest forKey:aNodeId];
    [[FBSApiManager getSharedInstance] getNodePropertiesById:aNodeId andForDelegate:self];
}

-(void)nodesByKeyword:(NSString *)aKeyword forDelegate:(id)delegate
{
    FBSPendingNodesRequestsByKeyword * nodesRequest = [[FBSPendingNodesRequestsByKeyword alloc]initWithKeyword:aKeyword target:delegate];
    [pendingNodesRequestsByKeyword setObject:nodesRequest forKey:aKeyword];
    [[FBSApiManager getSharedInstance] getNodesByKeyword:aKeyword andForDelegate:self];
}

-(void)nodesByKeywordDidReceived:(NSDictionary*)nodes forKey:(NSString *)key
{
    //NSLog(@"nodes: %@",nodes);
    NSMutableArray * generatedNodes = [[NSMutableArray alloc]init];
    for (NSDictionary * item in nodes) {
        FBSNode * node = [[FBSNode alloc]initWithId:[item objectForKey:@"id"] lang:[item objectForKey:@"lang"] mid:[item objectForKey:@"mid"] name:[item objectForKey:@"name"] notableId:[[item objectForKey:@"notable"] objectForKey:@"id"] notableName:[[item objectForKey:@"notable"] objectForKey:@"name"]];
        [generatedNodes addObject:node];
    }
    FBSPendingNodesRequestsByKeyword * nodesRequest = [pendingNodesRequestsByKeyword objectForKey:key];
    [nodesRequest.target nodesByKeywordDidReceived:generatedNodes forKey:key];
    [pendingNodesRequestsByKeyword removeObjectForKey:key];
    
}

-(void)topicWithNode:(FBSNode *)aNode forDelegate:(id)aDelegate
{
    FBSPendingTopicRequest * pendingTopicRequest = [[FBSPendingTopicRequest alloc]initWithNode:aNode delegate:aDelegate];
    [pendingTopicRequests setObject:pendingTopicRequest forKey:aNode.nodeId];
    [[FBSApiManager getSharedInstance] getNodePropertiesById:aNode.nodeId andForDelegate:self];
}



-(void)topicDidGenerated:(FBSTopic *)theTopic withId:theTopicId
{
    FBSPendingTopicRequest * pendingRequest = [pendingTopicRequests objectForKey:theTopicId];
    [pendingRequest.delegate topicDidGenerated:theTopic withId:theTopicId];
    [pendingTopicRequests removeObjectForKey:theTopicId];
}

-(void)nodePropertiesByIdDidReceived:(NSDictionary*)properties forKey:(NSString *)key
{
    FBSNodeTypes nodeType = [self determineNodeTypeByProperties:properties];
    switch (nodeType) {
        case FBSNodeBookType:
            [self generateTopicBookWithProperties:properties forKey:key];
            break;
        case FBSNodeAuthorType:
            [self generateTopicAuthorWithProperties:properties forKey:key];
            break;
        default:
            break;
    }
}

-(void)generateTopicAuthorWithProperties:(NSDictionary *)properties forKey:(NSString *)key
{
    FBSPendingTopicRequest * pendingRequest = [pendingTopicRequests objectForKey:key];
    FBSAuthorTopicGenerator * authorGenerator = [[FBSAuthorTopicGenerator alloc] init];
    [authorGenerator topicWithNode:pendingRequest.node properties:properties toDelegate:self];
}


-(void)generateTopicBookWithProperties:(NSDictionary *)properties forKey:(NSString *)key
{
    FBSPendingTopicRequest * pendingRequest = [pendingTopicRequests objectForKey:key];
    FBSBookTopicGenerator * bookGenerator = [[FBSBookTopicGenerator alloc] init];
    [bookGenerator topicWithNode:pendingRequest.node properties:properties toDelegate:self];
}

-(FBSNodeTypes)determineNodeTypeByProperties:(NSDictionary *)properties
{
    int bookPropertiesCounter   = 0;
    int authorPropertiesCounter = 0;
    NSArray * bookProperties = @[@"/book/book/genre", @"/book/book/characters",@"/media_common/quotation_source/quotations",@"/book/written_work/author",@"/book/written_work/date_written",@"/book/written_work/copyright_date",@"/book/written_work/date_of_first_pubblication",@"/book/written_work/subjects",@"/book/written_work/original_language",@"/book/written_work/previous_in_series",@"/book/written_work/isfdb_id",@"/book/written_work/next_in_series",@"/influence/influence_node/influenced_by",@"/influence/influence_node/influenced"];
    
    NSArray * authorProperties = @[@"/common/topic/description", @"/common/topic/image",@"/people/person/date_of_birth",@"/people/person/place_of_birth",@"/people/person/nationality",@"/people/person/gender",@"/people/person/profession",@"/people/person/religion", @"/people/person/parents", @"/people/person/children", @"/people/person/spouse_s",@"/people/person/employment_history",@"/people/person/education",@"/people/person/quotations",@"/people/person/places_lived",@"/people/person/languages",@"/people/deceased_person/date_of_death",@"/people/deceased_person/place_of_death",@"/people/deceased_person/cause_of_death",@"/book/author/works_written",@"/influence/influence_node/influenced_by",@"/influence/influence_node/influenced"];
    for (NSString * key in bookProperties)if([properties objectForKey:key]) bookPropertiesCounter++;
    for (NSString * key in authorProperties)if([properties objectForKey:key]) authorPropertiesCounter++;
    
    return (bookPropertiesCounter > authorPropertiesCounter)?FBSNodeBookType:FBSNodeAuthorType;
}

@end
