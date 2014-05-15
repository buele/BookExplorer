//
//  FBSAuthorNode.h
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

#import "FBSTopic.h"
#import "FBSProperty.h"

extern NSString * const FB_DESCRIPTION_KEY;
extern NSString * const FB_DESCRIPTION_LABEL;
extern NSString * const FB_DATE_OF_BIRTH_KEY;
extern NSString * const FB_DATE_OF_BIRTH_LABEL;
extern NSString * const FB_PLACE_OF_BIRTH_KEY;
extern NSString * const FB_PLACE_OF_BIRTH_LABEL;
extern NSString * const FB_NATIONALITY_KEY;
extern NSString * const FB_NATIONALITY_LABEL;
extern NSString * const FB_GENDER_KEY;
extern NSString * const FB_GENDER_LABEL;
extern NSString * const FB_PROFESSION_KEY;
extern NSString * const FB_PROFESSION_LABEL;
extern NSString * const FB_REGION_KEY;
extern NSString * const FB_REGION_LABEL;
extern NSString * const FB_PARENTS_KEY;
extern NSString * const FB_PARENTS_LABEL;
extern NSString * const FB_CHILDREN_KEY;
extern NSString * const FB_CHILDREN_LABEL;
extern NSString * const FB_SPOUSES_KEY;
extern NSString * const FB_SPOUSES_LABEL;
extern NSString * const FB_EMPLOYMENT_HISTORY_KEY;
extern NSString * const FB_EMPLOYMENT_HISTORY_LABEL;
extern NSString * const FB_EDUCATION_KEY;
extern NSString * const FB_EDUCATION_LABEL;
extern NSString * const FB_QUOTATIONS_KEY;
extern NSString * const FB_QUOTATIONS_LABEL;
extern NSString * const FB_PLACES_LIVED_KEY;
extern NSString * const FB_PLACES_LIVED_LABEL;
extern NSString * const FB_LANGUAGES_KEY;
extern NSString * const FB_LANGUAGES_LABEL;
extern NSString * const FB_DATE_OF_DEATH_KEY;
extern NSString * const FB_DATE_OF_DEATH_LABEL;
extern NSString * const FB_PLACE_OF_DEATH_KEY;
extern NSString * const FB_PLACE_OF_DEATH_LABEL;
extern NSString * const FB_CAUSE_OF_DEATH_KEY;
extern NSString * const FB_CAUSE_OF_DEATH_LABEL;
extern NSString * const FB_WORKS_WRITTEN_KEY;
extern NSString * const FB_WORKS_WRITTEN_LABEL;
extern NSString * const FB_INFLUENCED_BY_KEY;
extern NSString * const FB_INFLUENCED_BY_LABEL;
extern NSString * const FB_INFLUENCED_KEY;
extern NSString * const FB_INFLUENCED_LABEL;

@interface FBSAuthor : FBSTopic

@end
