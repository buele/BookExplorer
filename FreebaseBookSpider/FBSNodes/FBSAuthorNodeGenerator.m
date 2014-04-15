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

@implementation FBSAuthorNodeGenerator
static NSString * FB_DESCRIPTION_KEY        = @"/common/topic/description";
static NSString * FB_IMAGE_KEY              = @"/common/topic/image";
static NSString * FB_DATE_OF_BIRTH_KEY      = @"/people/person/date_of_birth";
static NSString * FB_PLACE_OF_BIRTH_KEY     = @"/people/person/place_of_birth";
static NSString * FB_NATIONALITY_KEY        = @"/people/person/nationality";
static NSString * FB_GENDER_KEY             = @"/people/person/gender";
static NSString * FB_PROFESSION_KEY         = @"/people/person/profession";
static NSString * FB_REGION_KEY             = @"/people/person/religion";
static NSString * FB_PARENTS_KEY            = @"/people/person/parents";
static NSString * FB_CHILDREN_KEY           = @"/people/person/children";
static NSString * FB_SPOUSES_KEY            = @"/people/person/spouse_s";
static NSString * FB_EMPLOYMENT_HISTORY_KEY = @"/people/person/employment_history";
static NSString * FB_EDUCATION_KEY          = @"/people/person/education";
static NSString * FB_QUOTATIONS_KEY         = @"/people/person/quotations";
static NSString * FB_PLACES_LIVED_KEY       = @"/people/person/places_lived";
static NSString * FB_LANGUAGES_KEY          = @"/people/person/languages";
static NSString * FB_DATE_OF_DEATH_KEY      = @"/people/deceased_person/date_of_death";
static NSString * FB_PLACE_OF_DEATH_KEY     = @"/people/deceased_person/place_of_death";
static NSString * FB_CAUSE_OF_DEATH_KEY     = @"/people/deceased_person/cause_of_death";
static NSString * FB_WORKS_WRITTEN_KEY      = @"/book/author/works_written";
static NSString * FB_INFLUENCED_BY_KEY      = @"/influence/influence_node/influenced_by";
static NSString * FB_INFLUENCED_KEY         = @"/influence/influence_node/influenced";


-(void) nodeWithId:(NSString *)aNodeId andName:(NSString *)aName andProperties:(NSDictionary *)properties toDelegate:(id)aDelegate
{
    FBSAuthorNode * author = [[FBSAuthorNode alloc] init];
    author.nodeId             = aNodeId;
    author.name               = aName;
    author.description        = [properties objectForKey:FB_DESCRIPTION_KEY];
    author.dateOfBirth        = [properties objectForKey:FB_DATE_OF_BIRTH_KEY];
    author.placeOfBirth       = [properties objectForKey:FB_PLACE_OF_BIRTH_KEY];
    author.nationality        = [properties objectForKey:FB_NATIONALITY_KEY];
    author.gender             = [properties objectForKey:FB_GENDER_KEY];
    author.profession         = [properties objectForKey:FB_PROFESSION_KEY];
    author.religion           = [properties objectForKey:FB_REGION_KEY];
    author.parents            = [properties objectForKey:FB_PARENTS_KEY];
    author.children           = [properties objectForKey:FB_CHILDREN_KEY];
    author.spouseS            = [properties objectForKey:FB_SPOUSES_KEY];
    author.employmentHistory  = [properties objectForKey:FB_EMPLOYMENT_HISTORY_KEY];
    author.education          = [properties objectForKey:FB_EDUCATION_KEY];
    author.quotations         = [properties objectForKey:FB_QUOTATIONS_KEY];
    author.placesLived        = [properties objectForKey:FB_PLACES_LIVED_KEY];
    author.languages          = [properties objectForKey:FB_LANGUAGES_KEY];
    author.dateOfDeath        = [properties objectForKey:FB_DATE_OF_DEATH_KEY];
    author.placeOfDeath       = [properties objectForKey:FB_PLACE_OF_DEATH_KEY];
    author.causeOfDeath       = [properties objectForKey:FB_CAUSE_OF_DEATH_KEY];
    author.worksWritten       = [properties objectForKey:FB_WORKS_WRITTEN_KEY];
    author.influencedBy       = [properties objectForKey:FB_INFLUENCED_BY_KEY];
    author.influenced         = [properties objectForKey:FB_INFLUENCED_KEY];
    [self  requestImageWithId:[properties objectForKey:FB_IMAGE_KEY] forNode:author forTarget:aDelegate];
}

@end
