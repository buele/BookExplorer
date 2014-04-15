//
//  FBSAuthor.h
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

#import <Foundation/Foundation.h>

@interface FBSAuthor : NSObject

@property(nonatomic)NSString * id;
@property(nonatomic)NSString * name;
@property(nonatomic)NSString * description;         // /common/topic/description
@property(nonatomic)UIImage  * image;               // /common/topic/image
@property(nonatomic)NSDate   * dateOfBirth;         // /people/person/date_of_birth
@property(nonatomic)NSString * placeOfBirth;        // /people/person/place_of_birth
@property(nonatomic)NSArray  * nationality;         // /people/person/nationality
@property(nonatomic)NSString * gender;              // /people/person/gender
@property(nonatomic)NSArray  * profession;          // /people/person/profession
@property(nonatomic)NSArray  * religion;            // /people/person/religion
@property(nonatomic)NSArray  * parents;             // /people/person/parents
@property(nonatomic)NSArray  * children;            // /people/person/children
@property(nonatomic)NSArray  * spouseS;             // /people/person/spouse_s
@property(nonatomic)NSArray  * employmentHistory;   // /people/person/employment_history
@property(nonatomic)NSArray  * education;           // /people/person/education
@property(nonatomic)NSArray  * quotations;          // /people/person/quotations
@property(nonatomic)NSArray  * placesLived;         // /people/person/places_lived
@property(nonatomic)NSArray  * languages;           // /people/person/languages
@property(nonatomic)NSDate   * dateOfDeath;         // /people/deceased_person/date_of_death
@property(nonatomic)NSString * placeOfDeath;        // /people/deceased_person/place_of_death
@property(nonatomic)NSString * causeOfDeath;        // /people/deceased_person/cause_of_death
@property(nonatomic)NSArray  * worksWritten;        // /book/author/works_written
@property(nonatomic)NSArray  * influencedBy;        // /influence/influence_node/influenced_by
@property(nonatomic)NSArray  * influenced;          // /influence/influence_node/influenced

-(id)initWithId:(NSString* )id andName:(NSString *)name andProperties:(NSDictionary *)properties;

@end
