//
//  FBSAuthor.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 10/04/14.
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

#import "FBSAuthor.h"

@implementation FBSAuthor

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

-(id)initWithId:(NSString* )id andName:(NSString *)name andProperties:(NSDictionary *)properties
{
    
    self = [super init];
    if(self){
        self.id = id;
        self.name = name;
        [self initProperties:properties];
    }
    return self;
    
}

-(void)initProperties:(NSDictionary *)properties
{
    self.id                 = [properties objectForKey:FB_DESCRIPTION_KEY];
    self.name               = [properties objectForKey:FB_IMAGE_KEY];
    self.description        = [properties objectForKey:FB_DATE_OF_BIRTH_KEY];
    self.image              = [properties objectForKey:FB_PLACE_OF_BIRTH_KEY];
    self.dateOfBirth        = [properties objectForKey:FB_NATIONALITY_KEY];
    self.placeOfBirth       = [properties objectForKey:FB_GENDER_KEY];
    self.nationality        = [properties objectForKey:FB_PROFESSION_KEY];
    self.gender             = [properties objectForKey:FB_GENDER_KEY];
    self.profession         = [properties objectForKey:FB_PROFESSION_KEY];
    self.religion           = [properties objectForKey:FB_REGION_KEY];
    self.parents            = [properties objectForKey:FB_PARENTS_KEY];
    self.children           = [properties objectForKey:FB_CHILDREN_KEY];
    self.spouseS            = [properties objectForKey:FB_SPOUSES_KEY];
    self.employmentHistory  = [properties objectForKey:FB_EMPLOYMENT_HISTORY_KEY];
    self.education          = [properties objectForKey:FB_EDUCATION_KEY];
    self.quotations         = [properties objectForKey:FB_QUOTATIONS_KEY];
    self.placesLived        = [properties objectForKey:FB_PLACES_LIVED_KEY];
    self.languages          = [properties objectForKey:FB_LANGUAGES_KEY];
    self.dateOfDeath        = [properties objectForKey:FB_DATE_OF_DEATH_KEY];
    self.placeOfDeath       = [properties objectForKey:FB_PLACE_OF_DEATH_KEY];
    self.causeOfDeath       = [properties objectForKey:FB_CAUSE_OF_DEATH_KEY];
    self.worksWritten       = [properties objectForKey:FB_WORKS_WRITTEN_KEY];
    self.influencedBy       = [properties objectForKey:FB_INFLUENCED_BY_KEY];
    self.influenced         = [properties objectForKey:FB_INFLUENCED_KEY];
}

@end