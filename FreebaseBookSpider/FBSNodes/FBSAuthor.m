//
//  FBSAuthorNode.m
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

#import "FBSAuthor.h"
#import "FBSPropertyValue.h"
#import "FBSProperty.h"


 NSString * const FB_DESCRIPTION_KEY          = @"/common/topic/description";
 NSString * const FB_DESCRIPTION_LABEL        = @"Description";
 NSString * const FB_DATE_OF_BIRTH_KEY        = @"/people/person/date_of_birth";
 NSString * const FB_DATE_OF_BIRTH_LABEL      = @"Date of birth";
 NSString * const FB_PLACE_OF_BIRTH_KEY       = @"/people/person/place_of_birth";
 NSString * const FB_PLACE_OF_BIRTH_LABEL     = @"Place of birth";
 NSString * const FB_NATIONALITY_KEY          = @"/people/person/nationality";
 NSString * const FB_NATIONALITY_LABEL        = @"Nationality";
 NSString * const FB_GENDER_KEY               = @"/people/person/gender";
 NSString * const FB_GENDER_LABEL             = @"Gender";
 NSString * const FB_PROFESSION_KEY           = @"/people/person/profession";
 NSString * const FB_PROFESSION_LABEL         = @"Profession";
 NSString * const FB_REGION_KEY               = @"/people/person/religion";
 NSString * const FB_REGION_LABEL             = @"Religion";
 NSString * const FB_PARENTS_KEY              = @"/people/person/parents";
 NSString * const FB_PARENTS_LABEL            = @"Parents";
 NSString * const FB_CHILDREN_KEY             = @"/people/person/children";
 NSString * const FB_CHILDREN_LABEL           = @"Children";
 NSString * const FB_SPOUSES_KEY              = @"/people/person/spouse_s";
 NSString * const FB_SPOUSES_LABEL            = @"Spouses";
 NSString * const FB_EMPLOYMENT_HISTORY_KEY   = @"/people/person/employment_history";
 NSString * const FB_EMPLOYMENT_HISTORY_LABEL = @"Employment history";
 NSString * const FB_EDUCATION_KEY            = @"/people/person/education";
 NSString * const FB_EDUCATION_LABEL          = @"Education";
 NSString * const FB_QUOTATIONS_KEY           = @"/people/person/quotations";
 NSString * const FB_QUOTATIONS_LABEL         = @"Quotations";
 NSString * const FB_PLACES_LIVED_KEY         = @"/people/person/places_lived";
 NSString * const FB_PLACES_LIVED_LABEL       = @"Places lived";
 NSString * const FB_LANGUAGES_KEY            = @"/people/person/languages";
 NSString * const FB_LANGUAGES_LABEL          = @"Languages";
 NSString * const FB_DATE_OF_DEATH_KEY        = @"/people/deceased_person/date_of_death";
 NSString * const FB_DATE_OF_DEATH_LABEL      = @"Date of death";
 NSString * const FB_PLACE_OF_DEATH_KEY       = @"/people/deceased_person/place_of_death";
 NSString * const FB_PLACE_OF_DEATH_LABEL     = @"Place of death";
 NSString * const FB_CAUSE_OF_DEATH_KEY       = @"/people/deceased_person/cause_of_death";
 NSString * const FB_CAUSE_OF_DEATH_LABEL     = @"Cause of death";
 NSString * const FB_WORKS_WRITTEN_KEY        = @"/book/author/works_written";
 NSString * const FB_WORKS_WRITTEN_LABEL      = @"Works written";
 NSString * const FB_INFLUENCED_BY_KEY        = @"/influence/influence_node/influenced_by";
 NSString * const FB_INFLUENCED_BY_LABEL      = @"Influenced by";
 NSString * const FB_INFLUENCED_KEY           = @"/influence/influence_node/influenced";
 NSString * const FB_INFLUENCED_LABEL         = @"Influenced";

@implementation FBSAuthor

-(id)initWithFBSNode:(FBSNode *)aNode properties:(NSDictionary *)theProperties
{
    self = [super initWithFBSNode:aNode type:FBSNodeAuthorType description:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_DESCRIPTION_KEY] label:FB_DESCRIPTION_LABEL] autorelease]];
    if(self){
        
        
        // -- summary -- //
        //date of birth
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_DATE_OF_BIRTH_KEY] label:FB_DATE_OF_BIRTH_LABEL] autorelease] forKey:FB_DATE_OF_BIRTH_KEY];
        // place of birth
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_PLACE_OF_BIRTH_KEY] label:FB_PLACE_OF_BIRTH_LABEL] autorelease] forKey:FB_PLACE_OF_BIRTH_KEY];
        //date of death
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_DATE_OF_DEATH_KEY] label:FB_DATE_OF_DEATH_LABEL] autorelease] forKey:FB_DATE_OF_DEATH_KEY];
        // place of death
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_PLACE_OF_DEATH_KEY] label:FB_PLACE_OF_DEATH_LABEL] autorelease] forKey:FB_PLACE_OF_DEATH_KEY];
        // profession
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_PROFESSION_KEY] label:FB_PROFESSION_LABEL] autorelease] forKey:FB_PROFESSION_KEY];
        // gender
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_GENDER_KEY] label:FB_GENDER_LABEL] autorelease] forKey:FB_GENDER_KEY];
        // nationality
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_NATIONALITY_KEY] label:FB_NATIONALITY_LABEL] autorelease] forKey:FB_NATIONALITY_KEY];
        // works written
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_WORKS_WRITTEN_KEY] label:FB_WORKS_WRITTEN_LABEL] autorelease] forKey:FB_WORKS_WRITTEN_KEY];
        
        // -- details -- //
        // religion
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_REGION_KEY] label:FB_REGION_LABEL] autorelease] forKey:FB_REGION_KEY];
        // parents
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_PARENTS_KEY] label:FB_PARENTS_LABEL] autorelease] forKey:FB_PARENTS_KEY];
        // children
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_CHILDREN_KEY] label:FB_CHILDREN_LABEL] autorelease] forKey:FB_CHILDREN_KEY];
        // spouses
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_SPOUSES_KEY] label:FB_SPOUSES_LABEL] autorelease] forKey:FB_SPOUSES_KEY];
        // employment history
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_EMPLOYMENT_HISTORY_KEY] label:FB_EMPLOYMENT_HISTORY_LABEL] autorelease] forKey:FB_EMPLOYMENT_HISTORY_KEY];
        // education
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_EDUCATION_KEY] label:FB_EDUCATION_LABEL] autorelease] forKey:FB_EDUCATION_KEY];
        // quotations
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_QUOTATIONS_KEY] label:FB_QUOTATIONS_LABEL] autorelease] forKey:FB_QUOTATIONS_KEY];
        // places lived
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_PLACES_LIVED_KEY] label:FB_PLACES_LIVED_LABEL] autorelease] forKey:FB_PLACES_LIVED_KEY];
        // languages
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_LANGUAGES_KEY] label:FB_LANGUAGES_LABEL] autorelease] forKey:FB_LANGUAGES_KEY];
        // cause of death
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_CAUSE_OF_DEATH_KEY] label:FB_CAUSE_OF_DEATH_LABEL] autorelease] forKey:FB_CAUSE_OF_DEATH_KEY];
        // influenced by
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_INFLUENCED_BY_KEY] label:FB_INFLUENCED_BY_LABEL] autorelease] forKey:FB_INFLUENCED_BY_KEY];
        // influenced
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_INFLUENCED_KEY] label:FB_INFLUENCED_LABEL] autorelease] forKey:FB_INFLUENCED_KEY];
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}


@end
