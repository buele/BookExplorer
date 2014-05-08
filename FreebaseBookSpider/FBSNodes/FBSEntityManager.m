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

#import "FBSEntityManager.h"
#import "../FBSApiManager/FBSApiManager.h"
#import "FBSNodeTypes.h"
#import "FBSBook.h"
#import "FBSPropertyValue.h"
#import "FBSAuthor.h"

@implementation FBSEntityManager
@synthesize delegate;
static NSString * FB_IMAGE_KEY   = @"/common/topic/image";
static NSString * FB_IMAGE_LABEL = @"image";

-(id)initWithDelegate:(id)aDelegate
{
    self = [super init];
    if(self){
        delegate = [aDelegate retain];
        pendingImageRequests = [[NSMutableDictionary alloc]init];
        pendingTopicRequests = [[NSMutableDictionary alloc]init];
    }
    return self;
}
#pragma mark main protocol


-(void)nodesByKeyword:(NSString *)aKeyword 
{
    [[FBSApiManager getSharedInstance] getNodesByKeyword:aKeyword andForDelegate:self];
}

-(void)topicWithNode:(FBSNode *)aNode
{
    [pendingTopicRequests setObject:aNode forKey:aNode.nodeId];
    [[FBSApiManager getSharedInstance] getNodePropertiesById:aNode.nodeId andForDelegate:self];
}

#pragma mark FBSApiManager protocol
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
    }
}


-(void)nodesByKeywordDidReceived:(NSDictionary*)nodes forKey:(NSString *)key
{
    NSMutableArray * generatedNodes = [[[NSMutableArray alloc]init] autorelease];
    for (NSDictionary * item in nodes) {
        FBSNode * node = [[FBSNode alloc]initWithId:[item objectForKey:@"id"] lang:[item objectForKey:@"lang"] mid:[item objectForKey:@"mid"] name:[item objectForKey:@"name"] notableId:[[item objectForKey:@"notable"] objectForKey:@"id"] notableName:[[item objectForKey:@"notable"] objectForKey:@"name"]];
        [generatedNodes addObject:node];
        [node release];
    }
    [delegate nodesByKeywordDidReceived:generatedNodes forKey:key];
}


-(void)imageByIdDidReceived:(UIImage*)image forKey:(NSString *)key
{
    FBSTopic * pendingTopic = [[pendingImageRequests objectForKey:key]retain] ;
    pendingTopic.image = image;
    [pendingImageRequests removeObjectForKey:key];
    [delegate topicDidGenerated:pendingTopic withId:pendingTopic.nodeId];
    [pendingTopic release];
}


#pragma mark private methods
-(void)generateTopicAuthorWithProperties:(NSDictionary *)properties forKey:(NSString *)key
{
    FBSNode * pendingNode = [pendingTopicRequests objectForKey:key];
    FBSAuthor * author = [FBSAuthor topicWithFBSNode:pendingNode properties:properties];
    FBSProperty * imageProperty = [[[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_IMAGE_KEY] label:FB_IMAGE_LABEL] autorelease]; //to check
    if(imageProperty && [imageProperty.values count] >0){
        FBSPropertyValue * value = [imageProperty.values objectAtIndex:0];
        [self  requestImageWithId:value.propertyId forTopic:author toTarget:self];
    }else{
        [self topicDidGenerated:author withId:key];
    }
}


-(void)topicDidGenerated:(FBSTopic *)theTopic withId:theTopicId
{

    [delegate topicDidGenerated:theTopic withId:theTopicId];

}


-(void)generateTopicBookWithProperties:(NSDictionary *)properties forKey:(NSString *)key
{
    FBSNode * pendingNode = [pendingTopicRequests objectForKey:key];
    FBSProperty * imageProperty = [[[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_IMAGE_KEY] label:FB_IMAGE_LABEL] autorelease] ;
    FBSBook * book = [FBSBook topicWithFBSNode:pendingNode properties:properties];
    if(imageProperty && [imageProperty.values count] >0 ){
        FBSPropertyValue * value = [imageProperty.values objectAtIndex:0];
        [self  requestImageWithId:value.propertyId forTopic:book toTarget:self];
    }else{
        [self topicDidGenerated:book withId:key];
    }
  
}

-(FBSNodeTypes)determineNodeTypeByProperties:(NSDictionary *)properties
{
    int bookPropertiesCounter   = 0;
    int authorPropertiesCounter = 0;
    NSArray * bookProperties = @[@"/book/book/genre", @"/book/book/characters",@"/media_common/quotation_source/quotations",@"/book/written_work/author",@"/book/written_work/date_written",@"/book/written_work/copyright_date",@"/book/written_work/date_of_first_pubblication",@"/book/written_work/subjects",@"/book/written_work/original_language",@"/book/written_work/previous_in_series",@"/book/written_work/isfdb_id",@"/book/written_work/next_in_series",@"/influence/influence_node/influenced_by",@"/influence/influence_node/influenced"]; // to check
    
    NSArray * authorProperties = @[@"/common/topic/description", @"/common/topic/image",@"/people/person/date_of_birth",@"/people/person/place_of_birth",@"/people/person/nationality",@"/people/person/gender",@"/people/person/profession",@"/people/person/religion", @"/people/person/parents", @"/people/person/children", @"/people/person/spouse_s",@"/people/person/employment_history",@"/people/person/education",@"/people/person/quotations",@"/people/person/places_lived",@"/people/person/languages",@"/people/deceased_person/date_of_death",@"/people/deceased_person/place_of_death",@"/people/deceased_person/cause_of_death",@"/book/author/works_written",@"/influence/influence_node/influenced_by",@"/influence/influence_node/influenced"]; // to check
    for (NSString * key in bookProperties)if([properties objectForKey:key]) bookPropertiesCounter++;
    for (NSString * key in authorProperties)if([properties objectForKey:key]) authorPropertiesCounter++;
    
    return (bookPropertiesCounter > authorPropertiesCounter)?FBSNodeBookType:FBSNodeAuthorType;
}

-(void)requestImageWithId:(NSString *)anImageId forTopic:(FBSTopic *)aTopic toTarget:(id)aTarget
{
    [pendingImageRequests setObject:aTopic forKey:anImageId];
    [[FBSApiManager getSharedInstance] getImageById:anImageId andForDelegate:self ];
}

-(void)dealloc
{
    [delegate release];
    [pendingImageRequests release];
    [pendingImageRequests release];
    [super dealloc];
}


@end
