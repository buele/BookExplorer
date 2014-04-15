//
//  FBSBook.m
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

#import "FBSBook.h"

@implementation FBSBook



static NSString * FB_ALIAS_KEY                      = @"/common/topic/alias";
static NSString * FB_DESCRIPTION_KEY                = @"/common/topic/description";
static NSString * FB_IMAGE_KEY                      = @"/common/topic/image";
static NSString * FB_GENRE_KEY                      = @"/book/book/genre";
static NSString * FB_CHARACTERS_KEY                 = @"/book/book/characters";
static NSString * FB_QUOTATIONS_KEY                 = @"/media_common/quotation_source/quotations";
static NSString * FB_AUTHOR_KEY                     = @"/book/written_work/author";
static NSString * FB_DATE_WRITTEN_KEY               = @"/book/written_work/date_written";
static NSString * FB_COPYRIGHT_DATE_KEY             = @"/book/written_work/copyright_date";
static NSString * FB_DATE_OF_FIRST_PUBBLICATION_KEY = @"/book/written_work/date_of_first_pubblication";
static NSString * FB_SUBJECTS_KEY                   = @"/book/written_work/subjects";
static NSString * FB_ORIGINAL_LANGUAGE_KEY          = @"/book/written_work/original_language";
static NSString * FB_PREVIOUS_IN_SERIES_KEY         = @"/book/written_work/previous_in_series";
static NSString * FB_ISFDB_ID_KEY                   = @"/book/written_work/isfdb_id";
static NSString * FB_NEXT_IN_SERIES_KEY             = @"/book/written_work/next_in_series";
static NSString * FB_INFLUENCED_BY_KEY              = @"/influence/influence_node/influenced_by";
static NSString * FB_INFLUENCED_KEY                 = @"/influence/influence_node/influenced";

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
    self.alias                      = [properties objectForKey:FB_ALIAS_KEY];
    self.description                = [properties objectForKey:FB_DESCRIPTION_KEY];
    self.imageId                    = [properties objectForKey:FB_IMAGE_KEY];
    self.genre                      = [properties objectForKey:FB_GENRE_KEY];
    self.characters                 = [properties objectForKey:FB_CHARACTERS_KEY];
    self.quotations                 = [properties objectForKey:FB_QUOTATIONS_KEY];
    self.author                     = [properties objectForKey:FB_AUTHOR_KEY];
    self.dateWritten                = [properties objectForKey:FB_DATE_WRITTEN_KEY];
    self.copyrightDate              = [properties objectForKey:FB_COPYRIGHT_DATE_KEY];
    self.dateOfFirstPubblication    = [properties objectForKey:FB_DATE_OF_FIRST_PUBBLICATION_KEY];
    self.subjects                   = [properties objectForKey:FB_SUBJECTS_KEY];
    self.originalLanguage           = [properties objectForKey:FB_ORIGINAL_LANGUAGE_KEY];
    self.previousInSeries           = [properties objectForKey:FB_PREVIOUS_IN_SERIES_KEY];
    self.isfdbId                    = [properties objectForKey:FB_ISFDB_ID_KEY];
    self.nextInSeries               = [properties objectForKey:FB_NEXT_IN_SERIES_KEY];
    self.influencedBy               = [properties objectForKey:FB_INFLUENCED_BY_KEY];
    self.influenced                 = [properties objectForKey:FB_INFLUENCED_KEY];
}

@end
