//
//  FBSBookNode.h
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

//extern NSString * const FB_DESCRIPTION_KEY;
//extern NSString * const FB_DESCRIPTION_LABEL;

extern NSString * const FB_GENRE_KEY;
extern NSString * const FB_GENRE_LABEL;
extern NSString * const FB_CHARACTERS_KEY;
extern NSString * const FB_CHARACTERS_LABEL;
//extern NSString * const FB_QUOTATIONS_KEY;
//extern NSString * const FB_QUOTATIONS_LABEL;
extern NSString * const FB_AUTHOR_KEY;
extern NSString * const FB_AUTHOR_LABEL;
extern NSString * const FB_DATE_WRITTEN_KEY;
extern NSString * const FB_DATE_WRITTEN_LABEL;
extern NSString * const FB_COPYRIGHT_DATE_KEY;
extern NSString * const FB_COPYRIGHT_DATE_LABEL;
extern NSString * const FB_DATE_OF_FIRST_PUBBLICATION_KEY;
extern NSString * const FB_DATE_OF_FIRST_PUBBLICATION_LABEL;
extern NSString * const FB_SUBJECTS_KEY;
extern NSString * const FB_SUBJECTS_LABEL;
extern NSString * const FB_ORIGINAL_LANGUAGE_KEY;
extern NSString * const FB_ORIGINAL_LANGUAGE_LABEL;
extern NSString * const FB_PREVIOUS_IN_SERIES_KEY;
extern NSString * const FB_PREVIOUS_IN_SERIES_LABEL;
extern NSString * const FB_ISFDB_ID_KEY;
extern NSString * const FB_ISFDB_ID_LABEL;
extern NSString * const FB_NEXT_IN_SERIES_KEY;
extern NSString * const FB_NEXT_IN_SERIES_LABEL;
//extern NSString * const FB_INFLUENCED_BY_KEY;
//extern NSString * const FB_INFLUENCED_BY_LABEL;
//extern NSString * const FB_INFLUENCED_KEY;
//extern NSString * const FB_INFLUENCED_LABEL;

@interface FBSBook : FBSTopic

@end
