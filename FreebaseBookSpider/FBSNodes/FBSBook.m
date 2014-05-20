//
//  FBSBookNode.m
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

#import "FBSBook.h"

 NSString * const FB_GENRE_KEY                          = @"/book/book/genre";
 NSString * const FB_GENRE_LABEL                        = @"Genre";
 NSString * const FB_CHARACTERS_KEY                     = @"/book/book/characters";
 NSString * const FB_CHARACTERS_LABEL                   = @"Characters";
 NSString * const FB_AUTHOR_KEY                         = @"/book/written_work/author";
 NSString * const FB_AUTHOR_LABEL                       = @"Author";
 NSString * const FB_DATE_WRITTEN_KEY                   = @"/book/written_work/date_written";
 NSString * const FB_DATE_WRITTEN_LABEL                 = @"Date written";
 NSString * const FB_COPYRIGHT_DATE_KEY                 = @"/book/written_work/copyright_date";
 NSString * const FB_COPYRIGHT_DATE_LABEL               = @"Copyright date";
 NSString * const FB_DATE_OF_FIRST_PUBBLICATION_KEY     = @"/book/written_work/date_of_first_pubblication";
 NSString * const FB_DATE_OF_FIRST_PUBBLICATION_LABEL   = @"Date of first pubblication";
 NSString * const FB_SUBJECTS_KEY                       = @"/book/written_work/subjects";
 NSString * const FB_SUBJECTS_LABEL                     = @"Subjects";
 NSString * const FB_ORIGINAL_LANGUAGE_KEY              = @"/book/written_work/original_language";
 NSString * const FB_ORIGINAL_LANGUAGE_LABEL            = @"Original language";
 NSString * const FB_PREVIOUS_IN_SERIES_KEY             = @"/book/written_work/previous_in_series";
 NSString * const FB_PREVIOUS_IN_SERIES_LABEL        	= @"Previous in series";
 NSString * const FB_ISFDB_ID_KEY                   	= @"/book/written_work/isfdb_id";
 NSString * const FB_ISFDB_ID_LABEL                   	= @"isfdb_id";
 NSString * const FB_NEXT_IN_SERIES_KEY             	= @"/book/written_work/next_in_series";
 NSString * const FB_NEXT_IN_SERIES_LABEL               = @"Next in series";


@implementation FBSBook






-(id)initWithFBSNode:(FBSNode *)aNode properties:(NSDictionary *)theProperties
{
    self = [super initWithFBSNode:aNode type:FBSNodeBookType description:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_DESCRIPTION_KEY] label:FB_DESCRIPTION_LABEL] autorelease]];
    if(self){
        // genre
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_GENRE_KEY] label:FB_GENRE_LABEL] autorelease] forKey:FB_GENRE_KEY];
        // author
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_AUTHOR_KEY] label:FB_AUTHOR_LABEL] autorelease] forKey:FB_AUTHOR_KEY];
        // subjects
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_SUBJECTS_KEY] label:FB_SUBJECTS_LABEL] autorelease] forKey:FB_SUBJECTS_KEY];
        // date written
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_DATE_WRITTEN_KEY] label:FB_DATE_WRITTEN_LABEL] autorelease] forKey:FB_DATE_WRITTEN_KEY];
        // copyright date
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_COPYRIGHT_DATE_KEY] label:FB_COPYRIGHT_DATE_LABEL] autorelease] forKey:FB_COPYRIGHT_DATE_KEY];
        // date of first pubblication
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_DATE_OF_FIRST_PUBBLICATION_KEY] label:FB_DATE_OF_FIRST_PUBBLICATION_LABEL] autorelease] forKey:FB_DATE_OF_FIRST_PUBBLICATION_KEY];
        // quotations
         [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_QUOTATIONS_KEY] label:FB_QUOTATIONS_LABEL] autorelease] forKey:FB_QUOTATIONS_KEY];
        // characters
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_CHARACTERS_KEY] label:FB_CHARACTERS_LABEL] autorelease] forKey:FB_CHARACTERS_KEY];
        // original language
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_ORIGINAL_LANGUAGE_KEY] label:FB_ORIGINAL_LANGUAGE_LABEL] autorelease] forKey:FB_ORIGINAL_LANGUAGE_KEY];
        // previous in series
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_PREVIOUS_IN_SERIES_KEY] label:FB_PREVIOUS_IN_SERIES_LABEL] autorelease] forKey:FB_PREVIOUS_IN_SERIES_KEY];
        // next in series
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_NEXT_IN_SERIES_KEY] label:FB_NEXT_IN_SERIES_LABEL] autorelease] forKey:FB_NEXT_IN_SERIES_KEY];
        // influenced by
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_INFLUENCED_BY_KEY] label:FB_INFLUENCED_BY_LABEL] autorelease] forKey:FB_INFLUENCED_BY_KEY];
        // influenced
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_INFLUENCED_KEY] label:FB_INFLUENCED_LABEL] autorelease] forKey:FB_INFLUENCED_KEY];
        // isfdbid
        [properties setObject:[[[FBSProperty alloc] initWithFreebaseProperty:[theProperties objectForKey:FB_ISFDB_ID_KEY] label:FB_ISFDB_ID_LABEL] autorelease] forKey:FB_ISFDB_ID_KEY];
        
    }
    return self;
}


-(void)dealloc
{
  
    [super dealloc];
}
@end
