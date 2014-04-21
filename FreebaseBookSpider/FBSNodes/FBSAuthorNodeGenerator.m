//
//  FBSAuthorNodeGenerator.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 11/04/14.

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

#import "FBSAuthorNodeGenerator.h"
#import "FBSAuthorNode.h"
#import "FBSPropertyValue.h"

@implementation FBSAuthorNodeGenerator
static NSString * FB_DESCRIPTION_KEY          = @"/common/topic/description";
static NSString * FB_DESCRIPTION_LABEL        = @"description";
static NSString * FB_IMAGE_KEY                = @"/common/topic/image";
static NSString * FB_IMAGE_LABEL              = @"image";
static NSString * FB_DATE_OF_BIRTH_KEY        = @"/people/person/date_of_birth";
static NSString * FB_DATE_OF_BIRTH_LABEL      = @"date_of_birth";
static NSString * FB_PLACE_OF_BIRTH_KEY       = @"/people/person/place_of_birth";
static NSString * FB_PLACE_OF_BIRTH_LABEL     = @"place_of_birth";
static NSString * FB_NATIONALITY_KEY          = @"/people/person/nationality";
static NSString * FB_NATIONALITY_LABEL        = @"nationality";
static NSString * FB_GENDER_KEY               = @"/people/person/gender";
static NSString * FB_GENDER_LABEL             = @"gender";
static NSString * FB_PROFESSION_KEY           = @"/people/person/profession";
static NSString * FB_PROFESSION_LABEL         = @"profession";
static NSString * FB_REGION_KEY               = @"/people/person/religion";
static NSString * FB_REGION_LABEL             = @"religion";
static NSString * FB_PARENTS_KEY              = @"/people/person/parents";
static NSString * FB_PARENTS_LABEL            = @"parents";
static NSString * FB_CHILDREN_KEY             = @"/people/person/children";
static NSString * FB_CHILDREN_LABEL           = @"children";
static NSString * FB_SPOUSES_KEY              = @"/people/person/spouse_s";
static NSString * FB_SPOUSES_LABEL            = @"spouse_s";
static NSString * FB_EMPLOYMENT_HISTORY_KEY   = @"/people/person/employment_history";
static NSString * FB_EMPLOYMENT_HISTORY_LABEL = @"employment_history";
static NSString * FB_EDUCATION_KEY            = @"/people/person/education";
static NSString * FB_EDUCATION_LABEL          = @"education";
static NSString * FB_QUOTATIONS_KEY           = @"/people/person/quotations";
static NSString * FB_QUOTATIONS_LABEL         = @"quotations";
static NSString * FB_PLACES_LIVED_KEY         = @"/people/person/places_lived";
static NSString * FB_PLACES_LIVED_LABEL       = @"places_lived";
static NSString * FB_LANGUAGES_KEY            = @"/people/person/languages";
static NSString * FB_LANGUAGES_LABEL          = @"languages";
static NSString * FB_DATE_OF_DEATH_KEY        = @"/people/deceased_person/date_of_death";
static NSString * FB_DATE_OF_DEATH_LABEL      = @"date_of_death";
static NSString * FB_PLACE_OF_DEATH_KEY       = @"/people/deceased_person/place_of_death";
static NSString * FB_PLACE_OF_DEATH_LABEL     = @"place_of_death";
static NSString * FB_CAUSE_OF_DEATH_KEY       = @"/people/deceased_person/cause_of_death";
static NSString * FB_CAUSE_OF_DEATH_LABEL     = @"cause_of_death";
static NSString * FB_WORKS_WRITTEN_KEY        = @"/book/author/works_written";
static NSString * FB_WORKS_WRITTEN_LABEL      = @"works_written";
static NSString * FB_INFLUENCED_BY_KEY        = @"/influence/influence_node/influenced_by";
static NSString * FB_INFLUENCED_BY_LABEL      = @"influenced_by";
static NSString * FB_INFLUENCED_KEY           = @"/influence/influence_node/influenced";
static NSString * FB_INFLUENCED_LABEL         = @"influenced";


-(void) nodeWithId:(NSString *)aNodeId name:(NSString *)aName properties:(NSDictionary *)properties toDelegate:(id)delegate
{
    FBSAuthorNode * author = [[FBSAuthorNode alloc] init];
    author.type = FBSNodeAuthorType;
    author.nodeId             = aNodeId;
    author.name               = aName;
    author.description        = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_DESCRIPTION_KEY] label:FB_DESCRIPTION_LABEL];
    author.dateOfBirth        = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_DATE_OF_BIRTH_KEY] label:FB_DATE_OF_BIRTH_LABEL];
    author.placeOfBirth       = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_PLACE_OF_BIRTH_KEY] label:FB_PLACE_OF_BIRTH_LABEL];
    author.nationality        = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_NATIONALITY_KEY] label:FB_NATIONALITY_LABEL];
    author.gender             = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_GENDER_KEY] label:FB_GENDER_LABEL];
    author.profession         = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_PROFESSION_KEY] label:FB_PROFESSION_LABEL];
    author.religion           = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_REGION_KEY] label:FB_REGION_LABEL];
    author.parents            = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_PARENTS_KEY] label:FB_PARENTS_LABEL];
    author.children           = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_CHILDREN_KEY] label:FB_CHILDREN_LABEL];
    author.spouseS            = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_SPOUSES_KEY] label:FB_SPOUSES_LABEL];
    author.employmentHistory  = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_EMPLOYMENT_HISTORY_KEY] label:FB_EMPLOYMENT_HISTORY_LABEL];
    author.education          = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_EDUCATION_KEY] label:FB_EDUCATION_LABEL];
    author.quotations         = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_QUOTATIONS_KEY] label:FB_QUOTATIONS_LABEL];
    author.placesLived        = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_PLACES_LIVED_KEY] label:FB_PLACES_LIVED_LABEL];
    author.languages          = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_LANGUAGES_KEY] label:FB_LANGUAGES_LABEL];
    author.dateOfDeath        = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_DATE_OF_DEATH_KEY] label:FB_DATE_OF_DEATH_LABEL];
    author.placeOfDeath       = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_PLACE_OF_DEATH_KEY] label:FB_PLACE_OF_DEATH_LABEL];
    author.causeOfDeath       = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_CAUSE_OF_DEATH_KEY] label:FB_CAUSE_OF_DEATH_LABEL];
    author.worksWritten       = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_WORKS_WRITTEN_KEY] label:FB_WORKS_WRITTEN_LABEL];
    author.influencedBy       = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_INFLUENCED_BY_KEY] label:FB_INFLUENCED_BY_LABEL];
    author.influenced         = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_INFLUENCED_KEY] label:FB_INFLUENCED_LABEL];
    
    FBSProperty * imageProperty = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_IMAGE_KEY] label:FB_IMAGE_LABEL];
    
    if(imageProperty){
        FBSPropertyValue * value = [imageProperty.values objectAtIndex:0];
        [self  requestImageWithId:value.propertyId forNode:author toTarget:delegate];
    }
    else
        [delegate nodeDidGenerated:author withId:aNodeId];
}

@end
