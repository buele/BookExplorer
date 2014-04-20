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
#import "FBSBookNodeGenerator.h"
#import "FBSAuthorNodeGenerator.h"
#import "../FBSApiManager/FBSApiManager.h"
#import "FBSNodeTypes.h"
#import "FBSPedingNodeRequest.h"
@implementation FBSNodeManager


-(id)init
{
    self = [super init];
    if(self){
        pendingNodeRequests = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void)nodeWithId:(NSString *)aNodeId andWithName:(NSString *)aNodeName forDelegate:(id)delegate
{
    FBSPedingNodeRequest * nodeRequest = [[FBSPedingNodeRequest alloc]initWithNodeId:aNodeId andNodeName:aNodeName forTarget:delegate];
    [pendingNodeRequests setObject:nodeRequest forKey:aNodeId];
    [[FBSApiManager getSharedInstance] getNodePropertiesById:aNodeId andForDelegate:self];
}


-(void)generateNodeAuthorWithProperties:(NSDictionary *)properties forKey:(NSString *)key
{
    FBSPedingNodeRequest * pendingRequest = [pendingNodeRequests objectForKey:key];
    FBSAuthorNodeGenerator * authorGenerator = [[FBSAuthorNodeGenerator alloc] init];
    [authorGenerator nodeWithId:pendingRequest.nodeId name:pendingRequest.nodeName properties:properties toDelegate:self];
}

-(void)generateNodeBookWithProperties:(NSDictionary *)properties forKey:(NSString *)key
{
    FBSPedingNodeRequest * pendingRequest = [pendingNodeRequests objectForKey:key];
    FBSBookNodeGenerator * bookGenerator = [[FBSBookNodeGenerator alloc] init];
    [bookGenerator nodeWithId:pendingRequest.nodeId name:pendingRequest.nodeName properties:properties toDelegate:self];
    
}

-(void)nodeDidGenerated:(FBSNode *)theNewNode withId:newNodeId
{
    FBSPedingNodeRequest * pendingRequest = [pendingNodeRequests objectForKey:newNodeId];
    [pendingRequest.target nodeDidGenerated:theNewNode withId:newNodeId];
    [pendingNodeRequests removeObjectForKey:newNodeId];
}

-(void)nodePropertiesByIdDidReceived:(NSDictionary*)properties forKey:(NSString *)key
{
    FBSNodeTypes nodeType = [self determineNodeTypeByProperties:properties];
    switch (nodeType) {
        case FBSNodeBookType:
            [self generateNodeBookWithProperties:properties forKey:key];
            break;
        case FBSNodeAuthorType:
            [self generateNodeAuthorWithProperties:properties forKey:key];
            break;
        default:
            break;
    }
}

-(FBSNodeTypes)determineNodeTypeByProperties:(NSDictionary *)properties
{
    int bookPropertiesCounter   = 0;
    int authorPropertiesCounter = 0;
    NSArray *bookProperties = @[@"/book/book/genre", @"/book/book/characters",@"/media_common/quotation_source/quotations",@"/book/written_work/author",@"/book/written_work/date_written",@"/book/written_work/copyright_date",@"/book/written_work/date_of_first_pubblication",@"/book/written_work/subjects",@"/book/written_work/original_language",@"/book/written_work/previous_in_series",@"/book/written_work/isfdb_id",@"/book/written_work/next_in_series",@"/influence/influence_node/influenced_by",@"/influence/influence_node/influenced"];
    NSArray *authorProperties = @[@"/common/topic/description", @"/common/topic/image",@"/people/person/date_of_birth",@"/people/person/place_of_birth",@"/people/person/nationality",@"/people/person/gender",@"/people/person/profession",@"/people/person/religion", @"/people/person/parents", @"/people/person/children", @"/people/person/spouse_s",@"/people/person/employment_history",@"/people/person/education",@"/people/person/quotations",@"/people/person/places_lived",@"/people/person/languages",@"/people/deceased_person/date_of_death",@"/people/deceased_person/place_of_death",@"/people/deceased_person/cause_of_death",@"/book/author/works_written",@"/influence/influence_node/influenced_by",@"/influence/influence_node/influenced"];
    for (NSString * key in bookProperties)if([properties objectForKey:key]) bookPropertiesCounter++;
    for (NSString * key in authorProperties)if([properties objectForKey:key]) authorPropertiesCounter++;
    
    return (bookPropertiesCounter > authorPropertiesCounter)?FBSNodeBookType:FBSNodeAuthorType;


}

@end
