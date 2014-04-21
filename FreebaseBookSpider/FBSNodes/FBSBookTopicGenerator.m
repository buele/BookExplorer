//
//  FBSBookNodeGenerator.m
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

#import "FBSBookTopicGenerator.h"
#import "FBSBookTopic.h"
#import "FBSProperty.h"
#import "FBSPropertyValue.h"

@implementation FBSBookTopicGenerator

static NSString * FB_ALIAS_KEY                          = @"/common/topic/alias";
static NSString * FB_ALIAS_LABEL                        = @"alias";
static NSString * FB_DESCRIPTION_KEY                    = @"/common/topic/description";
static NSString * FB_DESCRIPTION_LABEL                  = @"description";
static NSString * FB_IMAGE_KEY                          = @"/common/topic/image";
static NSString * FB_IMAGE_LABEL                        = @"image";
static NSString * FB_GENRE_KEY                          = @"/book/book/genre";
static NSString * FB_GENRE_LABEL                        = @"genre";
static NSString * FB_CHARACTERS_KEY                     = @"/book/book/characters";
static NSString * FB_CHARACTERS_LABEL                   = @"characters";
static NSString * FB_QUOTATIONS_KEY                     = @"/media_common/quotation_source/quotations";
static NSString * FB_QUOTATIONS_LABEL                   = @"quotations";
static NSString * FB_AUTHOR_KEY                         = @"/book/written_work/author";
static NSString * FB_AUTHOR_LABEL                       = @"author";
static NSString * FB_DATE_WRITTEN_KEY                   = @"/book/written_work/date_written";
static NSString * FB_DATE_WRITTEN_LABEL                 = @"date_written";
static NSString * FB_COPYRIGHT_DATE_KEY                 = @"/book/written_work/copyright_date";
static NSString * FB_COPYRIGHT_DATE_LABEL               = @"copyright_date";
static NSString * FB_DATE_OF_FIRST_PUBBLICATION_KEY     = @"/book/written_work/date_of_first_pubblication";
static NSString * FB_DATE_OF_FIRST_PUBBLICATION_LABEL   = @"date_of_first_pubblication";
static NSString * FB_SUBJECTS_KEY                       = @"/book/written_work/subjects";
static NSString * FB_SUBJECTS_LABEL                     = @"subjects";
static NSString * FB_ORIGINAL_LANGUAGE_KEY              = @"/book/written_work/original_language";
static NSString * FB_ORIGINAL_LANGUAGE_LABEL            = @"original_language";
static NSString * FB_PREVIOUS_IN_SERIES_KEY             = @"/book/written_work/previous_in_series";
static NSString * FB_PREVIOUS_IN_SERIES_LABEL        	= @"previous_in_series";
static NSString * FB_ISFDB_ID_KEY                   	= @"/book/written_work/isfdb_id";
static NSString * FB_ISFDB_ID_LABEL                   	= @"isfdb_id";
static NSString * FB_NEXT_IN_SERIES_KEY             	= @"/book/written_work/next_in_series";
static NSString * FB_NEXT_IN_SERIES_LABEL               = @"next_in_series";
static NSString * FB_INFLUENCED_BY_KEY                  = @"/influence/influence_node/influenced_by";
static NSString * FB_INFLUENCED_BY_LABEL              	= @"influenced_by";
static NSString * FB_INFLUENCED_KEY                     = @"/influence/influence_node/influenced";
static NSString * FB_INFLUENCED_LABEL                   = @"influenced";



-(void) topicWithId:(NSString *)aNodeId name:(NSString *)aName properties:(NSDictionary *)properties toDelegate:(id)delegate
{

    FBSBookTopic * book = [[FBSBookTopic alloc] init];
    book.type = FBSNodeBookType;
    book.nodeId = aNodeId;    
    book.alias  = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_ALIAS_KEY] label:FB_ALIAS_LABEL];
    book.description = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_DESCRIPTION_KEY] label:FB_DESCRIPTION_LABEL];
    book.genre = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_GENRE_KEY] label:FB_GENRE_LABEL];
    book.characters = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_CHARACTERS_KEY] label:FB_CHARACTERS_LABEL];
    book.quotations = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_QUOTATIONS_KEY] label:FB_QUOTATIONS_LABEL];
    book.author  = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_AUTHOR_KEY] label:FB_AUTHOR_LABEL];
    book.dateWritten = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_DATE_WRITTEN_KEY] label:FB_DATE_WRITTEN_LABEL];
    book.copyrightDate = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_COPYRIGHT_DATE_KEY] label:FB_COPYRIGHT_DATE_LABEL];
    book.dateOfFirstPubblication = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_DATE_OF_FIRST_PUBBLICATION_KEY] label:FB_DATE_OF_FIRST_PUBBLICATION_LABEL];
    book.subjects = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_SUBJECTS_KEY] label:FB_SUBJECTS_LABEL];
    book.originalLanguage = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_ORIGINAL_LANGUAGE_KEY] label:FB_ORIGINAL_LANGUAGE_KEY];
    book.previousInSeries = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_PREVIOUS_IN_SERIES_KEY] label:FB_PREVIOUS_IN_SERIES_KEY];
    book.isfdbId = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_ISFDB_ID_KEY] label:FB_ISFDB_ID_LABEL];
    book.nextInSeries = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_NEXT_IN_SERIES_KEY] label:FB_NEXT_IN_SERIES_LABEL];
    book.influencedBy = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_INFLUENCED_BY_KEY] label:FB_INFLUENCED_BY_LABEL];
    book.influenced = [[FBSProperty alloc] initWithFreebaseProperty:[properties objectForKey:FB_INFLUENCED_KEY] label:FB_INFLUENCED_LABEL];

    
    FBSProperty * imageProperty = [properties objectForKey:FB_IMAGE_KEY];
    
    if(imageProperty){
        FBSPropertyValue * value = [imageProperty.values objectAtIndex:0];
        [self  requestImageWithId:value.propertyId forTopic:book toTarget:delegate];
    }
    else
        [delegate topicDidGenerated:book withId:aNodeId];
}



@end
